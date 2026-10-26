"""Diagnostic gate for exact parameter-rung candidates; never a result producer.
Read a JSON syntax tree, unchanged contours and candidate predictions. Integrate
with three mesh/tail settings. No eval, external imports from campaign files,
coefficient fitting, or reading of result libraries.
"""
import functools
import json
import math
import sys
import numpy as np
from scipy import special
from scipy.stats import qmc


def polygamma(k, z):
    if k == 0:
        return special.digamma(z)
    z = np.asarray(z, dtype=complex)
    n = max(0, int(math.ceil(14 - np.min(z.real))))
    corr = sum((-1)**(k+1)*math.factorial(k)/(z+j)**(k+1) for j in range(n))
    w = z+n
    ans = (-1)**(k-1)*math.factorial(k-1)/w**k + (-1)**(k+1)*math.factorial(k)/(2*w**(k+1))
    for r, b in enumerate((1/6, -1/30, 1/42, -1/30, 5/66, -691/2730), 1):
        ans += (-1)**(k+1)*b*math.factorial(2*r+k-1)/math.factorial(2*r)/w**(2*r+k)
    return ans+corr


def evaluate(tree, z, p):
    op, *args = tree
    if op == 'num':
        return complex(*args)
    if op == 'var':
        return z[args[0]]
    if op == 'param':
        return p[args[0]]
    a = [evaluate(t, z, p) for t in args]
    if op == 'Plus':
        return sum(a)
    if op == 'Times':
        return functools.reduce(lambda x, y: x*y, a, 1)
    if op == 'Power':
        return np.power(*a)
    if op == 'Gamma':
        return special.gamma(a[0])
    if op == 'PolyGamma':
        return polygamma(round(a[0].real), a[1])
    if op == 'Log':
        return np.log(a[0])
    raise ValueError('unsupported syntax node: '+op)


def quad(data, parameters, step, bound):
    ts = step*np.arange(-round(bound/step), round(bound/step)+1)
    ctr = data['contour']
    if len(ctr) == 1:
        return evaluate(data['ast'], [ctr[0]+1j*ts], parameters).sum()*step/(2*np.pi)
    if len(ctr) == 2:
        return sum(np.sum(evaluate(data['ast'], [ctr[0]+1j*t, ctr[1]+1j*ts], parameters))
                   for t in ts)*(step/(2*np.pi))**2
    if len(ctr) == 3:
        # Slabs bound memory. Subtrees independent of the first contour axis
        # are evaluated once, including expensive spectator Gamma factors.
        fixed = [None, ctr[1]+1j*ts[:, None], ctr[2]+1j*ts[None, :]]
        def compile_node(tree):
            op, *args = tree
            if op == 'var':
                return (lambda v: v) if args[0] == 0 else fixed[args[0]]
            if op == 'param':
                return parameters[args[0]]
            if op == 'num':
                return complex(*args)
            children = [compile_node(t) for t in args]
            def apply(a):
                if op == 'Plus': return sum(a)
                if op == 'Times': return functools.reduce(lambda x, y: x*y, a, 1)
                if op == 'Power': return np.power(*a)
                if op == 'Gamma': return special.gamma(a[0])
                if op == 'PolyGamma': return polygamma(round(a[0].real), a[1])
                if op == 'Log': return np.log(a[0])
                raise ValueError('unsupported syntax node: '+op)
            if not any(callable(c) for c in children):
                return apply(children)
            return lambda v: apply([c(v) if callable(c) else c for c in children])
        integrand = compile_node(data['ast'])
        return sum(np.sum(integrand(ctr[0]+1j*t)) for t in ts)*(step/(2*np.pi))**3
    raise ValueError('independent source gate currently supports up to three folds')


def check(data):
    if len(data['contour']) in (4, 5):
        return highfold_check(data)
    rows = []
    # Samples are supplied only by the calling kernel's per-source, per-call
    # memo. They depend on the original contour, never on the candidate.
    observations = data.get('observations', {})
    def observe(record, step, bound):
        point_key = json.dumps(record['parameters'], separators=(',', ':'))
        mesh_key = f'{step}:{bound}'
        sample = observations.setdefault(point_key, {})
        if mesh_key not in sample:
            value = quad(data, record['parameters'], step, bound)
            sample[mesh_key] = [float(value.real), float(value.imag)]
        return complex(*sample[mesh_key])
    for record in data['predictions']:
        predicted = complex(*record['value'])
        meshes = ((.18, 9), (.12, 11), (.085, 13)) if len(data['contour']) == 3 else ((.16, 10), (.10, 10), (.07, 13))
        observed = [observe(record, h, t) for h, t in meshes[:2]]
        # Reject a plainly inconsistent candidate before paying for the fine
        # three-dimensional meshes. This is only a refusal shortcut: success
        # still requires every original mesh/tail and tolerance check below.
        coarse_gap = abs(observed[-1]-predicted)/(1+abs(predicted))
        coarse_change = abs(observed[-1]-observed[-2])/(1+abs(predicted))
        if (np.isfinite(coarse_gap) and np.isfinite(coarse_change)
                and coarse_gap > max(.05, 20*coarse_change)):
            rows.append({'parameters': record['parameters'],
                         'relative_error': float(coarse_gap),
                         'coarse_change': float(coarse_change), 'pass': False,
                         'reason': 'Candidate inconsistent with both coarse meshes.'})
            break
        observed.extend(observe(record, h, t) for h, t in meshes[2:])
        # Close contours and multiple poles need finer meshes. Refine the
        # quadrature, never the exact candidate or the acceptance threshold.
        refinements = ((.06, 14), (.05, 15)) if len(data['contour']) == 3 else ((.045, 16), (.03, 18), (.02, 20))
        for h, t in refinements:
            if abs(observed[-1]-observed[-2])/(1+abs(observed[-1])) < 2e-6:
                break
            observed.append(observe(record, h, t))
        error = abs(observed[-1]-predicted)/(1+abs(predicted))
        convergence = abs(observed[-1]-observed[-2])/(1+abs(observed[-1]))
        rows.append({'parameters': record['parameters'], 'relative_error': float(error),
                     'convergence': float(convergence),
                     'pass': bool(np.isfinite(error) and error < 2e-6 and convergence < 2e-6)})
        if not rows[-1]['pass']:
            break
    return {'pass': len(rows) >= 2 and all(row['pass'] for row in rows), 'checks': rows,
            'observations': observations,
            'qualification': 'Finite numerical diagnostics, not a global rigorous error bound.'}


def log_evaluate(tree, z, p):
    """Log-domain products avoid overflow in the Cauchy tails."""
    op, *args = tree
    if op == 'Times':
        return sum(log_evaluate(t, z, p) for t in args)
    if op == 'Gamma':
        return special.loggamma(evaluate(args[0], z, p))
    if op == 'Power':
        if args[0][0] == 'Gamma':
            return evaluate(args[1], z, p)*special.loggamma(evaluate(args[0][1], z, p))
        return evaluate(args[1], z, p)*np.log(evaluate(args[0], z, p))
    return np.log(evaluate(tree, z, p))


def importance_matrix(data, parameters):
    """A source-only Gamma Hessian; it neither moves contours nor uses predictions."""
    ctr = np.asarray(data['contour'])
    n = len(ctr)
    hessian = np.zeros((n, n))
    def visit(tree, weight=1):
        nonlocal hessian
        op, *args = tree
        if op == 'Times':
            for child in args:
                visit(child, weight)
        elif op == 'Power' and args[0][0] == 'Gamma':
            visit(args[0], weight*evaluate(args[1], np.zeros(n), parameters).real)
        elif op == 'Gamma':
            offset = evaluate(args[0], np.zeros(n), parameters).real
            gradient = np.array([evaluate(args[0], np.eye(n)[j], parameters).real-offset
                                 for j in range(n)])
            hessian += weight*special.polygamma(1, offset+gradient@ctr)*np.outer(gradient, gradient)
    visit(data['ast'])
    eigenvalues, vectors = np.linalg.eigh(hessian)
    return (vectors*(2/np.sqrt(np.maximum(eigenvalues, .25))))@vectors.T


def highfold_check(data):
    """Two independent importance maps on the unchanged four/five-fold contour.

    Scrambled Sobol estimates are diagnostics only. A complex candidate must
    pass both maps at every parameter point; no numerical value is returned
    to the symbolic producer. The errors are statistical, not rigorous bounds.
    """
    n = len(data['contour'])
    records = data['predictions']
    predictions = np.array([complex(*r['value']) for r in records])
    scales = 1+np.abs(predictions)
    symmetric = importance_matrix(data, records[0]['parameters'])
    triangular = np.linalg.cholesky(symmetric@symmetric.T)
    if np.allclose(symmetric, triangular, rtol=1e-12, atol=1e-14):
        triangular = .5*triangular
    matrices = [('hessian-symmetric', symmetric), ('hessian-triangular', triangular)]
    observations = data.get('observations', {})
    sobol_samples = observations.setdefault('sobol', {})
    checks = []
    for map_index, (name, matrix) in enumerate(matrices):
        log_det = np.log(abs(np.linalg.det(matrix)))
        source_samples = sobol_samples.setdefault(name, {})
        history = []
        previous_mean = None
        passed = False
        for power in (16, 18, 20, 22):
            key = str(power)
            if key in source_samples:
                stored = np.asarray(source_samples[key])
                estimates = stored[..., 0]+1j*stored[..., 1]
            else:
                estimates = []
                for seed in range(4):
                    engine = qmc.Sobol(n, scramble=True, seed=42700+20500*map_index+seed)
                    total = np.zeros(len(records), dtype=complex)
                    for _ in range(2**(power-14)):
                        angles = np.pi*(engine.random(2**14)-.5)
                        ts = np.tan(angles)@matrix.T
                        log_weight = log_det-n*np.log(2)-2*np.sum(np.log(np.cos(angles)), axis=1)
                        z = [data['contour'][j]+1j*ts[:, j] for j in range(n)]
                        for i, record in enumerate(records):
                            total[i] += np.exp(log_evaluate(data['ast'], z, record['parameters'])+log_weight).sum()
                    estimates.append(total/2**power)
                estimates = np.asarray(estimates)
                source_samples[key] = np.stack((estimates.real, estimates.imag), axis=-1).tolist()
            mean = estimates.mean(axis=0)
            spread = estimates.std(axis=0, ddof=1)/2/scales
            error = np.abs(mean-predictions)/scales
            passed = bool(np.all(np.isfinite(error)) and np.all(error < 1e-4) and np.all(spread < 3e-5))
            history.append({'power': power, 'relative_error': error.tolist(),
                            'relative_standard_error': spread.tolist(), 'pass': passed})
            # Reject only: a stable coarse source estimate far from the trial
            # formula need not consume the complete refinement budget. This
            # condition can never accept a candidate or change a tolerance.
            if previous_mean is not None and not passed:
                change = np.abs(mean-previous_mean)/scales
                if np.any(error > np.maximum(.05, 20*np.maximum(change, spread))):
                    history[-1]['coarse_rejection'] = True
                    history[-1]['coarse_change'] = change.tolist()
                    break
            if passed or (power >= 20 and np.any(error > 1e-2) and np.all(spread < 1e-4)):
                break
            previous_mean = mean
        checks.append({'map': name, 'history': history, 'pass': passed})
        if not passed:
            break
    return {'pass': len(records) >= 2 and len(checks) == 2 and all(c['pass'] for c in checks),
            'checks': checks, 'contour': data['contour'],
            'observations': observations,
            'qualification': 'Two source-curvature maps with independent scrambled Sobol ensembles on unchanged contours; relative tolerance 1e-4 and estimated standard error below 3e-5, not rigorous bounds.'}


if __name__ == '__main__':
    try:
        with open(sys.argv[1], encoding='utf-8') as stream:
            answer = check(json.load(stream))
    except Exception as exc:
        answer = {'pass': False, 'reason': str(exc)}
    with open(sys.argv[2], 'w', encoding='utf-8') as stream:
        json.dump(answer, stream, allow_nan=False, indent=2)
        stream.write('\n')

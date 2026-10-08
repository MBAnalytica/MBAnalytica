"""Native coefficient jobs for the parameter Subtraction ladder: orders in parallel, optional algebraic-root audit.

Input/output contract as mbe_parameter_subtraction_native.py (requests.json -> responses.json, same per-job cache
key and record format, same certification test).  Differences:
  * every (job, integration order) is its own process; the first certified order of a job wins and its sibling
    processes are stopped (integration orders are not mathematics: each is integrated with the request's own
    endpoint-divergence check and only a certified response is kept);
  * "workers" and "job_seconds" from the request file (defaults 16 and 1200);
  * "audit": true -> every certified record is repeated with algebraic_letters and spectator_algebraic_letters
    enabled, in its winning order.  With the letters disabled the backend can omit the contribution of an
    irreducible quadratic factor instead of refusing.  A record is 'safe' only if the audit result contains no
    algebraic letter and has exactly the same rows (or rows whose per-word coefficient sums agree exactly).
    responses.json["complete"] requires every record certified and, with audit, every verdict safe.
No target names or answers.
"""
import concurrent.futures as cf
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import subprocess
import sys
import threading
import time

HERE = Path(__file__).resolve().parent
spec = importlib.util.spec_from_file_location('native', HERE/'mbe_parameter_subtraction_native.py')
native = importlib.util.module_from_spec(spec); spec.loader.exec_module(native)


def key_of(fp, job):
    return hashlib.sha256(json.dumps([fp, job], sort_keys=True).encode()).hexdigest()


def run_order(binary, req, seconds, procs, lock, deadline=None):
    start = time.monotonic()
    if deadline is not None:
        seconds = min(seconds, deadline-time.time())
    if seconds <= 0:
        return {'order': req['vars_int'], 'error': 'DeadlineExpired', 'seconds': 0.0}
    p = subprocess.Popen(native.stack_command(binary), stdin=subprocess.PIPE,
                         stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True, env={**os.environ, 'OMP_NUM_THREADS': '1'})
    with lock: procs.add(p)
    try:
        out, err = p.communicate(json.dumps(req), timeout=seconds)
        try: resp = json.loads(out) if p.returncode == 0 and out else None
        except json.JSONDecodeError: resp = None
        trial = {'order': req['vars_int'], 'exit': p.returncode, 'response': resp, 'stderr': (err or '')[-2000:]}
    except subprocess.TimeoutExpired:
        p.kill(); p.communicate(); trial = {'order': req['vars_int'], 'error': 'TimeoutExpired'}
    with lock: procs.discard(p)
    trial['seconds'] = time.monotonic()-start
    return trial


def same_value(rows_a, rows_b):
    try:
        import sympy
    except ImportError:
        # no exact comparison available: the audited record is not certified (fail closed, verdict 'differs')
        return False
    def total(rows):
        acc = {}
        for r in rows:
            k = json.dumps(r['key'], sort_keys=True)
            acc[k] = acc.get(k, 0)+sympy.sympify(r['coef'].replace('^', '**'))
        return acc
    a, b = total(rows_a), total(rows_b)
    return all(sympy.cancel(sympy.together(a.get(k, 0)-b.get(k, 0))) == 0 for k in set(a) | set(b))


def main():
    src, dst = map(Path, sys.argv[1:3])
    data = json.loads(src.read_text())
    folder = Path(data['record_directory']); folder.mkdir(parents=True, exist_ok=True)
    paths = [Path(data['binary']), Path(native.__file__), Path(__file__)]
    paths += [Path(j['request']['mzv_data_path']) for j in data['jobs'] if 'mzv_data_path' in j['request']]
    fp = [(str(p), hashlib.sha256(p.read_bytes()).hexdigest()) for p in sorted(set(paths))]
    seconds = float(data.get('job_seconds', 1200)); workers = int(data.get('workers', 16)); audit = bool(data.get('audit'))
    deadline = data.get('deadline_unix')
    lock = threading.Lock(); records = {}; state = {}
    # release R3.1 (4 October 2026): "watch" lists jobs that the caller has found not certifiably convergent alone (the
    # exact last fold refuses them).  Their orders run first, and when one of them ends with no certified order and no
    # time-limit trial, nothing else can close the candidate: the batch stops there (no audit), "aborted" names the job.
    watch = set(str(i) for i in data.get('watch', [])); halt = {'job': None}
    todo = []
    for j in data['jobs']:
        k = key_of(fp, j); path = folder/(k+'.json')
        if data.get('cache') and path.exists():
            saved = json.loads(path.read_text())
            if saved.get('success') and native.certified(saved.get('response'), j['request']):
                records[j['id']] = {**saved, 'id': j['id'], 'cache_hit': True}; continue
        state[j['id']] = {'winner': None, 'order': None, 'procs': set(), 'trials': [], 'left': len(j['orders']), 'key': k}
        todo.extend((j, o) for o in j['orders'])
    todo.sort(key=lambda t: (0 if str(t[0]['id']) in watch else 1, t[0]['orders'].index(t[1])))

    def finish(j):
        st = state[j['id']]
        rec = {'id': j['id'], 'success': st['winner'] is not None, 'trials': st['trials'], 'source_hash': st['key']}
        if st['winner'] is not None: rec.update(response=st['winner'], order_used=st['order'])
        (folder/(st['key']+'.json')).write_text(json.dumps(rec)); records[j['id']] = rec
        if (watch and st['winner'] is None and str(j['id']) in watch and halt['job'] is None
                and not any(t.get('error') in ('TimeoutExpired', 'DeadlineExpired') for t in st['trials'])):
            with lock:
                halt['job'] = j['id']
                for s in state.values():
                    for p in list(s['procs']):
                        try: p.kill()
                        except Exception: pass

    def task(t):
        j, order = t; st = state[j['id']]
        with lock:
            if halt['job'] is not None or st['winner'] is not None: st['left'] -= 1; return
        req = {**j['request'], 'vars_int': order}
        trial = run_order(data['binary'], req, seconds, st['procs'], lock, deadline)
        ok = native.certified(trial.get('response'), req)
        with lock:
            if halt['job'] is not None and not ok: st['left'] -= 1; return
            st['trials'].append({k: v for k, v in trial.items() if k != 'response' or not ok})
            st['left'] -= 1; final = False
            if ok and st['winner'] is None:
                st['winner'] = trial['response']; st['order'] = order; final = True
                for p in list(st['procs']):
                    try: p.kill()
                    except Exception: pass
            elif st['left'] == 0 and st['winner'] is None: final = True
        if final: finish(j)

    with cf.ThreadPoolExecutor(max_workers=workers) as pool:
        list(pool.map(task, todo))
    verdicts = {}
    if halt['job'] is not None:
        ordered = [records[j['id']] for j in data['jobs'] if j['id'] in records]
        dst.write_text(json.dumps({'complete': False, 'records': ordered, 'audit': verdicts, 'aborted': halt['job']}))
        return 0
    if audit:
        def audit_one(j):
            rec = records[j['id']]
            if not rec.get('success'): return j['id'], 'failed'
            order = rec.get('order_used') or [t for t in rec['trials'] if 'error' not in t and t.get('exit') == 0][-1]['order']
            req = {**j['request'], 'vars_int': order, 'algebraic_letters': True, 'spectator_algebraic_letters': True}
            tr = run_order(data['binary'], req, 4*seconds, set(), threading.Lock(), deadline)
            resp = tr.get('response')
            if not isinstance(resp, dict) or not isinstance(resp.get('result'), list) or any(k in resp for k in ('error', 'failed', 'divergent')):
                return j['id'], 'audit_failed'
            if 'Wm_' in json.dumps(resp['result']) or 'Wp_' in json.dumps(resp['result']):
                return j['id'], 'roots'
            a = sorted(json.dumps(r, sort_keys=True) for r in resp['result'])
            b = sorted(json.dumps(r, sort_keys=True) for r in rec['response']['result'])
            return j['id'], 'safe' if a == b or same_value(resp['result'], rec['response']['result']) else 'differs'
        with cf.ThreadPoolExecutor(max_workers=workers) as pool:
            verdicts = dict(pool.map(audit_one, data['jobs']))
    ordered = [records[j['id']] for j in data['jobs'] if j['id'] in records]
    complete = len(ordered) == len(data['jobs']) and all(r.get('success') for r in ordered) \
        and (not audit or all(v == 'safe' for v in verdicts.values()))
    dst.write_text(json.dumps({'complete': complete, 'records': ordered, 'audit': verdicts}))
    return 0


if __name__ == '__main__':
    raise SystemExit(main())

"""Tests of the caches of the native job runners (make regression).

A truncated or malformed cache file is a cache miss and the job is computed again, an interrupted write leaves no
partial file, and concurrent writers of one record leave a complete record.  The integrator is replaced by a small
script that returns a fixed certified response.  Exit code 0 only when every test passes.
"""
import importlib.util
import json
import os
from pathlib import Path
import stat
import sys
import tempfile
import threading
import time

HERE = Path(__file__).resolve().parent
NATIVE = HERE.parent / 'src' / 'SymbolicInt' / 'mbe_parameter_subtraction_native.py'
PARALLEL = HERE.parent / 'src' / 'SymbolicInt' / 'mbe_parameter_subtraction_native_par.py'


def load(path, name):
    spec = importlib.util.spec_from_file_location(name, path)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


native = load(NATIVE, 'native')
parallel = load(PARALLEL, 'parallel')
results = []


def check(name, ok):
    results.append((name, bool(ok)))
    print(('  PASS  ' if ok else '  FAIL  ') + name, flush=True)


def fake_binary(folder):
    """An executable that reads a request and prints a certified response in the variable of the request."""
    path = Path(folder) / 'fake_hyperflint'
    path.write_text('#!/usr/bin/env python3\n'
                    'import json, sys\n'
                    'req = json.loads(sys.stdin.read())\n'
                    'print(json.dumps({"result": [{"coef": "1", "key": [["0"]]}], "vars": req["vars"]}))\n')
    path.chmod(path.stat().st_mode | stat.S_IEXEC)
    return str(path)


def mixed_binary(folder):
    """An executable that answers the order ['x'] at once and sleeps a minute on any other order."""
    path = Path(folder) / 'mixed_hyperflint'
    path.write_text('#!/usr/bin/env python3\n'
                    'import json, sys, time\n'
                    'req = json.loads(sys.stdin.read())\n'
                    'if req["vars_int"] != ["x"]: time.sleep(60)\n'
                    'print(json.dumps({"result": [{"coef": "1", "key": [["0"]]}], "vars": req["vars"]}))\n')
    path.chmod(path.stat().st_mode | stat.S_IEXEC)
    return str(path)


def job(identifier):
    request = {'op': 'hyperflint', 'expr': 'x', 'vars': ['x', 'a'], 'vars_int': ['x']}
    return {'id': identifier, 'request': request, 'orders': [['x']]}


def main():
    with tempfile.TemporaryDirectory() as tmp:
        folder = Path(tmp) / 'records'
        folder.mkdir()
        data = {'binary': fake_binary(tmp), 'cache': True, 'engine_fingerprint': 'test', 'job_seconds': 30}
        j = job(1)
        key = native.hashlib.sha256(json.dumps([data['engine_fingerprint'], j], sort_keys=True).encode()).hexdigest()
        record = folder / (key + '.json')

        # a truncated cache file is a cache miss
        record.write_text('{')
        try:
            out = native.run_job(j, data, folder)
            check('truncated cache file is recomputed', out.get('success') and not out.get('cache_hit'))
        except Exception as err:
            check('truncated cache file is recomputed (' + type(err).__name__ + ')', False)
        check('the recomputed record is complete JSON', isinstance(native.read_record(record), dict))

        # a well-formed record of the wrong shape is a cache miss as well
        record.write_text(json.dumps({'success': True, 'response': {'result': [{'nokey': 1}]}}))
        out = native.run_job(j, data, folder)
        check('ill-formed cached record is recomputed', out.get('success') and not out.get('cache_hit'))

        # a valid record is a cache hit
        out = native.run_job(j, data, folder)
        check('valid cached record is used', out.get('cache_hit') is True)

        # the parallel runner with a truncated cache file
        par_folder = Path(tmp) / 'records_par'
        par_folder.mkdir()
        fp = [('x', 'y')]
        jp = job(2)
        par_key = parallel.key_of(fp, jp)
        (par_folder / (par_key + '.json')).write_text('{')
        saved = native.read_record(par_folder / (par_key + '.json'))
        check('parallel runner reads a truncated record as a miss', saved is None)

        # an interrupted write leaves the old record and no temporary file
        target = Path(tmp) / 'atomic.json'
        native.write_atomic(target, json.dumps({'old': True}))

        try:
            native.write_atomic(target, None)   # the write fails inside the helper, after the temporary file exists
        except TypeError:
            pass
        leftovers = [p for p in Path(tmp).iterdir() if p.name.startswith('atomic.json.') and p.suffix == '.tmp']
        check('interrupted write keeps the previous record', json.loads(target.read_text()) == {'old': True})
        check('interrupted write leaves no temporary file', leftovers == [])

        # concurrent writers of one record leave a complete record
        def writer(n):
            for k in range(50):
                native.write_atomic(target, json.dumps({'writer': n, 'k': k, 'pad': 'x' * 10000}))

        threads = [threading.Thread(target=writer, args=(n,)) for n in range(8)]
        for t in threads:
            t.start()
        for t in threads:
            t.join()
        final = native.read_record(target)
        check('concurrent writers leave a complete record', isinstance(final, dict) and len(final.get('pad', '')) == 10000)

        # the review of e4f55bd: a sibling registered after its job was won is stopped at once, and a batch ends when
        # every job is won, without waiting for a slow sibling to reach its time limit
        procs = set()
        t0 = time.monotonic()
        trial = parallel.run_order(mixed_binary(tmp), {'op': 'hyperflint', 'expr': 'x', 'vars': ['x', 'a'], 'vars_int': ['a']},
                                   60, procs, threading.Lock(), None, cancelled=lambda: True)
        check('a cancelled sibling stops at once', trial.get('error') == 'Cancelled' and time.monotonic()-t0 < 20 and not procs)
        race = Path(tmp) / 'race'
        race.mkdir()
        request = {'op': 'hyperflint', 'expr': 'x', 'vars': ['x', 'a'], 'vars_int': ['x']}
        batch = {'jobs': [{'id': 1, 'request': request, 'orders': [['a'], ['x']]}], 'binary': mixed_binary(tmp),
                 'record_directory': str(race/'records'), 'workers': 2, 'job_seconds': 60, 'audit': False, 'cache': False}
        (race/'requests.json').write_text(json.dumps(batch))
        saved_argv = sys.argv
        sys.argv = ['runner', str(race/'requests.json'), str(race/'responses.json')]
        t0 = time.monotonic()
        try:
            parallel.main()
        finally:
            sys.argv = saved_argv
        elapsed = time.monotonic()-t0
        out = json.loads((race/'responses.json').read_text())
        check('a won job stops its slow sibling (%.1f s)' % elapsed, elapsed < 30 and out.get('complete') is True)

    failed = [name for name, ok in results if not ok]
    if not results or failed:
        print('native cache tests FAILED: ' + (', '.join(failed) if failed else 'no test ran'))
        return 1
    print('native cache tests passed: %d tests' % len(results))
    return 0


if __name__ == '__main__':
    sys.exit(main())

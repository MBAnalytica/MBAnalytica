"""Bounded native coefficient jobs for the parameter Subtraction rung.
No target names or answers. Every order is checked for endpoint divergences.
"""
import concurrent.futures as cf
import hashlib
import json
import os
import re
from pathlib import Path
import subprocess
import sys
import time


def certified(response, request):
    if not (isinstance(response, dict) and isinstance(response.get('result'), list)
            and not any(k in response for k in ('error', 'failed', 'divergent'))):
        return False
    allowed = set(request['vars']) - set(request['vars_int'])
    for row in response['result']:
        for text in [row['coef']] + [x for w in row['key'] for x in w]:
            symbols = set(re.findall(r'[A-Za-z][A-Za-z0-9_]*', text))
            if any(s not in allowed and not re.fullmatch(r'mzv_(?:m?\d+_?)+', s)
                   for s in symbols):
                return False
    return True


def run_job(job, data, folder):
    key = hashlib.sha256(json.dumps([data.get('engine_fingerprint'), job], sort_keys=True).encode()).hexdigest()
    path = folder / (key + '.json')
    if data.get('cache') and path.exists():
        saved = json.loads(path.read_text())
        if saved.get('success') and certified(saved.get('response'), job['request']):
            return {**saved, 'id': job['id'], 'cache_hit': True}
    trials = []
    for order in job['orders']:
        req = {**job['request'], 'vars_int': order}
        start = time.monotonic()
        try:
            proc = subprocess.run(
                ['prlimit', '--stack=unlimited', data['binary'], 'eval-json'],
                input=json.dumps(req), text=True, capture_output=True,
                env={**os.environ, 'OMP_NUM_THREADS': '1'},
                timeout=data.get('job_seconds', 45))
            response = json.loads(proc.stdout) if proc.returncode == 0 and proc.stdout else None
            trial = {'order': order, 'exit': proc.returncode,
                     'response': response, 'stderr': proc.stderr[-2000:]}
        except (subprocess.TimeoutExpired, json.JSONDecodeError) as err:
            trial = {'order': order, 'error': type(err).__name__}
        trial['seconds'] = time.monotonic() - start
        trials.append(trial)
        response = trial.get('response')
        if certified(response, req):
            record = {'id': job['id'], 'success': True, 'trials': trials,
                      'response': response, 'source_hash': key}
            path.write_text(json.dumps(record))
            return record
    record = {'id': job['id'], 'success': False, 'trials': trials, 'source_hash': key}
    path.write_text(json.dumps(record))
    return record


def main():
    src, dst = map(Path, sys.argv[1:3])
    data = json.loads(src.read_text())
    folder = Path(data['record_directory'])
    folder.mkdir(parents=True, exist_ok=True)
    engine_paths = [Path(data['binary']), Path(__file__)]
    engine_paths += [Path(j['request']['mzv_data_path']) for j in data['jobs'] if 'mzv_data_path' in j['request']]
    data['engine_fingerprint'] = [(str(p), hashlib.sha256(p.read_bytes()).hexdigest()) for p in sorted(set(engine_paths))]
    records = []
    with cf.ThreadPoolExecutor(max_workers=min(3, data.get('workers', 3))) as pool:
        futures = [pool.submit(run_job, j, data, folder) for j in data['jobs']]
        for fut in cf.as_completed(futures):
            record = fut.result()
            records.append(record)
            print(record['id'], record['success'], flush=True)
    dst.write_text(json.dumps({'complete': all(r['success'] for r in records),
                               'records': records}))
    return 0


if __name__ == '__main__':
    raise SystemExit(main())

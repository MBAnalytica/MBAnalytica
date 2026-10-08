#!/bin/bash
# The MBResum examples (Examples_MBResum.nb) through MBEvaluate[..., Method -> "Resum"], each in its own kernel,
# JOBS at a time.  Usage:  RESULTS_T=/path/to/results_t OUT=/path/to/records JOBS=2 KERNELS=4 ./run_resum_regression.sh [NAME ...]
HERE=$(cd "$(dirname "$0")" && pwd)
WS=${WOLFRAMSCRIPT:-wolframscript}
JOBS=${JOBS:-2}
LIST="MB1:0 MB2:0 MB3:0 MB7:0 MB4:-1 MB6:-1 MB9:-4 MB10:-4 MB5:-3 MB11:-5 MB8:-6 MB12:-3 MB13:-4 \
MB1u:0 MB2u:0 MB3u:0 MB7u:0 MB4u:-3 MB6u:-3 MB9u:-4 MB10u:-2 MB5u:-4 MB11u:-4 MB8u:-5 MB12u:-3 MB13u:-4"
if [ $# -gt 0 ]; then
  KEEP=""
  for x in $LIST; do
    for want in "$@"; do [ "${x%%:*}" = "$want" ] && KEEP="$KEEP $x"; done
  done
  LIST=$KEEP
fi
mkdir -p "$OUT"
for item in $LIST; do echo "$item"; done | xargs -P "$JOBS" -I{} bash -c '
  item={}; name=${item%%:*}; ord=${item##*:}
  NAME=$name ORDER=$ord OUT="'"$OUT"'" KERNELS='"${KERNELS:-4}"' RESULTS_T="'"$RESULTS_T"'" \
    "'"$WS"'" -file "'"$HERE"'/resum_target.wls" > "'"$OUT"'/$name.log" 2>&1
  grep -h "RESUM_RESULT" "'"$OUT"'/$name.log" || echo "RESUM_RESULT $name  order $ord  NO RESULT (see $name.log)"'
echo "RESUM_REGRESSION_DONE $(date)"

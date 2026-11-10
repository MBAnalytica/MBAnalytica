#!/bin/bash
# The MBSymbolicSum benchmark through MBEvaluate[..., Method -> "SymbolicSum"], each integral in its own kernel, JOBS at a time:
# every row to the deepest order that is green in status_mb2mpl.pdf (2026-09-23, 118 green cells); ORDERS=examples
# takes the orders of Examples_MBSymbolicSum.nb instead.
# Usage:  RESULTS_T=/path/to/results_t OUT=/path/to/records JOBS=2 KERNELS=4 ./run_symbolicsum_regression.sh [NAME ...]
HERE=$(cd "$(dirname "$0")" && pwd)
WS=${WOLFRAMSCRIPT:-wolframscript}
JOBS=${JOBS:-2}
LIST="MB11:-3 MB10:-2 MB9:-2 MB6:-1 MB4:-1 MB8:-5 MB5:-2 MB13:-4 MB12:-3 MB1:0 MB2:0 MB3:0 MB7:0 \
MB1u:0 MB2u:0 MB3u:0 MB7u:0 MB4u:-1 MB6u:-1 MB9u:-2 MB10u:-2 MB5u:-3 MB11u:-4 MB8u:-5 MB12u:-3 MB13u:-4"
if [ "$ORDERS" = examples ]; then
  LIST="MB1:0 MB2:0 MB3:0 MB7:0 MB4:-1 MB6:-1 MB9:-4 MB10:-4 MB5:-3 MB11:-5 MB8:-6 MB12:-3 MB13:-4 \
MB1u:0 MB2u:0 MB3u:0 MB7u:0 MB4u:-3 MB6u:-3 MB9u:-4 MB10u:-2 MB5u:-4 MB11u:-4 MB8u:-5 MB12u:-3 MB13u:-4"
fi
if [ $# -gt 0 ]; then
  KEEP=""
  for x in $LIST; do
    for want in "$@"; do [ "${x%%:*}" = "$want" ] && KEEP="$KEEP $x"; done
  done
  LIST=$KEEP
fi
mkdir -p "$OUT"
# the item is the argument of the script, not an -I replacement: BSD xargs (macOS) refuses a replaced argument longer
# than 255 bytes; -r: GNU xargs would otherwise run the script once on an empty selection
for item in $LIST; do echo "$item"; done | xargs -r -P "$JOBS" -n 1 bash -c '
  item=$1; name=${item%%:*}; ord=${item##*:}
  NAME=$name ORDER=$ord OUT="'"$OUT"'" KERNELS='"${KERNELS:-4}"' RESULTS_T="'"$RESULTS_T"'" \
    "'"$WS"'" -file "'"$HERE"'/symbolicsum_target.wls" > "'"$OUT"'/$name.log" 2>&1
  grep -h "RESUM_RESULT" "'"$OUT"'/$name.log" || echo "RESUM_RESULT $name  order $ord  NO RESULT (see $name.log)"' _
# the exit status: 0 only when every selected integral has a result line that passes (an empty selection, a missing
# line or a failed comparison is a failure; audit of 2026-11-09)
FAILED=0
COUNT=0
for item in $LIST; do
  name=${item%%:*}
  COUNT=$((COUNT + 1))
  grep -q "RESUM_RESULT $name .* pass True" "$OUT/$name.log" 2>/dev/null || { echo "RESUM_FAILED $name"; FAILED=$((FAILED + 1)); }
done
[ "$COUNT" -eq 0 ] && { echo "RESUM_FAILED no integral selected"; FAILED=1; }
echo "RESUM_REGRESSION_DONE $(date)  $COUNT integrals, $FAILED failed"
[ "$FAILED" -eq 0 ]

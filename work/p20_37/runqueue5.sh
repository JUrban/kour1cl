#!/bin/bash
# phase 2: for every case, once its fact4 run has FINISHED, run fact5 (adaptive trials) for the leftover sizes
cd /project/work/p20_37
MAXJ=$1
for c in $(ls caseb_*.txt | sed 's/caseb_//; s/.txt//' | sort -n); do
  until grep -q FINISHED f4log_$c.txt 2>/dev/null; do sleep 30; done
  if grep -q "NOT FOUND" f4log_$c.txt; then
    while [ $(pgrep -fc "python fact[45].py") -ge $MAXJ ]; do sleep 20; done
    nohup timeout 40000 /project/venv/bin/python fact5.py caseb_$c.txt 17 3000000 > f5log_$c.txt 2>&1 &
    sleep 2
  fi
done
wait
echo QUEUE5 DONE

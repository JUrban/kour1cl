#!/bin/bash
# phase 2: repeatedly scan all cases; once a case's fact4 run has FINISHED with NOT FOUND sizes, run fact5 for them (once)
cd /project/work/p20_37
MAXJ=$1
touch launched5.txt
while true; do
  alldone=1
  for c in $(ls caseb_*.txt | sed 's/caseb_//; s/.txt//' | sort -n); do
    grep -qx "$c" launched5.txt && continue
    if grep -q FINISHED f4log_$c.txt 2>/dev/null; then
      if grep -q "NOT FOUND" f4log_$c.txt; then
        while [ $(pgrep -fc "^/project/venv/bin/python fact[45].py") -ge $MAXJ ]; do sleep 20; done
        nohup timeout 40000 /project/venv/bin/python fact5.py caseb_$c.txt 17 1000000 > f5log_$c.txt 2>&1 &
        sleep 2
      fi
      echo $c >> launched5.txt
    else
      alldone=0
    fi
  done
  [ $alldone = 1 ] && break
  sleep 60
done
wait
echo QUEUE5 DONE

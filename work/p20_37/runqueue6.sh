#!/bin/bash
# phase 3: after phase 2 finished for a case with NOT FOUND sizes, run fact6 (wide search) once
cd /project/work/p20_37
MAXJ=$1
touch launched6.txt
while true; do
  alldone=1
  for c in $(ls caseb_*.txt | sed 's/caseb_//; s/.txt//' | sort -n); do
    grep -qx "$c" launched6.txt && continue
    if grep -q FINISHED f4log_$c.txt 2>/dev/null && ! grep -q "NOT FOUND" f4log_$c.txt; then echo $c >> launched6.txt; continue; fi
    if grep -q FINISHED f5log_$c.txt 2>/dev/null; then
      if grep -q "NOT FOUND" f5log_$c.txt; then
        while [ $(pgrep -fc "^/project/venv/bin/python fact[456].py") -ge $MAXJ ]; do sleep 20; done
        nohup timeout 60000 /project/venv/bin/python fact6.py caseb_$c.txt 23 3000000 > f6log_$c.txt 2>&1 &
        sleep 2
      fi
      echo $c >> launched6.txt
    else
      alldone=0
    fi
  done
  [ $alldone = 1 ] && break
  sleep 120
done
wait
echo QUEUE6 DONE

#!/bin/bash
# run fact4.py on the queued cases, at most $1 concurrently
cd /project/work/p20_37
MAXJ=$1; shift
for c in $(cat queue.txt); do
  [ -f f4log_$c.txt ] && continue
  while [ $(pgrep -fc "^/project/venv/bin/python fact4.py") -ge $MAXJ ]; do sleep 20; done
  nohup timeout 30000 /project/venv/bin/python fact4.py caseb_$c.txt 1 300000 > f4log_$c.txt 2>&1 &
  sleep 2
done
wait
echo QUEUE DONE

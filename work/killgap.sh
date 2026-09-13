#!/bin/bash
# kill gap processes whose "cwd + args" string contains the pattern $1 (never kills non-gap processes)
for pid in $(ps -eo pid,comm | awk '$2=="gap"{print $1}'); do
  full="$(readlink /proc/$pid/cwd 2>/dev/null)/ $(ps -o args= -p $pid)"
  case "$full" in *"$1"*) kill $pid; echo "killed $pid ($full)";; esac
done

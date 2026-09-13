#!/bin/bash
# kill gap processes whose args match $1 (does not match the calling shell)
for pid in $(ps -eo pid,comm,args | awk -v pat="$1" '$2=="gap" && index($0,pat) {print $1}'); do kill $pid; done

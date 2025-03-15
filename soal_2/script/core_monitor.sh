#!/bin/bash

cpu_usage=$(awk '{u=$2+$4; t=$2+$4+$5; if (NR==1){u1=u; t1=t;} else print ($2+$4-u1) * 100 / (t-t1) "%"; }' \
<(grep 'cpu ' /proc/stat) <(sleep 1;grep 'cpu ' /proc/stat))

cpu_model=$(lscpu | grep "Model name" | sed 's/Model name:\s*//')

echo "[$(date)] - Penggunaan CPU: $cpu_usage% - Terminal Model [$cpu_model]"


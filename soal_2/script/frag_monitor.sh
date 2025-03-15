#!/bin/bash

total_memory=$(grep "MemTotal" /proc/meminfo | awk '{print $2}')
available_memory=$(grep "MemAvailable" /proc/meminfo | awk '{print $2}')
used_memory=$((total_memory - available_memory))
percentage_memory=$(awk "BEGIN {print ($used_memory / $total_memory) * 100}")

total_memoryMB=$((total_memory/1024))
available_memoryMB=$((available_memory/1024))
used_memoryMB=$((used_memory/1024))


echo "[$(date)] - Fragment Usage [$percentage_memory%] - Fragment Count [$used_memoryMB MB] - Details [Total: $total_memoryMB MB, Available: $available_memoryMB MB]"




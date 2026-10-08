#!/bin/bash

LOG_FILE="$(dirname "$0")/../logs/server-health.log"

echo "====================================" >> "$LOG_FILE"
echo "Server Health Check: $(date)" >> "$LOG_FILE"
echo "====================================" >> "$LOG_FILE"

echo "CPU Load:" >> "$LOG_FILE"
uptime >> "$LOG_FILE"

echo "" >> "$LOG_FILE"

echo "Memory Usage:" >> "$LOG_FILE"
free -h >> "$LOG_FILE"

echo "" >> "$LOG_FILE"

echo "Disk Usage:" >> "$LOG_FILE"
df -h >> "$LOG_FILE"

DISK_USAGE=$(df / | awk 'NR==2 {print $5}' | tr -d '%')

if [ "$DISK_USAGE" -gt 80 ]; then
    echo "WARNING: Disk usage is above 80%" >> "$LOG_FILE"
else
    echo "Disk usage is normal" >> "$LOG_FILE"
fi

echo "" >> "$LOG_FILE"

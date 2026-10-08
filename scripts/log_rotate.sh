#!/bin/bash

LOG_FILE="$(dirname "$0")/../logs/server-health.log"

if [ -f "$LOG_FILE" ]; then
    SIZE=$(du -k "$LOG_FILE" | awk '{print $1}')

    if [ "$SIZE" -gt 1024 ]; then
        mv "$LOG_FILE" "$LOG_FILE.$(date +%Y%m%d%H%M%S)"
        touch "$LOG_FILE"

        echo "Log rotated"
    fi
fi

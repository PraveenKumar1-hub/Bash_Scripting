#!/bin/bash

# 1. Dynamic Input & Argument Validation
# Check kar rahe hain ki user ne log file ka path pass kiya hai ya nahi
if [ $# -ne 1 ]; then
    echo "ERROR: Usage: $0 /home/devopsuser/Bash_Scripting" >&2
    exit 1
fi

LOG_FILE="$1"

# 2. Error Handling (File Existence & Read Permissions)
# Check kar rahe hain ki file sach me exist karti hai aur readable hai ya nahi
if [ ! -f "$LOG_FILE" ]; then
    echo "ERROR: File '$LOG_FILE' does not exist." >&2
    exit 1
fi
if [ ! -r "$LOG_FILE" ]; then
    echo "ERROR: File '$LOG_FILE' is not readable (Permission Denied)." >&2
    exit 1
fi

# 3. Core Logic Pipeline with Robust Redirection
# tolower($0) se 'CRITICAL', 'critical', 'Critical' sab filter ho jayega
# '>>' ka use kiya hai taaki har ghante chalne par naya data append ho, overwrite na ho
awk 'tolower($0) ~ /critical/ {print $1" ["$2"] -> Failing_IP="$4" URL="$6}' "$LOG_FILE" \
| sed 's/old\.api\.internal/api.prod.secure/g' >> incident_report.txt 2>> pipeline_debug.err

echo "LOG PROCESSING SUCCESSFUL: Output appended to incident_report.txt"

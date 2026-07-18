#!/bin/bash

# 1. List of files to check (Yeh hamare loop ka target hai)
files="app.log db.log server.log"

# Ek counter banaya missing files ginne ke liye
error_count=0

echo "=== System Audit Start ==="

# LOOPS: Har ek file par baari-baari jaao
for file in $files; do
    
    # CONDITIONALS: Check karo agar file maujood hai (-f flag)
    if [ -f "$file" ]; then
        echo "[OK] $file system me maujood hai."
    else
        echo "[ERROR] $file missing hai!"
        # Agar file nahi mili, toh error count ko 1 se badha do
        error_count=$((error_count + 1))
    fi
    
done

echo "=========================="

# EXIT CODES: Final decision ki script pass hui ya fail
if [ $error_count -gt 0 ]; then
    echo "Audit FAILED: Total $error_count files missing hain!"
    exit 1
else
    echo "Audit SUCCESS: Saari files maujood hain."
    exit 0
fi


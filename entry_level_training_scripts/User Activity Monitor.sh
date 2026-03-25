#!/usr/bin/env bash

username="$(whoami)"

if ! id "$username" &> /dev/null; then
    echo "Users doesnt exists" >&2
    exit 1
fi

if who | grep -q "$username"; then
    status="Logged in"
else
    status="Not logged in"
fi

head -n 5 /home/$username/.bash_history

files=$(find /home -user "$username" -type f | wc -l)

echo "=== Report for: $username ==="
echo "Status: $status"
echo "Last commands:"
head -n 5 /home/$username/.bash_history
echo "Files in /home: $files"
echo "Report saved to report_$username.txt" && echo "raport" | tee "report_${username}.txt"
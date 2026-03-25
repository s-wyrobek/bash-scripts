#!/usr/bin/env bash

if [ -f "./config.env" ]; then
    echo "config.env istnieje"
else
    echo "config.env nie istnieje"
    exit 1
fi

wolne=$( df -m . | awk 'NR==2 {print $4}' )
if (( $wolne > 500)); then
    echo "wolne miejsce: $wolne MB"
else
    echo "zwolnij pamięć ram"
    exit 1
fi

if which git &> /dev/null; then
  echo "Git zainstalowany"
else
  echo "Git nie zainstalowany"
  exit 1
fi


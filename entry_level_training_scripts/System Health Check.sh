#!/bin/bash

echo "=== Dysk ==="
df -h
echo "=== RAM ==="
free -h

if ps aux | grep -q "nginx"; then
  echo "Nginx działa"
else
  echo "Nginx nie działa" >&2
fi

uwagi=0
df -h | awk 'NR>1 {gsub(/%/,"",$5); print $5}' | while read -r procent; do
  if (( procent > 80 )); then
    echo "Dysk wymaga uwagi" >&2
    uwagi=1
  fi
done

if (( uwagi == 0 )); then
  echo "System OK"
else
  echo "System wymaga uwagi" >&2
fi
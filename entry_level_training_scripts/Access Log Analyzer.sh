#!/bin/bash

sciezka=$1

if [ -f "$sciezka" ]; then
    echo "Top 5 IP"
    awk '{print $1}' $sciezka | sort | uniq -c | sort -rn | head -n 5
    echo "Łącznie requestów = $(wc -l < "$sciezka")"
fi

#!/usr/bin/env bash

# Random Password Generator
# This script generates a random password that meets the specified requirements.

set -euo pipefail

chars_low=$(echo {a..z} | tr -d ' ')
chars_up=$(echo {A..Z} | tr -d ' ')
numbers=$(echo {0..9} | tr -d ' ')
signs="><+-{}:.&;"
random_signs=${signs:$((RANDOM % ${#signs})):1}
list=("$chars_low" "$chars_up" "$numbers" "$signs")



password=""

for i in {1..12}; do
    index=$((RANDOM % ${#list[@]}))
    chosen_string=${list[$index]}
    index_char=${chosen_string:$((RANDOM % ${#chosen_string})):1}
    password+=$index_char
done

echo $password
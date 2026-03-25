#!/bin/bash

sciezka=$1
lerror=0
lwarning=0
if [ -f "$sciezka" ]; then
lerror=$(grep -ci "error" "$sciezka")
lwarning=$(grep -ci "warning" "$sciezka")
fi
echo "$lerror"
echo "$lwarning"

if (( lerror > lwarning )); then
  echo "Częściej występuje Error"
elif (( lwarning > lerror )); then
  echo "Częściej występuje Warning"
else
  echo "Remis!"
fi
#!/usr/bin/env bash

source=$1
destination=$2

if [[ ! -d $source || ! -d $destination ]]; then
    echo "No such files"
    exit 1
fi

date=$(date +%Y-%m-%d)
name="backup_${date}.tar.gz"
tar -czvf "$destination/$name" "$source"

if (( $? == 0 )); then
    echo "Backup sucessfully created"
fi

size=$(du -sh "$destination/$name" | cut -f1)

echo "$(date '+%Y-%m-%d %H:%M:%S') - Backup $source -> $name [$size]" | tee -a "$destination/backup.log"
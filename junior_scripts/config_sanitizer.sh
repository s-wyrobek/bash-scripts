#!/usr/bin/env bash

set -euo pipefail
trap 'rm -rf config_sanitized/' ERR

mkdir -p config_sanitized/ && cp -r configs/ configs_sanitized/

files=$(find ./config_sanitized \( -name '*.conf' -o -name '*.yml' -o -name '*.yaml' -o ! - name '*.bak'\))


for files_to_change in $files; do
    sed -i 's/PASSWORD=.*/PASSWORD=***REDACTED***/g' "$files_to_change"
    sed -i 's/sk-[a-zA-Z0-9_-]*/***API_KEY_REDACTED***/g' "$files_to_change"
    sed -i 's/192\.168\.1\.50/${DB_HOST}/g' "$files_to_change"
    sed -i 's/APP_ENV=development/APP_ENV=production/' "$files_to_change"
    sed -i 's/LOG_LEVEL=debug/LOG_LEVEL=WARN/' "$files_to_change"
done

find . ! -name '*.bak' 


#!/usr/bin/env bash

set -euo pipefail #to crash after bug
trap 'rm -rf configs_sanitized/' ERR #for clear after bug

mkdir -p configs_sanitized/ && cp -r configs/ configs_sanitized/ #for not work on main files

#files skipped
files_skipped_count=0
files_skipped=$(find ./configs_sanitized -name '*.bak')
for file in $files_skipped; do
    ((files_skipped_count++)) || true
done
#

#logic for select proper files
files_found=$(find ./configs_sanitized \( -name '*.conf' -o -name '*.yml' -o -name '*.yaml' \) ! -name '*.bak')

#declare 
files_found_count=0 
password_total=0
api_total=0
ip_total=0


for file in $files_found; do
    ((files_found_count++)) || true

    pw_count=$(grep -c 'PASSWORD=' "$file" || true) #count pw changes
    api_count=$(grep -c 'sk-' "$file" || true) #count api changes
    ip_count=$(grep -c '192\.168\.1\.50' "$file" || true) #count ip changes

    password_total=$((password_total + pw_count)) #sum passwd changes
    api_total=$((api_total + api_count)) #sum api changes
    ip_total=$((ip_total + ip_count)) #sum ip changes

    sed -i -e 's/PASSWORD=.*/PASSWORD=***REDACTED***/gi' \
           -e 's/sk-[a-zA-Z0-9_-]*/***API_KEY_REDACTED***/gi' \
           -e 's/192\.168\.1\.50/${DB_HOST}/gi' \
           -e 's/APP_ENV=development/APP_ENV=production/gi' \
           -e 's/LOG_LEVEL=debug/LOG_LEVEL=WARN/gi' \
           -e 's/admin_password = .*/admin_password = ***REDACTED***/' \
           -e 's/API_SECRET=.*/API_SECRET=***REDACTED***/' \
           -e 's/--requirepass .*/--requirepass ***REDACTED***/' \
           -e 's/password: .*/password: ***REDACTED***";/' \
           "$file" #file we work on 
done

echo "=== SANITIZATION REPORT ==="
echo "Files processed: $files_found_count"
echo "Files skipped: $files_skipped_count"
echo "Password redacted: $password_total"
echo "API redacted: $api_total"
echo "IP redacted: $ip_total"

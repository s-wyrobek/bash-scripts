# Config Sanitizer

Skrypt do czyszczenia plikow konfiguracyjnych z danych wrazliwych przed udostepnieniem.

## Polecenie

Napisz skrypt ktory:
1. Kopiuje katalog `configs/` i pracuje na kopii
2. Znajduje pliki `.conf`, `.yml`, `.yaml` (pomija `.bak`)
3. Redaktuje hasla, klucze API, zamienia IP na zmienne
4. Zmienia env na produkcyjny
5. Wyswietla raport ile zmian wykonano

## Pliki testowe

- `configs/app/settings.conf` — hasla, klucze API, env
- `configs/app/legacy.conf.bak` — do pominiecia
- `configs/database/db.conf` — haslo admina, IP, SSL
- `configs/docker/docker-compose.yml` — credentials w env vars
- `configs/nginx/nginx.conf` — klucz API, haslo w debug endpoint

## Wymagania

- `set -euo pipefail` + `trap` na cleanup
- Redakcja: `PASSWORD=`, `admin_password`, `requirepass`, `API_SECRET`, klucze `sk-*`
- Zamiana `192.168.1.50` na `${DB_HOST}`
- `APP_ENV` -> production, `LOG_LEVEL` -> WARN
- Raport: pliki przetworzone, pominiete, ilosc zmian

## Rozszerzenia

- `--dry-run`
- Kolorowy output
- Walidacja czy nie zostaly niezredaktowane sekrety
- Logowanie do pliku
- Refaktoring do funkcji
- Flaga `--env production|staging`

## Uzycie

```bash
bash config_sanitizer.sh
```

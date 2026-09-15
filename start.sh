#!/bin/sh

PORT="${PORT:-8080}"
export GOATCOUNTER_LISTEN=":${PORT}"

if [ -n "$DATABASE_URL" ] && [ -z "$GOATCOUNTER_DB" ]; then
  DB="$DATABASE_URL"
  case "$DB" in
    postgres://*) DB="${DB#postgres://}" ;;
    postgresql://*) DB="${DB#postgresql://}" ;;
  esac
  case "$DB" in
    *\?*) export GOATCOUNTER_DB="postgresql+postgresql://${DB}&sslmode=disable" ;;
    *) export GOATCOUNTER_DB="postgresql+postgresql://${DB}?sslmode=disable" ;;
  esac
fi

exec goatcounter serve -automigrate

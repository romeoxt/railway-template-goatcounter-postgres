# Railway Template Composer Setup

## Marketplace listing

- **Title:** Deploy and Host GoatCounter with Railway
- **Short description:** Privacy-friendly web analytics on PostgreSQL — stats survive redeploys, no default admin password.
- **Category:** Analytics
- **Overview:** paste `README.md`

## Services

| Service | Source | Volume | Public HTTP |
| --- | --- | --- | --- |
| GoatCounter | GitHub repo (Dockerfile → `arp242/goatcounter`) | `/home/goatcounter/goatcounter-data` (optional) | Yes |
| Postgres | Railway PostgreSQL plugin | `/var/lib/postgresql/data` | No |

## Variables — GoatCounter

| Variable | Value | Secret | Description |
| --- | --- | --- | --- |
| `DATABASE_URL` | `${{Postgres.DATABASE_URL}}` | Yes | Converted to `GOATCOUNTER_DB` at startup |

## Settings — GoatCounter

- Healthcheck: `/`
- First visit creates admin account — highlight in listing vs Umami's default credentials
- Attach volume to PostgreSQL (required for persistent analytics)

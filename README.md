# Deploy and Host GoatCounter with Railway

Privacy-friendly web analytics on PostgreSQL — page views and referrers without cookies, data that survives redeploys.

## About GoatCounter

[GoatCounter](https://www.goatcounter.com/) is an open-source, privacy-conscious web analytics platform. It tracks page views, referrers, and browsers with a minimal embed script. Free for non-commercial use. Lighter than Umami or Plausible for solo sites that want simple numbers.

## About Hosting GoatCounter

This template runs the official `arp242/goatcounter` Docker image against Railway PostgreSQL with a persistent volume. Analytics data lives in Postgres — not SQLite on ephemeral disk — so redeploys do not wipe your stats. Railway handles HTTPS, private database networking, and automatic migrations on startup.

## Environment Variables

| Variable | Description | Secret | Example/Notes |
| --- | --- | --- | --- |
| `DATABASE_URL` | PostgreSQL connection for GoatCounter | Yes | `${{Postgres.DATABASE_URL}}` |
| `GOATCOUNTER_DB` | Override DB connection string | Yes | Auto-built from `DATABASE_URL` if unset |
| `GOATCOUNTER_LISTEN` | HTTP listen address | No | Auto-set to `:$PORT` on Railway |

Optional: mount a volume at `/home/goatcounter/goatcounter-data` for TLS certificates and local settings.

## Deploy and Host

1. Create a new Railway project.
2. Add **PostgreSQL** and attach a **volume** at `/var/lib/postgresql/data`.
3. Deploy this repo as a **Docker** service named **GoatCounter**.
4. Set `DATABASE_URL` = `${{Postgres.DATABASE_URL}}` on the GoatCounter service.
5. Enable **public HTTP** on GoatCounter and deploy.
6. Open your Railway URL and **create your account** on first visit (no default admin password).
7. Add a site in the GoatCounter dashboard, then paste the tracking script into your HTML.

## Common Use Cases

- Personal blogs and portfolios needing privacy-respecting analytics
- Side projects where SQLite-on-disk would lose data on redeploy
- Hobby sites that want referrers and top pages without Google Analytics
- Non-commercial sites eligible for GoatCounter's free self-host license

## Dependencies for GoatCounter Hosting

The Railway template includes:

- **GoatCounter** — `arp242/goatcounter:latest` (this repo Dockerfile)
- **PostgreSQL** — Railway PostgreSQL plugin with persistent volume

## Deployment Dependencies

- [GoatCounter documentation](https://www.goatcounter.com/help)
- [GoatCounter Docker image](https://hub.docker.com/r/arp242/goatcounter)
- [Railway PostgreSQL docs](https://docs.railway.com/databases/postgresql)

## Why Deploy GoatCounter on Railway?

Postgres-backed analytics with one-click deploy, private DB networking, and automatic schema migrations — no VPS, no manual `-db` flag wiring, no SQLite data loss on redeploy.

## Template Content

| Service | Source |
| --- | --- |
| GoatCounter | `arp242/goatcounter:latest` |
| Postgres | Railway PostgreSQL plugin |

## Run locally

```bash
docker build -t goatcounter-railway .
docker run -p 8080:8080 -e DATABASE_URL=postgres://user:pass@host:5432/db goatcounter-railway
```

## Marketing site

See `website/index.html` for the template landing page.

## Author

romeoxt — herbylegall9@gmail.com

## License

MIT (this template). GoatCounter is licensed separately — see [goatcounter.com](https://www.goatcounter.com/).

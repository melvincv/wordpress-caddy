# wordpress-caddy

Wordpress FPM on Docker with Caddy 

> Using the ACME Staging server to prevent rate limiting. \
> Comment the `acme_ca` line in the caddyfile to use the Production server. \
> Also replace `caddy.awsl.melvincv.com` with your domain.

Create a `.env` file with the following variables:

```
MYSQL_ROOT_PASSWORD=
MYSQL_USER=
MYSQL_PASSWORD=
```

Then run docker compose:

```
docker compose up -d
```

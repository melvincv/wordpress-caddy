# wordpress-caddy

## Prerequisites

- An instance running Ubuntu / Debian LTS
- 1 GB RAM (minimum)
- Docker with Compose

You may use my install script to create a new user and install Docker.
First change the values of the variables at the top:

```
USERNAME=melvin
PUBLIC_KEY=''
```

> The public key should be within quotes

## Updates

- Caddyfile: added static file caching for Wordpress
- Caddyfile: added gzip compression
- Caddyfile: added acme-staging server and dummy email to global options

## Wordpress FPM on Docker with Caddy 

- First, make sure that your domain name is pointing to your instance.

- Edit the Caddyfile and add your email to line 2 for Let's Encrypt certificate renewal notices...

```
sudo vim Caddyfile
```

and also replace `caddy.awsl.melvincv.com` with your domain.

Review the settings, Save and Quit.

- Create a `.env` file with the following variables:

```
MYSQL_ROOT_PASSWORD=
MYSQL_USER=
MYSQL_PASSWORD=
```

- Then run docker compose:

```
docker compose up -d
docker compose logs --tail 50 -f
```

> Using the ACME Staging server to prevent rate limiting. \
> Comment the `acme_ca` line in the caddyfile to use the Production server. \

- Restart the caddy service after making changes to the Caddyfile:

```
docker compose restart caddy
```

Docker Compose Output: (should be similar to mine)

```
$ docker compose ps
NAME                          IMAGE                         COMMAND                                                                        SERVICE     CREATED         STATUS         PORTS
wordpress-caddy-caddy-1       caddy:alpine                  "caddy run --config /etc/caddy/Caddyfile --adapter caddyfile"                  caddy       8 minutes ago   Up 5 minutes   0.0.0.0:80->80/tcp, :::80->80/tcp, 0.0.0.0:443->443/tcp, :::443->443/tcp, 443/udp, 2019/tcp
wordpress-caddy-db-1          mysql:8.1                     "docker-entrypoint.sh --default-authentication-plugin=mysql_native_password"   db          8 minutes ago   Up 8 minutes   3306/tcp, 33060/tcp
wordpress-caddy-wordpress-1   wordpress:php7.4-fpm-alpine   "docker-entrypoint.sh php-fpm"                                                 wordpress   8 minutes ago   Up 8 minutes   9000/tcp
```
# Home Lab


## Traefik

```bash
docker run --rm httpd:2.4-alpine htpasswd -nbB admin DEINPASSWORT
```

In config/traefik usersfile ablegen --> für Basic Auth


## StepCA
```bash

docker run --rm alpine:3.20 sh -lc "apk add --no-cache openssl >/dev/null && openssl rand -base64 32 | tr -d '\n'; echo"

```

Passwort in config/stepca in der datei password.txt ablegen


```bash
docker compose up stepca-export
```

Für root pem export
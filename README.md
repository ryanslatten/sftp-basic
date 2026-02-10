# SFTP Test Server

A ready-to-go SFTP server in Docker — clone, start, connect.

## Quick Start

```bash
docker compose up -d
```

That's it. Connect with:

| Setting  | Value       |
|----------|-------------|
| Host     | `localhost` |
| Port     | `2222`      |
| Username | `testuser`  |
| Password | `testpass`  |
| Upload dir | `/home/testuser/upload` (mapped to `./data/` on host) |

### Test it

```bash
sftp -i ./keys/testuser -oPort=2222 testuser@localhost
```

## Configuration

Edit [.env](.env) to change defaults:

```env
SFTP_USER=testuser
SFTP_PASS=testpass
SFTP_PORT=2222
```

Then restart: `docker compose up -d`

## Regenerate Keys

Keys are committed for convenience so the server works immediately. To regenerate:

```bash
rm -rf keys/
./setup.sh
docker compose up -d
```

## Stop / Clean Up

```bash
# Stop the server
docker compose down

# Full reset (removes keys, uploaded data, and volumes)
docker compose down -v
rm -rf keys/ data/
./setup.sh
```

## Project Structure

```
.env                   # Server configuration (user, pass, port)
docker-compose.yml     # Container definition
setup.sh               # Key generation script (idempotent)
data/                  # Uploaded files appear here
keys/                  # SSH host + client keys
```

# SFTP Test Server

A ready-to-go SFTP server in Docker.

## Quick Start

```bash
./setup.sh # To generate keys and data directory
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

```bash
rm -rf keys/
./setup.sh
ssh-keygen -R "[localhost]:2222"  # Clear old host key from known_hosts
docker compose up -d
```

## Stop / Clean Up

```bash
# Stop the server
docker compose down

docker compose down -v
rm -rf keys/ data/
ssh-keygen -R "[localhost]:2222"
./setup.sh
```
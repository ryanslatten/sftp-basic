#!/bin/bash
set -e

# Create directories
mkdir -p keys data

# Generate host keys only if they don't already exist
if [ ! -f keys/ssh_host_ed25519_key ]; then
  echo "Generating host keys..."
  ssh-keygen -t ed25519 -f keys/ssh_host_ed25519_key -N "" -C "sftp-server-ed25519"
  ssh-keygen -t rsa -b 4096 -f keys/ssh_host_rsa_key -N "" -C "sftp-server-rsa"
else
  echo "Host keys already exist, skipping."
fi

# Generate client key only if it doesn't already exist
if [ ! -f keys/testuser ]; then
  echo "Generating client key..."
  ssh-keygen -t rsa -b 4096 -f keys/testuser -N "" -C "testuser@sftp-test"
else
  echo "Client key already exists, skipping."
fi

# Set proper permissions
chmod 600 keys/ssh_host_ed25519_key keys/ssh_host_rsa_key keys/testuser
chmod 644 keys/ssh_host_ed25519_key.pub keys/ssh_host_rsa_key.pub keys/testuser.pub

# Load .env defaults
SFTP_USER="${SFTP_USER:-testuser}"
SFTP_PASS="${SFTP_PASS:-testpass}"
SFTP_PORT="${SFTP_PORT:-2222}"
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

echo ""
echo "✅ Ready! Start the server with:  docker compose up -d"
echo ""
echo "Connect with password:"
echo "  sftp -oPort=${SFTP_PORT} ${SFTP_USER}@localhost"
echo "  Password: ${SFTP_PASS}"
echo ""
echo "Connect with key:"
echo "  sftp -i ./keys/testuser -oPort=${SFTP_PORT} ${SFTP_USER}@localhost"

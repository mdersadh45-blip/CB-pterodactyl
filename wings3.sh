WINGS3 INSTALLER

Save the following as "wings3-installer.sh":

#!/bin/bash

set -e

echo "======================================"
echo "        WINGS3 INSTALLER"
echo "======================================"

echo "[1/9] Starting Debian VM..."
docker run -it --rm \
  -v "$PWD/vmdata:/vmdata" \
  -e RAM=7900 \
  -e CPU=3 \
  -e DISK_SIZE=100G \
  nothingtheking/debian-vm

echo "[2/9] Installing Docker Compose..."
apt update
apt install docker-compose -y

echo "[3/9] Creating Pterodactyl Wings directory..."
mkdir -p pterodactyl/wings
cd pterodactyl/wings || exit 1

echo "[4/9] Creating docker-compose.yml..."

cat > docker-compose.yml <<'EOF'
version: '3.8'

services:
  wings:
    image: ghcr.io/pterodactyl/wings:v1.6.1
    restart: always
    networks:
      - wings0
    ports:
      - "8080:8080"
      - "2022:2022"
      - "443:443"
    tty: true
    environment:
      TZ: "UTC"
      WINGS_UID: 988
      WINGS_GID: 988
      WINGS_USERNAME: pterodactyl
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - /var/lib/docker/containers/:/var/lib/docker/containers/
      - /etc/pterodactyl/:/etc/pterodactyl/
      - /var/lib/pterodactyl/:/var/lib/pterodactyl/
      - /var/log/pterodactyl/:/var/log/pterodactyl/
      - /tmp/pterodactyl/:/tmp/pterodactyl/
      - /etc/ssl/certs:/etc/ssl/certs:ro

networks:
  wings0:
    name: wings0
    driver: bridge
    ipam:
      config:
        - subnet: 172.21.0.0/16
    driver_opts:
      com.docker.network.bridge.name: wings0
EOF

echo "[5/9] Starting Wings..."
docker compose up -d

echo "[6/9] Starting Serveo tunnel..."
ssh -R 80:localhost:443 serveo.net

echo "[7/9] Opening Pterodactyl configuration..."
cd /pterodactyl

nano /etc/pterodactyl/config.yml

echo "[8/9] Entering Wings directory..."
cd wings

echo "[9/9] Recreating Wings container..."
docker compose up -d --force-recreate

echo "======================================"
echo "       WINGS3 INSTALLATION DONE"
echo "======================================"

Make it executable:

chmod +x wings3-installer.sh

Run it:

sudo bash wings3-installer.sh

Important: Your "docker run ... --rm" command is interactive and exits when you leave the VM, so the commands after it will not execute inside that VM. Also, "ssh -R ... serveo.net" is interactive and can prevent the following commands from running until the SSH session ends. For a truly automatic first-to-last installer, those two parts need to be changed.

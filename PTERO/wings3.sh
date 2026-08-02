#!/bin/bash

clear
echo "======================================"
echo "       WINGS 3 INSTALLER"
echo "======================================"
echo
echo "WINGS INSTALLATION"
echo

read -p "Start WINGS installation? (yes/no): " confirm

if [[ "$confirm" != "yes" ]]; then
    echo "Installation cancelled."
    exit 0
fi

echo
echo "[1/7] Installing Wings..."
bash <(curl -s https://raw.githubusercontent.com/unnamed-boy07/pterodactyl/refs/heads/main/pt-wings)

echo
echo "[2/7] Entering pterodactyl directory..."
cd pterodactyl || {
    echo "ERROR: pterodactyl directory not found."
    exit 1
}

echo
echo "[3/7] Switching to root..."
sudo su

echo
echo "[4/7] Opening Wings configuration..."
nano /etc/pterodactyl/config.yml

echo
echo "======================================"
echo "CONFIGURATION STEP"
echo "======================================"
echo "Paste the config.yml configuration"
echo "copied from your Pterodactyl Panel."
echo
read -p "Press ENTER after you have saved the config..."

echo
echo "[6/7] Entering wings directory..."
cd wings || {
    echo "ERROR: wings directory not found."
    exit 1
}

echo
echo "[7/7] Starting Wings..."
docker compose up -d --force-recreate

echo
echo "======================================"
echo "       WINGS INSTALLATION DONE"
echo "======================================"
echo
echo "Wings should now be running."

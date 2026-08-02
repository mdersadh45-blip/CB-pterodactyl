WINGS INSTALLER

#!/bin/bash

clear

echo "========================================="
echo "          WINGS INSTALLER"
echo "========================================="
echo

read -p "Start Wings installation? (yes/no): " confirm
if [[ "$confirm" != "yes" ]]; then
    echo "Installation cancelled."
    exit 0
fi

echo
echo "[1/5] Switching to root..."
sudo su

echo
echo "[2/5] Installing Wings..."
bash <(curl -s https://raw.githubusercontent.com/freediamodns/sanjitpanel/refs/heads/main/wings)

echo
read -p "Continue to Pterodactyl directory? (yes/no): " confirm
if [[ "$confirm" != "yes" ]]; then
    exit 0
fi

cd pterodactyl || {
    echo "ERROR: pterodactyl directory not found."
    exit 1
}

echo
echo "[3/5] Opening Wings configuration..."
echo "Edit /etc/pterodactyl/config.yml and paste your Wings configuration."
echo

read -p "Open config.yml now? (yes/no): " confirm
if [[ "$confirm" == "yes" ]]; then
    nano /etc/pterodactyl/config.yml
else
    echo "Skipped config editor."
fi

echo
read -p "Continue to Wings directory? (yes/no): " confirm
if [[ "$confirm" != "yes" ]]; then
    exit 0
fi

cd wings || {
    echo "ERROR: wings directory not found."
    exit 1
}

echo
echo "[4/5] Starting Wings..."
docker compose up -d --force-recreate

echo
echo "========================================="
echo "       WINGS INSTALLATION COMPLETE"
echo "========================================="
echo
echo "Wings Docker containers have been started."

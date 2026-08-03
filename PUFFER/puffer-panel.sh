#!/bin/bash

clear

echo "========================================"
echo "        PUFFER INSTALLER"
echo "========================================"
echo ""

echo "[1/7] Switching to root..."
sudo su

echo "[2/7] Updating and upgrading packages..."
apt update && apt upgrade -y

echo "[3/7] Installing systemctl..."
apt install -y systemctl

echo "[4/7] Installing systemd..."
apt install -y systemd

echo "[5/7] Installing PufferPanel..."
bash <(curl -s https://raw.githubusercontent.com/RasINGamerZ/Puffer-panel-installer/refs/heads/main/puffer-panel)

echo "[6/7] Creating PufferPanel user..."
pufferpanel user add

echo "[7/7] Enabling PufferPanel service..."
systemctl enable --now pufferpanel

echo "[7/7] Running PufferPanel service command again..."
systemctl enable --now pufferpanel

echo ""
echo "========================================"
echo "     PUFFER INSTALLATION COMPLETED"
echo "========================================"

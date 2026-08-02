#!/bin/bash

clear

echo "╔══════════════════════════════════════╗"
echo "║       PUFFER PANEL INSTALLER          ║"
echo "╠══════════════════════════════════════╣"
echo "║  1. Install                           ║"
echo "║  2. Playit Agent                      ║"
echo "║  3. Exit                              ║"
echo "╚══════════════════════════════════════╝"
echo ""

read -p "Select an option [1-3]: " choice

case $choice in

1)
    clear
    echo "╔══════════════════════════════════════╗"
    echo "║       PUFFER PANEL INSTALLER          ║"
    echo "╚══════════════════════════════════════╝"
    echo ""

    echo "[1/3] Installing PufferPanel..."
    bash <(curl -s https://raw.githubusercontent.com/unnamed-boy07/pterodactyl/refs/heads/main/puffer-panel)

    echo ""
    echo "[2/3] Create PufferPanel Admin User..."
    sudo pufferpanel user add

    echo ""
    echo "[3/3] Starting PufferPanel..."
    sudo systemctl enable --now pufferpanel

    echo ""
    echo "Starting PufferPanel again..."
    sudo systemctl enable --now pufferpanel

    echo ""
    echo "╔══════════════════════════════════════╗"
    echo "║     PUFFER PANEL INSTALLED!          ║"
    echo "╚══════════════════════════════════════╝"
    ;;

2)
    clear
    echo "╔══════════════════════════════════════╗"
    echo "║          PLAYIT AGENT                 ║"
    echo "╚══════════════════════════════════════╝"
    echo ""

    echo "[1/3] Downloading Playit Agent..."
    wget https://github.com/playit-cloud/playit-agent/releases/download/v0.15.26/playit-linux-amd64

    echo ""
    echo "[2/3] Making Playit Agent executable..."
    chmod +x playit-linux-amd64

    echo ""
    echo "[3/3] Starting Playit Agent..."
    ./playit-linux-amd64
    ;;

3)
    clear
    echo "Goodbye!"
    exit 0
    ;;

*)
    echo ""
    echo "Invalid option!"
    exit 1
    ;;

esac

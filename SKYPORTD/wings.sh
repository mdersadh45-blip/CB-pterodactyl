#!/bin/bash

# Colors
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[0;33m'
NC='\033[0m'

# Message function
echo_message() {
    echo -e "${CYAN}$1${NC}"
}

clear

echo -e "${GREEN}"
echo "  ███████╗██╗  ██╗██╗   ██╗██████╗  ██████╗"
echo "  ██╔════╝██║ ██╔╝╚██╗ ██╔╝██╔══██╗██╔═══██╗"
echo "  ███████╗█████╔╝  ╚████╔╝ ██║  ██║██║   ██║"
echo "  ╚════██║██╔═██╗   ╚██╔╝  ██║  ██║██║   ██║"
echo "  ███████║██║  ██╗   ██║   ██████╔╝╚██████╔╝"
echo "  ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═════╝  ╚═════╝"
echo -e "${NC}"

echo_message "* Installing Dependencies"

# Update package list and install dependencies
sudo apt update
sudo apt install -y curl software-properties-common git

# Install Node.js 20
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs

echo_message "* Installing SkyportD"

# Clone and install SkyportD
git clone https://github.com/achul123/skyportd.git
cd skyportd || exit 1

npm install

echo_message "* cd skyportd"
echo_message "* Paste your configure code"
echo_message "* pm2 start ."

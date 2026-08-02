#!/bin/bash

# ASCII Art
ascii_art='
  ███████╗██╗  ██╗██╗   ██╗██████╗  ██████╗
  ██╔════╝██║ ██╔╝╚██╗ ██╔╝██╔══██╗██╔═══██╗
  ███████╗█████╔╝  ╚████╔╝ ██║  ██║██║   ██║
  ╚════██║██╔═██╗   ╚██╔╝  ██║  ██║██║   ██║
  ███████║██║  ██╗   ██║   ██████╔╝╚██████╔╝
  ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═════╝  ╚═════╝
'

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[0;33m'
NC='\033[0m'

# Clear the screen
clear

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}Please run this script as root.${NC}"
  exit 1
fi

echo -e "${CYAN}$ascii_art${NC}"

echo -e "${YELLOW}* Installing Dependencies${NC}"

# Update package list and install dependencies
apt update
apt install -y curl software-properties-common git zip unzip

# Install Node.js 20
curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
apt-get install -y nodejs

echo -e "${GREEN}* Installed Dependencies${NC}"

echo -e "${CYAN}* Installing Files${NC}"

# Clone repository and install files
git clone https://github.com/dragonlabsdev/daemon
cd daemon

unzip daemon.zip
cd daemon

npm install

echo -e "${GREEN}* Installed Files${NC}"

echo -e "${YELLOW}* cd daemon && cd daemon${NC}"
echo -e "${CYAN}* Paste your configure${NC}"

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

curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
apt-get install -y nodejs

echo -e "${GREEN}* Installed Dependencies${NC}"

# Create directory, clone repository, and install files
echo -e "${CYAN}* Installing Panel${NC}"

git clone https://github.com/teryxlabs/v4panel
mv v4panel panel
cd panel

unzip panel.zip
cd panel

npm install
npm run seed
npm run createUser

npm install -g pm2

echo -e "${GREEN}* Installed Files${NC}"
echo -e "${GREEN}* Panel is installed successfully!${NC}"

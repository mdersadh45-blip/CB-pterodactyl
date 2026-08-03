#!/bin/bash

# CODESANDBOX INSTALLER
# A interactive menu to set up Panels, VMs, and Proxmox.

# Ensure script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Error: Please run this script as root (sudo)."
  exit 1
fi

# Color Definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Helper function to pause execution
pause() {
  echo ""
  read -p "Press [ENTER] to return to the menu..."
}

# Clear Terminal Header
show_header() {
  clear
  echo -e "${CYAN}====================================================${NC}"
  echo -e "${YELLOW}               CODESANDBOX INSTALLER               ${NC}"
  echo -e "${CYAN}====================================================${NC}"
  echo ""
}

# --- PTERODACTYL SUBMENU ---
pterodactyl_menu() {
  while true; do
    show_header
    echo -e "${GREEN}--- Pterodactyl Installation Options ---${NC}"
    echo "1) Install Pterodactyl Panel"
    echo "2) Install Pterodactyl Wings"
    echo "3) Back to Panels Menu"
    echo ""
    read -p "Select an option [1-3]: " p_choice

    case $p_choice in
      1)
        echo -e "\n${YELLOW}Running Pterodactyl Panel Installer...${NC}\n"
        bash <(curl -sSL https://raw.githubusercontent.com/mdersadh45-blip/CB-pterodactyl/main/PTERO/cb-installer.sh)
        pause
        ;;
      2)
        echo -e "\n${YELLOW}Running Pterodactyl Wings Installer...${NC}\n"
        bash <(curl -sSL https://raw.githubusercontent.com/mdersadh45-blip/CB-pterodactyl/main/PTERO/wings3.sh)
        pause
        ;;
      3)
        break
        ;;
      *)
        echo -e "${RED}Invalid option!${NC}"
        sleep 1
        ;;
    esac
  done
}

# --- SKYPORTD SUBMENU ---
skyportd_menu() {
  while true; do
    show_header
    echo -e "${GREEN}--- Skyport Panel Installation Options ---${NC}"
    echo "1) Install Skyport Panel"
    echo "2) Install Skyport Daemon/Wings"
    echo "3) Back to Panels Menu"
    echo ""
    read -p "Select an option [1-3]: " s_choice

    case $s_choice in
      1)
        echo -e "\n${YELLOW}Running Skyport Panel Installer...${NC}\n"
        bash <(curl -sSL https://raw.githubusercontent.com/mdersadh45-blip/CB-pterodactyl/main/SKYPORTD/install.sh)
        pause
        ;;
      2)
        echo -e "\n${YELLOW}Running Skyport Wings Installer...${NC}\n"
        bash <(curl -sSL https://raw.githubusercontent.com/mdersadh45-blip/CB-pterodactyl/main/SKYPORTD/wings.sh)
        pause
        ;;
      3)
        break
        ;;
      *)
        echo -e "${RED}Invalid option!${NC}"
        sleep 1
        ;;
    esac
  done
}

# --- PANELS CATEGORY MENU ---
panels_menu() {
  while true; do
    show_header
    echo -e "${GREEN}--- Select Panel Installer ---${NC}"
    echo "1) Pterodactyl Panel & Wings"
    echo "2) PufferPanel Installer"
    echo "3) Teryx Panel Installer"
    echo "4) Skyport Panel & Wings"
    echo "5) Back to Main Menu"
    echo ""
    read -p "Select an option [1-5]: " panel_choice

    case $panel_choice in
      1)
        pterodactyl_menu
        ;;
      2)
        echo -e "\n${YELLOW}Running PufferPanel Installer...${NC}\n"
        bash <(curl -s https://raw.githubusercontent.com/mdersadh45-blip/CB-pterodactyl/main/PUFFER/puffer-panel.sh)
        pause
        ;;
      3)
        echo -e "\n${YELLOW}Running Teryx Panel Installer...${NC}\n"
        bash <(curl -s teryxpanel.subhanplays.qzz.io)
        pause
        ;;
      4)
        skyportd_menu
        ;;
      5)
        break
        ;;
      *)
        echo -e "${RED}Invalid option!${NC}"
        sleep 1
        ;;
    esac
  done
}

# --- MAIN MENU ---
main_menu() {
  while true; do
    show_header
    echo "1) Panels (Pterodactyl, PufferPanel, Teryx, Skyport)"
    echo "2) VM Installer"
    echo "3) Proxmox Installer"
    echo "4) Exit"
    echo ""
    read -p "Select an option [1-4]: " main_choice

    case $main_choice in
      1)
        panels_menu
        ;;
      2)
        echo -e "\n${YELLOW}Running VM Setup Installer...${NC}\n"
        bash <(curl -sSL https://raw.githubusercontent.com/mdersadh45-blip/CB-pterodactyl/main/cb-vm)
        pause
        ;;
      3)
        echo -e "\n${YELLOW}Running Proxmox Installer script...${NC}\n"
        bash <(curl -sSL "https://raw.githubusercontent.com/mdersadh45-blip/CB-pterodactyl/main/install%20proxmox.txt")
        pause
        ;;
      4)
        echo -e "\n${GREEN}Exiting CODESANDBOX INSTALLER. Goodbye!${NC}\n"
        exit 0
        ;;
      *)
        echo -e "${RED}Invalid option!${NC}"
        sleep 1
        ;;
    esac
  done
}

# Run Main Menu
main_menu

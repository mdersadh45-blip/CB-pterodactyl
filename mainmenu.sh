#!/usr/bin/env bash

# ==========================================
#         CODESANDBOX INSTALLER
# ==========================================

# Colors for UI
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Helper Function to Run Remote Scripts safely
run_remote_script() {
    local url="$1"
    local name="$2"
    
    echo -e "\n${GREEN}[+] Executing ${name}...${NC}\n"
    bash <(curl -sSL "$url")
    
    echo -e "\n${CYAN}[✔] Process finished for ${name}.${NC}"
    read -rp "Press Enter to return to the menu..."
}

# ------------------------------------------
# PANELS MENU
# ------------------------------------------
panels_menu() {
    while true; do
        clear
        echo -e "${CYAN}==========================================${NC}"
        echo -e "${YELLOW}           CODESANDBOX - PANELS           ${NC}"
        echo -e "${CYAN}==========================================${NC}"
        echo -e "1) Pterodactyl Panel"
        echo -e "2) Pterodactyl Wings"
        echo -e "3) PufferPanel"
        echo -e "4) Draco Panel"
        echo -e "5) Draco Daemon (Wings)"
        echo -e "6) Skyportd Panel"
        echo -e "7) Skyportd Wings"
        echo -e "8) Back to Main Menu"
        echo -e "${CYAN}==========================================${NC}"
        read -rp "Select an option [1-8]: " choice

        case $choice in
            1)
                run_remote_script "https://raw.githubusercontent.com/mdersadh45-blip/CB-pterodactyl/main/PTERO/cb-installer.sh" "Pterodactyl Panel Installer"
                ;;
            2)
                run_remote_script "https://raw.githubusercontent.com/mdersadh45-blip/CB-pterodactyl/main/PTERO/wings3.sh" "Pterodactyl Wings Installer"
                ;;
            3)
                run_remote_script "https://raw.githubusercontent.com/mdersadh45-blip/CB-pterodactyl/main/PUFFERPANEL/puffer.sh" "PufferPanel Installer"
                ;;
            4)
                run_remote_script "https://raw.githubusercontent.com/mdersadh45-blip/CB-pterodactyl/main/Draco/install.sh" "Draco Panel Installer"
                ;;
            5)
                run_remote_script "https://raw.githubusercontent.com/mdersadh45-blip/CB-pterodactyl/main/Draco/wings.sh" "Draco Daemon"
                ;;
            6)
                run_remote_script "https://raw.githubusercontent.com/mdersadh45-blip/CB-pterodactyl/main/SKYPORTD/install.sh" "Skyportd Panel Installer"
                ;;
            7)
                run_remote_script "https://raw.githubusercontent.com/mdersadh45-blip/CB-pterodactyl/main/SKYPORTD/wings.sh" "Skyportd Wings Installer"
                ;;
            8)
                break
                ;;
            *)
                echo -e "${RED}Invalid option! Please choose between 1-8.${NC}"
                sleep 1.5
                ;;
        esac
    done
}

# ------------------------------------------
# MAIN MENU
# ------------------------------------------
main_menu() {
    while true; do
        clear
        echo -e "${CYAN}==========================================${NC}"
        echo -e "${YELLOW}          CODESANDBOX INSTALLER           ${NC}"
        echo -e "${CYAN}==========================================${NC}"
        echo -e "1) Panels"
        echo -e "2) VM"
        echo -e "3) Proxmox"
        echo -e "4) Exit"
        echo -e "${CYAN}==========================================${NC}"
        read -rp "Select an option [1-4]: " choice

        case $choice in
            1)
                panels_menu
                ;;
            2)
                run_remote_script "https://raw.githubusercontent.com/mdersadh45-blip/CB-pterodactyl/main/cb-vm" "VM Setup Script"
                ;;
            3)
                run_remote_script "https://raw.githubusercontent.com/mdersadh45-blip/CB-pterodactyl/main/install%20proxmox.txt" "Proxmox Installation Script"
                ;;
            4)
                echo -e "\n${GREEN}Exiting CodeSandbox Installer. Goodbye!${NC}\n"
                exit 0
                ;;
            *)
                echo -e "${RED}Invalid option! Please choose between 1-4.${NC}"
                sleep 1.5
                ;;
        esac
    done
}

# Ensure script runs as root
if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}[!] Please run this script as root (sudo ./installer.sh).${NC}"
  exit 1
fi

# Start Installer
main_menu

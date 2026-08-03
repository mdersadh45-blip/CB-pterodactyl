#!/usr/bin/env bash

# ==========================================
# CODESANDBOX INSTALLER
# ==========================================

# Clear screen and show header
clear
echo "=========================================="
echo "          CODESANDBOX INSTALLER           "
echo "=========================================="
echo ""
echo "Select an option to proceed:"
echo "1) Panels"
echo "2) VM"
echo "3) Proxmox"
echo ""
read -p "Enter your choice [1-3]: " main_choice

case $main_choice in
    1)
        clear
        echo "=========================================="
        echo "            PANELS MENU                   "
        echo "=========================================="
        echo "1) Pterodactyl Panel"
        echo "2) Pterodactyl Wings"
        echo "3) PufferPanel Installer"
        echo "4) Teryx Panel Installer"
        echo "5) Skyportd Panel"
        echo "6) Skyportd Wings"
        echo ""
        read -p "Enter panel choice [1-6]: " panel_choice
        echo ""

        case $panel_choice in
            1)
                echo "--> Running Pterodactyl Panel Installer..."
                bash <(curl -sSL https://raw.githubusercontent.com/mdersadh45-blip/CB-pterodactyl/main/PTERO/cb-installer.sh)
                ;;
            2)
                echo "--> Running Pterodactyl Wings Installer..."
                bash <(curl -sSL https://raw.githubusercontent.com/mdersadh45-blip/CB-pterodactyl/main/PTERO/wings3.sh)
                ;;
            3)
                echo "--> Running PufferPanel Installer..."
                bash <(curl -s https://raw.githubusercontent.com/mdersadh45-blip/CB-pterodactyl/main/PUFFER/puffer-panel.sh)
                ;;
            4)
                echo "--> Running Teryx Panel Installer..."
                bash <(curl -s teryxpanel.subhanplays.qzz.io)
                ;;
            5)
                echo "--> Running Skyportd Panel Installer..."
                bash <(curl -sSL https://raw.githubusercontent.com/mdersadh45-blip/CB-pterodactyl/main/SKYPORTD/install.sh)
                ;;
            6)
                echo "--> Running Skyportd Wings Installer..."
                bash <(curl -sSL https://raw.githubusercontent.com/mdersadh45-blip/CB-pterodactyl/main/SKYPORTD/wings.sh)
                ;;
            *)
                echo "Invalid option. Exiting."
                exit 1
                ;;
        esac
        ;;

    2)
        echo ""
        echo "--> Running VM Installer..."
        bash <(curl -sSL https://raw.githubusercontent.com/mdersadh45-blip/CB-pterodactyl/main/cb-vm)
        ;;

    3)
        echo ""
        echo "--> Running Proxmox Installer..."
        bash <(curl -sSL "https://raw.githubusercontent.com/mdersadh45-blip/CB-pterodactyl/main/install%20proxmox.txt")
        ;;

    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

echo ""
echo "Execution finished."
exit 0

#!/bin/bash

# ==========================================
#          PUFFER INSTALLER
# ==========================================

clear
echo "=========================================="
echo "          PUFFER INSTALLER"
echo "=========================================="
echo ""
echo "This installer will run the commands"
echo "one by one."
echo ""

read -p "Press Enter to start..."

# Step 1
clear
echo "=========================================="
echo "STEP 1/4 - Installing PufferPanel"
echo "=========================================="
echo ""

bash <(curl -s https://raw.githubusercontent.com/RasINGamerZ/Puffer-panel-installer/refs/heads/main/puffer-panel)

echo ""
read -p "Step 1 completed. Press Enter for Step 2..."

# Step 2
clear
echo "=========================================="
echo "STEP 2/4 - Creating PufferPanel User"
echo "=========================================="
echo ""

sudo pufferpanel user add

echo ""
read -p "Step 2 completed. Press Enter for Step 3..."

# Step 3
clear
echo "=========================================="
echo "STEP 3/4 - Enabling PufferPanel"
echo "=========================================="
echo ""

sudo systemctl enable --now pufferpanel

echo ""
read -p "Step 3 completed. Press Enter for Step 4..."

# Step 4
clear
echo "=========================================="
echo "STEP 4/4 - Starting PufferPanel"
echo "=========================================="
echo ""

sudo systemctl enable --now pufferpanel

echo ""
echo "=========================================="
echo "       INSTALLATION COMPLETED"
echo "=========================================="
echo ""
echo "PufferPanel installation process finished."
echo ""

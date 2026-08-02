#!/bin/bash
# ============================================================
#                 PTERO WINGS INSTALLER
# ============================================================

set -e

clear

echo "============================================================"
echo "                 PTERO WINGS INSTALLER"
echo "============================================================"
echo
echo "Pterodactyl Wings Installation Guide with SSL & Cloudflare Tunnel"
echo
echo "This installer follows the supplied guide step-by-step."
echo "Every command waits for YES before the next command runs."
echo
echo "============================================================"

ask_yes() {
    local message="$1"
    while true; do
        echo
        read -r -p "$message Type YES to continue: " answer
        if [[ "$answer" == "YES" || "$answer" == "yes" || "$answer" == "y" || "$answer" == "Y" ]]; then
            return 0
        fi
        echo "Waiting for YES..."
    done
}

run_command() {
    local title="$1"
    local command="$2"

    echo
    echo "============================================================"
    echo "$title"
    echo "============================================================"
    echo
    echo "Command:"
    echo "$command"
    echo

    ask_yes "Run this command?"

    echo
    echo "Running..."
    bash -c "$command"

    echo
    echo "Command completed."
}

echo
echo "### 1. Install Wings"
echo
echo "Install Wings using the Pterodactyl installer."
echo
run_command "STEP 1 - Install Wings" \
'bash <(curl -s https://pterodactyl-installer.se)'

echo
echo "### 2. Create Your Wings Node"
echo
echo "- Add your node inside the Pterodactyl Panel."
echo
echo "This step is done manually in your Pterodactyl Panel."
echo "Create/add your Wings node before continuing."
ask_yes "Have you added your node inside the Pterodactyl Panel?"

echo
echo "### 3. Setup Cloudflare Tunnel"
echo
echo "1. Go to Cloudflare Dashboard: https://dash.cloudflare.com"
echo "2. Create a tunnel on port localhost:8080 (use HTTP connection)."
echo "3. Copy your tunnel public hostname (example: wings.example.com)."
echo "4. Paste this domain in the FQDN field of your panel."
echo
echo "This step is done manually."
ask_yes "Have you completed the Cloudflare Tunnel setup and added the hostname to FQDN?"

echo
echo "### 4. Setup SSL for Localhost"
echo
echo "Run the following commands one by one."
echo
run_command "STEP 4.1 - Create SSL directory" \
'mkdir -p /etc/certs'

run_command "STEP 4.2 - Enter SSL directory" \
'cd /etc/certs'

run_command "STEP 4.3 - Create SSL certificate" \
'openssl req -new -newkey rsa:4096 -days 3650 -nodes -x509 -subj "/C=NA/ST=NA/L=NA/O=NA/CN=Generic SSL Certificate" -keyout privkey.pem -out fullchain.pem'

echo
echo "📌 Code credit: How2MCoffic"

echo
echo "### 5. Edit Wings Configuration"
echo
echo "Open the config file:"
echo
echo "nano /etc/pterodactyl/config.yml"
echo
echo "After opening it, update the SSL section to:"
echo
echo "ssl:"
echo "   enabled: false"
echo "   cert: /etc/certs/fullchain.pem"
echo "   key: /etc/certs/privkey.pem"
echo

ask_yes "Are you ready to open the Wings configuration file?"

echo
echo "Running:"
echo "nano /etc/pterodactyl/config.yml"
echo
nano /etc/pterodactyl/config.yml

echo
echo "Have you updated the SSL section exactly as shown in the guide?"
ask_yes "Continue to Step 6?"

echo
echo "### 6. Debug Wings"
echo
run_command "STEP 6 - Debug Wings" \
'wings --debug'

echo
echo "The debug command may keep running in the foreground."
echo "If it is running correctly, stop it with CTRL+C before continuing."
ask_yes "Have you finished checking the Wings debug output?"

echo
echo "### 7. Fix Network Errors (if any)"
echo
echo "The following command is only needed if you have a network error."
echo

ask_yes "Do you want to run the network fix command?"

run_command "STEP 7 - Fix Network Errors" \
'docker network create --driver bridge --subnet 172.30.0.0/16 pterodactyl_nw'

echo
echo "### 8. Start Wings Service"
echo
run_command "STEP 8 - Start Wings Service" \
'systemctl start wings'

echo
echo "### 9. Final Node Settings"
echo
echo "If your node doesn't come online:"
echo
echo "Go to:"
echo "https://ptero.example.com/admin/nodes/view/1/settings"
echo
echo "Change Daemon Port from 8080 → 443"
echo "Save changes ✅"
echo
ask_yes "Have you checked the final node settings / completed the required panel changes?"

echo
echo "============================================================"
echo "🎉 Success"
echo "============================================================"
echo
echo "Your Pterodactyl Wings should now be running successfully"
echo "with SSL enabled!"
echo
echo "============================================================"
echo "📝 Credits"
echo "============================================================"
echo "- Guide: ITZ_YTANSH"
echo "- SSL Code Snippet: How2MCoffic"
echo "- Codes: HopingBoyz"
echo
echo "============================================================"
echo "             PTERO WINGS INSTALLER DONE"
echo "============================================================"

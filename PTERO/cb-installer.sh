#!/bin/bash
set -e

# =========================================================
#                   SKYDO PTERO INSTALLER
# =========================================================
clear
echo -e "\e[1;36m"
echo "  ____  _  ____   ______   ___    ____ _____ _____ ____   ___  "
echo " / ___|| |/ /\ \ / /  _ \ / _ \  |  _ \_   _| ____|  _ \ / _ \ "
echo " \___ \| ' /  \ V /| | | | | | | | |_) || | |  _| | |_) | | | |"
echo "  ___) | . \   | | | |_| | |_| | |  __/ | | | |___|  _ <| |_| |"
echo " |____/|_|\_\  |_| |____/ \___/  |_|    |_| |_____|_| \_\\\\___/ "
echo "                                                               "
echo "                 INSTALLER AUTOMATION SCRIPT                   "
echo -e "\e[0m"
echo -e "\e[1;32mStarting installation sequence...\e[0m\n"

# 1. System updates & install docker-compose
echo -e "\e[1;33m[1/12] Updating apt repositories...\e[0m"
apt update

echo -e "\e[1;33m[2/12] Installing docker-compose...\e[0m"
apt install docker-compose -y

# 2. Directory creation
echo -e "\e[1;33m[3/12] Creating directory structure...\e[0m"
mkdir -p pterodactyl/panel
cd pterodactyl/panel

# 3. Clean and write docker-compose.yml
echo -e "\e[1;33m[4/12] Creating docker-compose.yml...\e[0m"
rm -f docker-compose.yml

cat > docker-compose.yml <<'EOF'
services:
  database:
    image: mariadb:10.5
    restart: always
    command: --default-authentication-plugin=mysql_native_password
    volumes:
      - "./data/database:/var/lib/mysql"
    environment:
      MYSQL_ROOT_PASSWORD: "PteroRoot@2026#K7"
      MYSQL_DATABASE: "panel"
      MYSQL_USER: "pterodactyl"
      MYSQL_PASSWORD: "PteroDB@2026#X9"

  cache:
    image: redis:alpine
    restart: always

  panel:
    image: ghcr.io/pterodactyl/panel:latest
    restart: always
    depends_on:
      - database
      - cache
    ports:
      - "8030:80"
    volumes:
      - "./data/var:/app/var"
      - "./data/nginx:/etc/nginx/http.d"
      - "./data/certs:/etc/letsencrypt"
      - "./data/logs:/app/storage/logs"
    environment:
      APP_URL: "http://localhost:8030"
      APP_TIMEZONE: "UTC"
      APP_SERVICE_AUTHOR: "noreply@localhost"
      TRUSTED_PROXIES: "*"
      APP_ENV: "production"
      APP_ENVIRONMENT_ONLY: "false"
      DB_HOST: "database"
      DB_PORT: "3306"
      DB_DATABASE: "panel"
      DB_USERNAME: "pterodactyl"
      DB_PASSWORD: "PteroDB@2026#X9"
      CACHE_DRIVER: "redis"
      SESSION_DRIVER: "redis"
      QUEUE_DRIVER: "redis"
      REDIS_HOST: "cache"
      REDIS_PORT: "6379"
      MAIL_MAILER: "log"
      MAIL_FROM_ADDRESS: "noreply@localhost"

networks:
  default:
    ipam:
      config:
        - subnet: 172.20.0.0/16
EOF

# 4. Validate configuration
echo -e "\e[1;33m[5/12] Validating docker compose config...\e[0m"
docker compose config

# 5. Create storage directories
echo -e "\e[1;33m[6/12] Creating local data volumes...\e[0m"
mkdir -p ./data/database ./data/var ./data/nginx ./data/certs ./data/logs

# 6. Start containers
echo -e "\e[1;33m[7/12] Starting Docker services...\e[0m"
docker compose up -d

# Wait for MariaDB initialization
echo -e "\e[1;33mWaiting 15 seconds for MariaDB database to initialize...\e[0m"
sleep 15

# 7. Configure MySQL client (Phase 1)
echo -e "\e[1;33m[8/12] Configuring Panel MySQL settings (Pass 1)...\e[0m"
docker compose exec panel sh -c "mkdir -p /etc/mysql && printf '[client]\nssl-mode=DISABLED\nskip-ssl=1\n' > /etc/mysql/my.cnf"

# 8. Clear artisan config (Phase 1)
echo -e "\e[1;33m[9/12] Clearing artisan config (Pass 1)...\e[0m"
docker compose exec panel php artisan config:clear

# 9. Configure MySQL client (Phase 2)
echo -e "\e[1;33m[10/12] Configuring Panel MySQL settings (Pass 2)...\e[0m"
docker compose exec panel sh -c "mkdir -p /etc/mysql && printf '[client]\nskip-ssl\n' > /etc/mysql/my.cnf"

# 10. Clear artisan config (Phase 2)
echo -e "\e[1;33m[11/12] Clearing artisan config (Pass 2)...\e[0m"
docker compose exec panel php artisan config:clear

# 11. Run migrations
echo -e "\e[1;33m[12/12] Running database migrations...\e[0m"
docker compose exec panel php artisan migrate --seed --force

# 12. Create administrator user
echo -e "\e[1;32mCreating administrative user account...\e[0m"
docker compose exec panel php artisan p:user:make

echo -e "\n\e[1;32m=========================================================\e[0m"
echo -e "\e[1;32m       SKYDO PTERO INSTALLER COMPLETED SUCCESSFULLY!      \e[0m"
echo -e "\e[1;32m=========================================================\e[0m"

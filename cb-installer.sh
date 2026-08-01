#!/bin/bash

clear

echo "======================================================"
echo "              SKYDO PTERO INSTALLER"
echo "======================================================"
echo "        Pterodactyl Panel Installation Script"
echo "======================================================"
echo

echo "[ SKYDO ] Starting installation..."
echo

echo "[1] apt update"
apt update

echo
echo "[2] Installing docker-compose"
apt install docker-compose -y

echo
echo "[3] Creating pterodactyl directory"
mkdir pterodactyl
cd pterodactyl

echo
echo "[4] Creating panel directory"
mkdir panel
cd panel

echo
echo "[5] Removing old docker-compose.yml"
rm -f docker-compose.yml

echo
echo "[6] Creating docker-compose.yml"
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

echo
echo "[7] Checking docker-compose configuration"
docker compose config

echo
echo "[8] Creating data directories"
mkdir -p ./data/database ./data/var ./data/nginx ./data/certs ./data/logs

echo
echo "[9] Starting Pterodactyl"
docker compose up -d

echo
echo "[10] Configuring MySQL client"
docker compose exec panel sh -c "mkdir -p /etc/mysql && printf '[client]\nssl-mode=DISABLED\nskip-ssl=1\n' > /etc/mysql/my.cnf"

echo
echo "[11] Clearing Laravel configuration"
docker compose exec panel php artisan config:clear

echo
echo "[12] Configuring MySQL client"
docker compose exec panel sh -c "mkdir -p /etc/mysql && printf '[client]\nskip-ssl\n' > /etc/mysql/my.cnf"

echo
echo "[13] Clearing Laravel configuration"
docker compose exec panel php artisan config:clear

echo
echo "[14] Running database migrations"
docker compose exec panel php artisan migrate --seed --force

echo
echo "[15] Creating Pterodactyl user/admin account"
docker compose exec panel php artisan p:user:make

echo
echo "======================================================"
echo "             SKYDO PTERO INSTALLER"
echo "                  COMPLETED"
echo "======================================================"
echo

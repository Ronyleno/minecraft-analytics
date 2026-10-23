#!/bin/bash

# 1. Запускаем миграции (создаем структуру таблиц Superset в базе данных)
echo "Running database migrations..."
superset db upgrade

# 2. Автоматически создаем учетную запись администратора с данными из docker-compose
echo "Creating admin user..."
superset fab create-admin \
    --username "${SUPERSET_ADMIN_USERNAME}" \
    --firstname "${SUPERSET_ADMIN_FIRSTNAME}" \
    --lastname "${SUPERSET_ADMIN_LASTNAME}" \
    --email "${SUPERSET_ADMIN_EMAIL}" \
    --password "${SUPERSET_ADMIN_PASSWORD}"

# 3. Инициализируем стандартные роли, группы и права доступа к API
echo "Initializing Superset roles and permissions..."
superset init

# 4. Запускаем официальный веб-сервер Superset, чтобы контейнер продолжал работать
echo "Starting Superset Web Server..."
/usr/bin/run-server.sh

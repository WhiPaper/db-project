#!/bin/sh

DB_HOST=${MYSQL_HOST}
DB_PORT=${MYSQL_PORT}
DB_USER=${MYSQL_USER}
DB_PASS=${MYSQL_PASSWORD}
DB_NAME=${MYSQL_DATABASE}

if [ -f db/schema.sql ]; then
    echo "Initializing database schema.."
    mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" < db/schema.sql
fi
if [ -f db/seed_data.sql ]; then
    echo "Applying dummy data..."
    mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" < db/seed_data.sql
fi

PORT=${PORT:-8080}
cd web || exit 1
echo "PHP server listening on port $PORT..."
php -S 0.0.0.0:$PORT

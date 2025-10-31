#!/bin/bash
set -e

# Init DB schema
if [ -f db/schema.sql ]; then
  echo "Initializing MySQL schema..."
  mysql -h "$MYSQLHOST" -P "$MYSQLPORT" -u "$MYSQLUSER" -p"$MYSQLPASSWORD" "$MYSQLDATABASE" < db/schema.sql
else
  echo "No schema.sql found, skipping initialization."
fi

# Seeding data
if [ -f db/seed.sql ]; then
  echo "Seeding data..."
  mysql -h "$MYSQLHOST" -P "$MYSQLPORT" -u "$MYSQLUSER" -p"$MYSQLPASSWORD" "$MYSQLDATABASE" < db/seed.sql
else
  echo "No seed.sql found, skipping data seeding."
fi

# Start PHP built-in server
echo "Starting PHP server..."
php -S 0.0.0.0:8080 -t public

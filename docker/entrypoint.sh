#!/bin/sh
set -e

# Fix storage permissions (bind mount overrides build-time chown)
chown -R www-data:www-data storage bootstrap/cache

# Remove old package discovery cache so Laravel regenerates it
rm -f bootstrap/cache/packages.php

echo "Running Laravel migrations..."
php artisan migrate --force

echo "Starting PHP-FPM..."
exec php-fpm

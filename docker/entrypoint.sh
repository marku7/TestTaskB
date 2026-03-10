#!/bin/bash
set -e

# Remove old package discovery cache so Laravel regenerates it
rm -f bootstrap/cache/packages.php

echo "Running Laravel migrations..."
php artisan migrate --force

echo "Starting PHP-FPM..."
exec php-fpm

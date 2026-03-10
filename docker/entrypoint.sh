#!/bin/sh
set -e

cd /var/www

echo "Fixing Laravel permissions..."

# Ensure required directories and log file exist
mkdir -p storage/framework/sessions storage/framework/views storage/framework/cache storage/logs bootstrap/cache
touch storage/logs/laravel.log

# Fix permissions
chmod -R 777 storage bootstrap/cache

echo "Clearing Laravel caches..."
php artisan optimize:clear || true

echo "Waiting for database..."

# Simple DB wait loop (prevents migration failure)

until php -r "new PDO('mysql:host=${DB_HOST:-db};port=${DB_PORT:-3306}', '${DB_USERNAME:-root}', '${DB_PASSWORD:-}');" 2>/dev/null; do
echo "Database not ready yet..."
sleep 2
done

echo "Running Laravel migrations..."
php artisan migrate --force || true

echo "Starting PHP-FPM..."
exec php-fpm

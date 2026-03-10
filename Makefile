setup:
	@cp -n .env.example .env || true
	docker compose up -d --build
	docker compose exec app composer install
	docker compose exec app php artisan key:generate --ansi
	docker compose exec app php artisan migrate --force
	docker compose exec app php artisan db:seed --force
	npm install || echo "npm not found, please install node/npm to build frontend assets"
	npm run build || true
	
# Build images
build:
	docker compose build

# Start all containers
run:
	docker compose up -d

# Stop and remove containers
down:
	docker compose down -v

# Restart all containers
restart:
	docker compose restart

# Follow logs (all services); use `make logs s=app` for a single service
logs:
	docker compose logs -f $(s)

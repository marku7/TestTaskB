setup:
	@cp -n .env.example .env || true
	docker compose up -d --build
	docker compose exec app composer install
	docker compose exec app php artisan key:generate --ansi
	docker compose exec app php artisan migrate --force
	docker compose exec app php artisan db:seed --force
	npm run build || true
	sudo chown -R $(USER):$(USER) .

	
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

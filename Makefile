setup:
	@cp -n .env.example .env || true
	docker compose up -d --build
	docker compose exec app php artisan key:generate --ansi
	

# Build images
build:
	docker compose build

# Start all containers
run:
	docker compose up -d

# Stop and remove containers
down:
	docker compose down

# Restart all containers
restart:
	docker compose restart

# Follow logs (all services); use `make logs s=app` for a single service
logs:
	docker compose logs -f $(s)

# Open a shell in the app container
shell:
	docker compose exec app bash

# Run migrations
migrate:
	docker compose exec app php artisan migrate --force

# Run seeders
seed:
	docker compose exec app php artisan db:seed

# Run tests inside the app container
test:
	docker compose exec app php artisan test

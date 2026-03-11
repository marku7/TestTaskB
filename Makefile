DOCKER_COMPOSE = docker compose

setup:
	@cp -n .env.example .env || true
	@APP_KEY="base64:$$(openssl rand -base64 32 | tr -d '\n')"; \
	sed -i "s|^APP_KEY=.*|APP_KEY=$$APP_KEY|" .env
	$(DOCKER_COMPOSE) down -v
	$(DOCKER_COMPOSE) up -d --build
	docker run --rm -v $(CURDIR):/app -w /app --entrypoint composer composer:latest install --no-interaction --optimize-autoloader --ignore-platform-reqs
	$(DOCKER_COMPOSE) exec app php artisan optimize:clear
	$(DOCKER_COMPOSE) exec -u www-data app php artisan migrate --force
	$(DOCKER_COMPOSE) exec -u www-data app php artisan db:seed --force
	$(DOCKER_COMPOSE) exec app sh -c "npm install && npm run build"
    $(DOCKER_COMPOSE) exec app php artisan optimize:clear
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

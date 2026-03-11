DOCKER_COMPOSE = docker compose

setup:
	@cp -n .env.example .env || true
	@APP_KEY="base64:$$(openssl rand -base64 32 | tr -d '\n')"; \
	sed -i "s|^APP_KEY=.*|APP_KEY=$$APP_KEY|" .env
	$(DOCKER_COMPOSE) up -d --build
	$(DOCKER_COMPOSE) exec app composer install
	$(DOCKER_COMPOSE) exec app php artisan optimize:clear
	$(DOCKER_COMPOSE) exec -u www-data app php artisan migrate --force
	$(DOCKER_COMPOSE) exec -u www-data app php artisan db:seed --force
	npm install && npm run build || true
	sudo chown -R $(USER):$(USER) .

run-fresh: 
	sed -i "s|^APP_KEY=.*|APP_KEY=$$APP_KEY|" .env
	$(DOCKER_COMPOSE) down -v
	$(DOCKER_COMPOSE) up -d --build
	docker run --rm -v $(CURDIR):/app -w /app --entrypoint composer composer:latest install --no-interaction --optimize-autoloader --ignore-platform-reqs
	$(DOCKER_COMPOSE) exec app php artisan migrate --force
	npm install && npm run build


	
# Build images
build:
	$(DOCKER_COMPOSE) build

# Start all containers
run:
	$(DOCKER_COMPOSE) up -d

# Stop and remove containers
down:
	$(DOCKER_COMPOSE) down -v

# Restart all containers
restart:
	$(DOCKER_COMPOSE) restart

# Follow logs (all services); use `make logs s=app` for a single service
logs:
	$(DOCKER_COMPOSE) logs -f $(s)

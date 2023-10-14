.PHONY: db-reset db-migrate db-rollback db-refresh db-create up build composer-install code-fix-all code-fix-changed code-fix-test

up: ## Create and start the services
	docker compose up --detach

build: ## Build or rebuild the services
	docker compose build --pull --no-cache

composer-install: ## Install the dependencies
	docker compose exec php sh -lc 'composer install'

db-reset: ## database drop and create
	docker compose exec php sh -lc 'php artisan db:drop && php artisan db:create'

db-migrate: ##start the database migration
	docker compose exec php sh -lc 'php artisan migrate'

#rollback for last migration
db-rollback:
	docker compose exec php sh -lc 'php artisan migrate:rollback'

#db-reset and db-migrate
db-refresh: db-reset db-migrate

db-create: db-refresh
	docker compose exec php sh -lc 'php artisan db:seed'

php:
	docker exec -it binance_index-php-1 /bin/sh

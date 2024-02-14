PROJECT_NAME ?= 'portofolio'
DOCKER_COMPOSE := $(shell command -v docker-compose 2> /dev/null || echo docker compose)

include make/*.mk

## Installation and update
## ----------
.PHONY: install-front install
install-front: ## Install npm dependencies
	make create-env;
	$(DOCKER_COMPOSE) run --user ${LOCAL_USER_UID}:${LOCAL_USER_GID} --rm node sh -c "npm install;";
install: ## Install dependencies
	make create-env;
	make install-front;

.PHONY: update-front update
update-front: ## Update npm dependencies
	$(DOCKER_COMPOSE) run --user ${LOCAL_USER_UID}:${LOCAL_USER_GID} --rm node sh -c "yarn upgrade;";
update: ## Update dependencies
	make update-front;

.PHONY: create-env
create-env: ## Create env file
	cp .env.example .env

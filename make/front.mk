##
## Front globals
## ----------
.PHONY: build dev generate preview npm-command
front-build: ## Build assets from nuxt
	$(DOCKER_COMPOSE) run --user ${LOCAL_USER_UID}:${LOCAL_USER_GID} --rm node sh -c "npm run build;";
front-dev: ## Run dev mod for nuxt
	$(DOCKER_COMPOSE) run --user ${LOCAL_USER_UID}:${LOCAL_USER_GID} --rm node sh -c "npm run dev;";
front-generate: ## Build static HTML from nuxt
	$(DOCKER_COMPOSE) run --user ${LOCAL_USER_UID}:${LOCAL_USER_GID} --rm node sh -c "npm run generate;";
front-preview: ## Launch preview before to test code before deploy
	$(DOCKER_COMPOSE) run --user ${LOCAL_USER_UID}:${LOCAL_USER_GID} --rm node sh -c "npm run preview;";
front-npm-command: ## Launch any npm command with COMMAND parameter
	$(DOCKER_COMPOSE) run --user ${LOCAL_USER_UID}:${LOCAL_USER_GID} --rm node sh -c "npm ${COMMAND}";

##
## Front qualimetry
## ----------
.PHONY: front-lint front-lint-fix front-type-check
front-lint: ## Lint front with ESLINT
	$(DOCKER_COMPOSE) run --user ${LOCAL_USER_UID}:${LOCAL_USER_GID} --rm node sh -c "npm run lint;";
front-lint-fix: ## Lint front and fix resolvable errors with ESLINT
	$(DOCKER_COMPOSE) run --user ${LOCAL_USER_UID}:${LOCAL_USER_GID} --rm node sh -c "npm run lint:fix;";
front-type-check: ## Check TS types
	$(DOCKER_COMPOSE) run --user ${LOCAL_USER_UID}:${LOCAL_USER_GID} --rm node sh -c "npx nuxi typecheck;";
front-style-lint: ## Lint front SCSS files
	$(DOCKER_COMPOSE) run --user ${LOCAL_USER_UID}:${LOCAL_USER_GID} --rm node sh -c "npm run scss-lint;";
front-style-lint-fix: ## Lint front and fix SCSS files
	$(DOCKER_COMPOSE) run --user ${LOCAL_USER_UID}:${LOCAL_USER_GID} --rm node sh -c "npm run scss-fix;";

##
## Front commands
## ----------
.PHONY: build dev generate preview postinstall npm-command
build:
	$(DOCKER_COMPOSE) run --user ${LOCAL_USER_UID}:${LOCAL_USER_GID} --rm node sh -c "npm run build;";
dev:
	$(DOCKER_COMPOSE) run --user ${LOCAL_USER_UID}:${LOCAL_USER_GID} --rm node sh -c "npm run dev;";
generate:
	$(DOCKER_COMPOSE) run --user ${LOCAL_USER_UID}:${LOCAL_USER_GID} --rm node sh -c "npm run generate;";
preview:
	$(DOCKER_COMPOSE) run --user ${LOCAL_USER_UID}:${LOCAL_USER_GID} --rm node sh -c "npm run preview;";
postinstall:
	$(DOCKER_COMPOSE) run --user ${LOCAL_USER_UID}:${LOCAL_USER_GID} --rm node sh -c "npm run postinstall;";
npm-command:
	$(DOCKER_COMPOSE) run --user ${LOCAL_USER_UID}:${LOCAL_USER_GID} --rm node sh -c "npm ${COMMAND}";

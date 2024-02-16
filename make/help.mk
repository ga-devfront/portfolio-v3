# Colors
COLOR_RESET   = \033[0m
COLOR_INFO    = \033[32m
COLOR_COMMENT = \033[33m
COLOR_COMMAND = \033[01m\033[34m

.DEFAULT_GOAL := help

.PHONY: help
help:
	@cat ./Makefile make/*.mk | grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)'  | awk 'BEGIN {FS = ":.*?## "}; {printf "$(COLOR_COMMAND)%-20s$(COLOR_RESET) %s\n", $$1, $$2}' | sed -e 's/\[34m##/[32m/'
	@echo ''

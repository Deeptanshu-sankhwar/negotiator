SHELL = /usr/bin/env bash -o pipefail

default: help

.PHONY: help
help:
	# Usage:
	@sed -n '/^\([a-z][^:]*\).*/s//    make \1/p' $(MAKEFILE_LIST)

.PHONY: web-components/install
web-components/install:
	npm install --prefix web-components && pushd web-components && npx playwright install-deps chromium && npx playwright install chromium && popd

.PHONY: web-components/build
web-components/build:
	npm run build --prefix web-components

.PHONY: web-components/watch
web-components/watch:
	npm run build:watch --prefix web-components

.PHONY: web-components/test
web-components/test:
	npm run test --prefix web-components

.PHONY: negotiator/run
negotiator/install:
	uv sync

.PHONY: negotiator/run
negotiator/run:
	uv run -m negotiator

.PHONY: fake-auth/run
fake-auth/run:
	uv run fake_auth_server.py

.PHONY: migrate
migrate:
	uv run alembic upgrade head

.PHONY: migrate-test
migrate-test:
	DATABASE_URL='postgresql://localhost:5432/negotiator_test?user=negotiator&password=negotiator' uv run alembic upgrade head

.PHONY: negotiator/type-checks
negotiator/type-checks:
	uv run mypy negotiator tests

.PHONY: negotiator/test
negotiator/test: negotiator/type-checks
	uv run -m unittest;

.PHONY: test
test: negotiator/test web-components/test

.PHONY: install
install: negotiator/install web-components/install

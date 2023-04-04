default: help

setup-source-db: ## Setup a local database with source data for dbt
	source-data/scripts/setup-schema-and-data.sh

clean-source-db: ## Cleanup the local source data for dbt and all materialized tables/views from dbt
	source-data/scripts/clean-schema-and-data.sh

reset-source-db: ## Clean then Setup the dbt data to have a clean slate
	source-data/scripts/reset-schema-and-data.sh

install-dependencies: install-python-dependencies install-dbt-dependencies

install-python-dependencies:
	pip install -r requirements.txt

install-dbt-dependencies:
	cd acme-corp && dbt deps

help: ## This message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: setup-source-db clean-source-db reset-source-db
.PHONY: help

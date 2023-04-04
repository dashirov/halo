default: help

run-transforms: ## Run dbt transformations
	dbt run

test: ## Run dbt test on transformed data.  This technically depends on dbt run but making it a dependency is not performant
	dbt test

lint: ## Lint SQL with sqlfluff and produce a report
	sqlfluff lint --config ../.sqlfluff

lint-fix: ## Attempt to fix sqlfluff lint errors automatically - some errors cannot be resolved
	sqlfluff fix --config ../.sqlfluff

help: ## This message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: run-transforms test lint lint-fix
.PHONY: help

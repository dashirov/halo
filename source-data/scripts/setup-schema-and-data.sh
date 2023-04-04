#!/bin/bash

set -eou pipefail

SEEDS_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../seeds

POSTGRES_PARAMS=(-h "${POSTGRES_HOSTNAME}" -U "${POSTGRES_USER}")
POSTGRES_PARAMS_WITH_DB=("${POSTGRES_PARAMS[@]}" "${POSTGRES_DB}")
POSTGRES_COPY_CSV_PARAMS="CSV HEADER"

psql "${POSTGRES_PARAMS[@]}" -f "${SEEDS_DIR}/schema.sql"
psql "${POSTGRES_PARAMS_WITH_DB[@]}" -c "\copy acme.customers FROM ${SEEDS_DIR}/acme_customers.csv ${POSTGRES_COPY_CSV_PARAMS}"
psql "${POSTGRES_PARAMS_WITH_DB[@]}" -c "\copy acme.orders FROM ${SEEDS_DIR}/acme_orders.csv ${POSTGRES_COPY_CSV_PARAMS}"
psql "${POSTGRES_PARAMS_WITH_DB[@]}" -c "\copy stripe.payment FROM ${SEEDS_DIR}/stripe_payments.csv ${POSTGRES_COPY_CSV_PARAMS}"

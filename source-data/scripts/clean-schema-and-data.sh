#!/bin/bash

set -eou pipefail

SOURCES_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/..
POSTGRES_PARAMS=(-h "${POSTGRES_HOSTNAME}" -U "${POSTGRES_USER}")

psql "${POSTGRES_PARAMS[@]}" -f "${SOURCES_DIR}/seeds/cleanup.sql"

#!/bin/bash

set -eou pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

${SCRIPT_DIR}/clean-schema-and-data.sh
${SCRIPT_DIR}/setup-schema-and-data.sh

#!/usr/bin/env bash
set -e

HERE=${BASH_SOURCE%/*}

${HERE}/build-db.sh
${HERE}/build-migrations.sh

GIT_ID=$(git rev-parse --short=7 HEAD)

${HERE}/start.sh ${GIT_ID}

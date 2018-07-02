#!/usr/bin/env bash
set -ex

GIT_ID=$(git rev-parse --short=7 HEAD)
GIT_BRANCH=$(git symbolic-ref --short HEAD)
NAME=auth-migrate

TAG=$NAME
COMMIT_TAG=$NAME:$GIT_ID
BRANCH_TAG=$NAME:$GIT_BRANCH
DB=montagu-db:$GIT_ID

## Get directory of the 'scripts/' directory
DIR=$(dirname "$(readlink -f "$0")")

docker build \
       --tag $COMMIT_TAG \
       --tag $BRANCH_TAG \
       -f migrations/Dockerfile \
       .

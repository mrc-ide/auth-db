#!/usr/bin/env bash
set -e

GIT_ID=$(git rev-parse --short=7 HEAD)
GIT_BRANCH=$(git symbolic-ref --short HEAD)
NAME=auth-db

APP_DOCKER_TAG=$NAME
APP_DOCKER_COMMIT_TAG=$NAME:$GIT_ID
APP_DOCKER_BRANCH_TAG=$NAME:$GIT_BRANCH

docker build \
       --tag $APP_DOCKER_COMMIT_TAG \
       --tag $APP_DOCKER_BRANCH_TAG \
       .

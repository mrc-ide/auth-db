#!/usr/bin/env bash
set -ex
docker build --tag auth-db .
docker run --rm -d -p 5432:5432 --name auth-db auth-db

(cd migrations && docker build --tag auth-migrate .)
docker run --network=host auth-migrate migrate -url=jdbc:postgresql://localhost/auth

watch docker logs auth-db

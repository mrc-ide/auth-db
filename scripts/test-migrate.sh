#!/usr/bin/env bash
set -ex

DB_CONTAINER=db
DB_IMAGE=auth_db
MIGRATE_IMAGE=auth_migrate
NETWORK=db_nw

docker build --tag $DB_IMAGE .
docker build --tag $MIGRATE_IMAGE -f migrations/Dockerfile .

function cleanup {
    set +e
    docker stop $DB_CONTAINER
    docker network rm $NETWORK
}
trap cleanup EXIT

docker network create $NETWORK

docker run --rm --network=$NETWORK -d --name $DB_CONTAINER $DB_IMAGE

# Do the migrations
docker run --rm --network=$NETWORK $MIGRATE_IMAGE -configFile=conf/flyway-annex.conf migrate
docker run --rm --network=$NETWORK $MIGRATE_IMAGE

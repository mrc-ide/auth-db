#!/usr/bin/env bash
## Starts a container:
##
##   db
##
## On the network
##
##   db_nw
set -e

if (( "$#" < 1 || "$#" > 2 )); then
    echo "Usage: start.sh <DB_VERSION> [<DB_PORT>]"
    echo "Starts the database using the specified image"
    echo "version. If DB_PORT is provided, exposes the database on the "
    echo "host machine at that port."
    exit 1
fi

set -ex
DB_VERSION=$1
DB_PORT=$2

PORT_MAPPING=
if [[ ! -z $DB_PORT ]]; then
    PORT_MAPPING="-p $DB_PORT:5432"
fi

DB_IMAGE=auth-db:$DB_VERSION
MIGRATE_IMAGE=auth-migrate:$DB_VERSION

DB_CONTAINER=db
DB_PORT=5432    # Exposed on host machine
NETWORK=db_nw

function cleanup {
    set +e
    docker stop $DB_CONTAINER
    docker network rm $NETWORK
}
trap cleanup EXIT

docker network create $NETWORK

# First the core database:
docker run --rm --network=$NETWORK -d \
    --name $DB_CONTAINER $PORT_MAPPING $DB_IMAGE

# Do the migrations
docker run --rm --network=$NETWORK $MIGRATE_IMAGE -configFile=conf/flyway-annex.conf migrate
docker run --rm --network=$NETWORK $MIGRATE_IMAGE

trap - EXIT

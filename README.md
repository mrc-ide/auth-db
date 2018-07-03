## Entrypoints
1. `scripts/build-db.sh`. This builds an image called `auth-db` 
containing a postgres database called `auth` with user `auth` and password `changeme`. 
1. `scripts/build-migrations.sh`. This builds an image called `auth-migrations` which can
 be run to apply migrations to the database, including the first migration which creates an initial schema. 
 For more details see the README in the migrations folder.
1. `scripts/start.sh`. Takes two command line parameters, the version of the image you want to run, and 
the port you want to expose the database on (the latter defaults to 5432). Starts the database and 
runs migrations. Requires the images to already 
exist on your machine.
1. `scripts/stop.sh`. Stops a running db image.
1. `scripts/build-and-run.sh`. First builds the images and then executes `start.sh`.
1. `scripts/clear-docker.sh`. Stops and cleans up any running docker processes.

## Data
For persistent data, mount a volume into the database image at `/pgdata`.

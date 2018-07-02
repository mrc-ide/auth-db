# Database migrations
We are using [Flyway](https://flywaydb.org/) for database migrations.

## Write a new migration
Add a new file to `sql`. This should be named following this scheme:

```
Vyear.month.day.hour.minute__Description.sql
```

These migrations can be applied by running the `auth-migrate` image that gets
built from this repository by running `./scripts/build-migrations.sh`.

The `auth-migrate` image expects the database to be running and accessible 
at:

* host: `db`
* port: `5432`
* user: `auth`
* password: `changeme`

You can override these by passing in command line options. Please see the Flyway
docs for more details.

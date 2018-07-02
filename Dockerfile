FROM postgres:9.6.2

COPY bin /db-bin
ENV PATH="/db-bin:$PATH"

ENV POSTGRES_DB auth
ENV POSTGRES_USER auth
ENV POSTGRES_PASSWORD changeme
# This is needed to override the loss of data that happens if you
# don't mount a persistent volume at the mount point.
ENV PGDATA /pgdata

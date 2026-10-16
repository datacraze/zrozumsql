# Local PostgreSQL

PostgreSQL 18 with [pgvector](https://github.com/pgvector/pgvector) pre-installed, for running the course scripts locally.

## Start

```bash
cd docker
docker compose up -d
```

Connection details (local use only, the port is bound to `127.0.0.1`):

| Setting  | Value       |
|----------|-------------|
| Host     | `localhost` |
| Port     | `5432`      |
| User     | `postgres`  |
| Password | `postgres`  |
| Database | `postgres`  |

```bash
psql postgresql://postgres:postgres@localhost:5432/postgres
# or without a local psql client
docker exec -it zrozumsql-postgres psql -U postgres
```

The `vector` and `pgcrypto` extensions are created in `postgres` and in `template1`, so every new database gets them as well.

## Stop and reset

```bash
docker compose down      # stop, keep data
docker compose down -v   # stop and delete the data volume
```

Scripts in `init/` run only on the first start with an empty volume. After changing them, reset with `docker compose down -v`.

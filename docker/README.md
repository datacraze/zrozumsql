# Local PostgreSQL

Two independent PostgreSQL 18 instances with [pgvector](https://github.com/pgvector/pgvector) pre-installed, each with its own data volume:

| Container   | Purpose                 | Port   |
|-------------|-------------------------|--------|
| `datacraze` | general purpose         | `5433` |
| `zrozumsql` | Zrozum SQL course work  | `5444` |

## Start

```bash
cd docker
docker compose up -d             # both
docker compose up -d zrozumsql   # only one
```

Connection details (local use only, ports are bound to `127.0.0.1`):

| Setting  | Value                                      |
|----------|--------------------------------------------|
| Host     | `localhost`                                |
| Port     | `5433` (`datacraze`) or `5444` (`zrozumsql`) |
| User     | `postgres`                                 |
| Password | `postgres`                                 |
| Database | `postgres`                                 |

```bash
psql postgresql://postgres:postgres@localhost:5433/postgres   # datacraze
psql postgresql://postgres:postgres@localhost:5444/postgres   # zrozumsql
# or without a local psql client
docker exec -it zrozumsql psql -U postgres
```

The `vector` and `pgcrypto` extensions are created in `postgres` and in `template1`, so every new database gets them as well.

## Stop and reset

```bash
docker compose down                 # stop both, keep data
docker compose down -v              # stop both and delete their data
docker compose rm -sf zrozumsql && docker volume rm datacraze_zrozumsql_data   # reset one
```

Scripts in `init/` run only on the first start with an empty volume. After changing them, reset the volume.

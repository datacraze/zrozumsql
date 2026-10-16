# zrozumsql
Repository of files and scripts used in course - Zrozum SQL.

Modified Readme.
## Local database

Local PostgreSQL 18 with pgvector (`datacraze` on port 5433, `zrozumsql` on port 5444) lives in [`docker/`](docker/README.md):

```bash
cd docker && docker compose up -d
```

## Pre-commit

```bash
pre-commit install
```

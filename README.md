# zrozumsql
Repository of files and scripts used in course - Zrozum SQL.

The whole course (in Polish) is free on YouTube:
[ZrozumSQL playlist](https://www.youtube.com/playlist?list=PL4Qkr29VTt1vJIcH417SIM5_rAxIgG1D1).

## Course materials

| Folder | Content |
|---|---|
| `zs_slides/Mxx/` | Lesson slides (PDF), named `ZS_M<module>L<lesson>_*.pdf` |
| `zs_m_<n>_scripts/` | SQL scripts shown in the lessons of module `n` |
| `zs_exercises/` | Module exercises: task PDFs (`*_TASKS_*.pdf`) and solutions (`*.sql`) |
| `zs_bonus_scripts/` | SQL scripts from the bonus videos |
## Local database

Local PostgreSQL 18 with pgvector (`datacraze` on port 5433, `zrozumsql` on port 5444) lives in [`docker/`](docker/README.md):

```bash
cd docker && docker compose up -d
```

## Pre-commit

```bash
pre-commit install
```

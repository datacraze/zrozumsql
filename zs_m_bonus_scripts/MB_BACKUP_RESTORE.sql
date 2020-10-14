pg_dump --host localhost ^
        --port 5433 ^
        --username postgres ^
        --file "D:\PostgreSQL_dump\db_postgres_dump" ^
        --format=d ^
        --clean ^
        postgres

pg_dump --host localhost ^
        --port 5433 ^
        --username postgres ^
        --format plain ^
        --file "D:\PostgreSQL_dump\db_postgres_dump_plain.sql" ^
        --clean ^
        postgres        

pg_restore --host localhost ^
           --port 5433 ^
           --username postgres ^
           --dbname postgres ^
           --clean ^
           "D:\PostgreSQL_dump\db_postgres_dump"   

psql -U postgres -p 5433 -h localhost -d postgres -f "D:\PostgreSQL_dump\db_postgres_dump_plain.sql"
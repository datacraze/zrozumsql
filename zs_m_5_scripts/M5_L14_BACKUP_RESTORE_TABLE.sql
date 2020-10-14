-- M5L14 - BACKUP TABLE 
DROP TABLE IF EXISTS sales;

CREATE TABLE sales (
	id SERIAL,
	sal_description TEXT,
	sal_date DATE,
	sal_value NUMERIC(10,2),
	added_by TEXT DEFAULT 'admin',
	created_date TIMESTAMP DEFAULT now()
);

INSERT INTO sales (sal_description, sal_date, sal_value)
     SELECT left(md5(i::text), 10),
	        NOW() + (random() * (interval '90 days')) + '30 days',
        	random() * 10 + 1        
       FROM generate_series(1, 20000) s(i);

SELECT COUNT(*) FROM sales;      
      
TRUNCATE TABLE sales RESTART IDENTITY;

pg_dump --host localhost ^
        --port 5433 ^
        --username postgres ^
        --format d ^
        --file "D:\PostgreSQL_dump\db_postgres_dump" ^
        --table public.sales ^
        postgres

pg_dump --host localhost ^
        --port 5433 ^
        --username postgres ^
        --format plain ^
        --file "D:\PostgreSQL_dump\public_sales_bp.sql" ^
        --table public.sales ^
        postgres

pg_restore --host localhost ^
           --port 5433 ^
           --username postgres ^
           --dbname postgres ^
           --clean ^
           "D:\PostgreSQL_dump\db_postgres_dump"    

psql -U postgres -p 5433 -h localhost -d postgres -f "D:\PostgreSQL_dump\public_sales_bp.sql"
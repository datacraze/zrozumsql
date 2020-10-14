-- M5L13 - INSERT CORNER CASES
DROP TABLE IF EXISTS sales;

CREATE TABLE sales (
	id SERIAL,
	sal_description TEXT,
	sal_date DATE,
	sal_value NUMERIC(10,2),
	added_by TEXT DEFAULT 'admin',
	created_date TIMESTAMP DEFAULT now()
);

EXPLAIN ANALYZE
INSERT INTO sales (sal_description, sal_date, sal_value)
     SELECT left(md5(i::text), 10),
	        NOW() + (random() * (interval '90 days')) + '30 days',
        	random() * 10 + 1        
       FROM generate_series(1, 20000) s(i);

SELECT COUNT(*) FROM sales;      
      
TRUNCATE TABLE sales RESTART IDENTITY;

-- Option 1 Execute Script Separate Inserts
-- Option 2 Execute Script Combined Inserts
-- Option 3 COPY
-- COPY public.sales TO 'D:\PostgreSQL_dump\M5_L13_SALES20K_COPY.copy';
-- COPY public.sales FROM 'D:\PostgreSQL_dump\M5_L13_SALES20K_COPY.copy';

-- Wiecej o COPY: https://postgresql.org/docs/12/sql-copy.html
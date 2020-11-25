-- ANULOWANIE BLOKUJACYCH ZAPYTAN

-- #1 DBeaver Lock Manager
--> Right Click DB > Tools > Lock Manager

DROP TABLE IF EXISTS products, sales, product_manufactured_region CASCADE;

CREATE TABLE products (
	id SERIAL,
	product_name VARCHAR(100),
	product_code VARCHAR(10),
	product_quantity NUMERIC(10,2),	
	manufactured_date DATE,
	product_man_region INTEGER,
	added_by TEXT DEFAULT 'admin',
	created_date TIMESTAMP DEFAULT now()
);

CREATE TABLE sales (
	id SERIAL,
	sal_description TEXT,
	sal_date DATE,
	sal_value NUMERIC(10,2),
	sal_prd_id INTEGER,
	added_by TEXT DEFAULT 'admin',
	created_date TIMESTAMP DEFAULT now()
);

CREATE TABLE product_manufactured_region (
	id SERIAL,
	region_name VARCHAR(25),
	region_code VARCHAR(10),
	established_year INTEGER
);

INSERT INTO product_manufactured_region (region_name, region_code, established_year)
	  VALUES ('EMEA', 'E_EMEA', 2010),
	  		 ('EMEA', 'W_EMEA', 2012),
	  		 ('APAC', NULL, 2019),
	  		 ('North America', NULL, 2012),
	  		 ('Africa', NULL, 2012);

INSERT INTO products (product_name, product_code, product_quantity, manufactured_date, product_man_region)
     SELECT 'Product '||floor(random() * 10 + 1)::int,
            'PRD'||floor(random() * 10 + 1)::int,
            random() * 10 + 1,
            CAST((NOW() - (random() * (interval '90 days')))::timestamp AS date),
            CEIL(random()*(10-5))::int
       FROM generate_series(1, 10) s(i);  
      
INSERT INTO sales (sal_description, sal_date, sal_value, sal_prd_id)
     SELECT left(md5(i::text), 15),
     		CAST((NOW() - (random() * (interval '60 days'))) AS DATE),	
     		random() * 100 + 1,
        	floor(random() * 10)+1::int            
       FROM generate_series(1, 10000) s(i); 
       
-- ADD 2 CONNECTIONS TURN OFF AUTOCOMMIT

--u1
UPDATE sales 
   SET sal_description = sal_description;
--u2 
DELETE 
  FROM sales 
 WHERE sal_value < 100;
 
-- LOOK INTO LOCK MANAGER

-- WAIT PID / WAIT USER
-- HOLD PID / HOLD USER 
-- WAIT STATEMENT

SELECT * FROM pg_catalog.pg_locks pl ;

SELECT DISTINCT 
	   bl.pid     AS blocked_pid,
	   bl.GRANTED, -- 	True if lock is held, false if lock is awaited
       a.usename  AS blocked_user,
       a.query    AS blocked_statement
  FROM pg_catalog.pg_locks bl
  JOIN pg_catalog.pg_stat_activity a ON a.pid = bl.pid
 WHERE bl.GRANTED IS FALSE;

SELECT activity.pid,
       activity.usename,
       activity.query,
       blocking.pid AS blocking_id,
       blocking.query AS blocking_query
  FROM pg_stat_activity AS activity
  JOIN pg_stat_activity AS blocking 
 	ON blocking.pid = ANY(pg_blocking_pids(activity.pid));

-- CANCEL
-- SELECT pg_cancel_backend(__ pid__);

SELECT pg_cancel_backend(22856);
-- KILL 	
-- SELECT pg_terminate_backend(__ pid__);

SELECT pg_terminate_backend(22856); 


-- LONG RUNNING QUERIES
SELECT pid,  
       now() - pg_stat_activity.query_start AS duration,
       query, 
       state  
  FROM pg_stat_activity
 WHERE (now() - pg_stat_activity.query_start) > interval '5 minutes'
--   AND state <> 'idle'
;

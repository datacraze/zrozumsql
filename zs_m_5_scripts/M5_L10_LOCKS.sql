-- M5L10 - LOCKS
DROP TABLE IF EXISTS products;

CREATE TABLE products (
	id SERIAL,
	product_name VARCHAR(100),
	product_code VARCHAR(10),
	product_quantity NUMERIC(10,2),
	manufactured_date DATE,	
	added_by TEXT DEFAULT 'admin',
	created_date TIMESTAMP DEFAULT now()
);

INSERT INTO products (product_name, product_code, product_quantity, manufactured_date)					    
 	 VALUES ('Product 1', 'PRD1', 100.25, '20/11/2019'),
 	 		('Product 2', 'PRD2', 12.25, '1/11/2019'),
 	 		('Product 3', 'PRD3', 25.25, '2/11/2019'),
 	 		('Product 4', 'PRD4', 68.25, '3/11/2019')
; 		

-- DEADLOCK
UPDATE products 
   SET product_name = 'Product 2.1'
 WHERE product_code = 'PRD2';

UPDATE products 
   SET product_name = 'Product 4.1'
 WHERE product_code = 'PRD4';

SELECT * FROM products;

-- CHECK LOCKS 
UPDATE products 
   SET product_name = 'Product 2.1'
 WHERE product_code = 'PRD2';

-- 2 USER
UPDATE products 
   SET product_name = 'Product 2.99'
 WHERE product_code = 'PRD2';

-- 3 USER 

SELECT pid, 
       usename, 
       pg_blocking_pids(pid) as blocked_by, 
       query as blocked_query
  FROM pg_stat_activity
 WHERE cardinality(pg_blocking_pids(pid)) > 0;
 
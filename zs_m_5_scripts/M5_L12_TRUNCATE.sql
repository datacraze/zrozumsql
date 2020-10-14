-- M5L12 - TRUNCATE
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

-- DELETE VS TRUNCATE (NO AUTOCOMMIT)
DELETE FROM products; 

SELECT * FROM products;

TRUNCATE products;

-- TRUNCATE AND SERIAL TYPE 
TRUNCATE products;

SELECT * FROM products;

TRUNCATE products RESTART IDENTITY;

-- DELETE VS TRUNCATE (TABLE SIZE)

DELETE FROM products; 
TRUNCATE products;

SELECT pg_size_pretty( pg_total_relation_size('products') );




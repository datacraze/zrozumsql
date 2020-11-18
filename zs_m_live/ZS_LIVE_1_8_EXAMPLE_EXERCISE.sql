DROP TABLE IF EXISTS products, product_manufactured_region CASCADE;

CREATE TABLE products (
	id SERIAL,
	product_name VARCHAR(100),
	product_code VARCHAR(10),
	product_quantity NUMERIC(10,2),
	manufactured_date DATE,	
	manufactured_region VARCHAR(25),
	added_by TEXT DEFAULT 'admin',
	created_date TIMESTAMP DEFAULT now()
);


INSERT INTO products (product_name, product_code, manufactured_region, product_quantity, manufactured_date)					    
 	 VALUES ('Product 1', 'PRD1', 'Europe', 100.25, '20/11/2019'),
 	 		('Product 1', 'PRD2', 'EMEA', 92.25, '1/11/2019'),
 	 		('Product 2', 'PRD2', 'APAC', 12.25, '1/11/2019'),
 	 		('Product 3', 'PRD3', 'APAC', 25.25, '2/11/2019'),
 	 		('Product 4', 'PRD4', 'North America', 68.25, '3/11/2019'),
 	 		('Product 5', NULL, NULL, 11.11, '12/12/2020'),
 	 		('Product 1', 'PRD1', 'EMEA', 211.11, '12/12/2020'),
 	 		('Product 3', 'PRD3', 'EMEA', 220.11, '12/12/2021')
;

-- [...]aby ewentualne zdublowane rekordy (tytuł, miasto) zastąpić 
-- pojedynczym rekordem, dodając jednocześnie kolumnę wskazującą ile 
-- rekordów zostało złączonych

SELECT product_name, product_code
  FROM products p;

SELECT DISTINCT product_name, product_code
  FROM products p; 
 
SELECT DISTINCT ON (product_name, product_code) 
	   p.*
  FROM products p;  
 
SELECT product_name, product_code, count(*)
  FROM products p
  GROUP BY product_name, product_code
  ORDER BY product_name, product_code;

SELECT p.*, 
       count(*) OVER (PARTITION BY product_name, product_code) AS count_of_dups
  FROM products p
 ORDER BY product_name, product_code;
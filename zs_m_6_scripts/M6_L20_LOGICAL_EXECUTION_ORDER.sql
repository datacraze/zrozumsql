-- M6L20 - LOGICZNY PLAN WYKONANIA 
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

-- 
SELECT *
  FROM products p
 WHERE product_name = 'Product 1';
 
--
SELECT p.product_name AS pname,
       p.product_code, 
       p.manufactured_date
  FROM products p 
 WHERE pname = 'Product 1';

--
SELECT p.product_name AS pname,
       p.product_code, 
       p.manufactured_date
  FROM products p 
 ORDER BY pname;

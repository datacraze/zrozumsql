-- M6L17: HAVING
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
 	 		('Product 1', 'PRD2', 92.25, '1/11/2019'),
 	 		('Product 2', 'PRD2', 12.25, '1/11/2019'),
 	 		('Product 3', 'PRD3', 25.25, '2/11/2019'),
 	 		('Product 4', 'PRD4', 68.25, '3/11/2020'),
 	 		('Product 4', 'PRD4', 68.25, NULL)
;

-- HAVING
SELECT product_code, product_quantity
  FROM products p 
HAVING product_quantity > 10
;

SELECT sum(product_quantity)
  FROM products p 
HAVING product_quantity > 10
; 

SELECT sum(product_quantity)
  FROM products p 
HAVING sum(product_quantity) > 100
; 

SELECT product_code, sum(product_quantity)
  FROM products p
GROUP BY product_code
HAVING product_code = 'PRD2'
; 

SELECT product_code, sum(product_quantity)
  FROM products p
GROUP BY product_code
HAVING sum(product_quantity) > 100
; 
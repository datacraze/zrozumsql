-- M5L5 - UPDATE 
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

-- UPDATE
UPDATE products SET product_quantity = 100;

SELECT * FROM products;

-- 
DELETE FROM products;

-- UPDATE WHERE
UPDATE products
   SET product_quantity = 99.98
 WHERE product_code = 'PRD1' 
   	   AND 
	   product_name = 'Product 0';

UPDATE products 
   SET product_quantity = 99.98
 WHERE product_code = 'PRD1' 
	   OR 
	   product_name = 'Product 2';

SELECT * FROM products;
	  
UPDATE products 
   SET product_quantity = 99.98
 WHERE product_code IN ('PRD1', 'PRD2');
     
UPDATE products 
   SET product_quantity = 99.98
 WHERE product_code NOT IN ('PRD1', 'PRD2');

SELECT ctid, * FROM products;


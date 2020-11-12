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
 	 		('Product 4', 'PRD4', 68.25, NULL),
            (NULL, 'PRD5', NULL, NULL)
;

-- CREATE VIEW
CREATE OR REPLACE VIEW products_manufactured_in_2019 AS
	SELECT product_name,
		   product_code,
		   product_quantity,
		   manufactured_date,
		   EXTRACT(YEAR FROM manufactured_date)
      FROM products 
     WHERE EXTRACT(YEAR FROM manufactured_date) = 2019;

-- SELECT
SELECT * FROM products_manufactured_in_2019;

-- DROP VIEW
DROP VIEW products_manufactured_in_2019;

-- RECREATE
CREATE OR REPLACE VIEW products_manufactured_in_2019 AS
	SELECT product_name,
		   product_code,
		   product_quantity,
		   manufactured_date,
		   EXTRACT(YEAR FROM manufactured_date) AS year_manufactured
      FROM products 
     WHERE EXTRACT(YEAR FROM manufactured_date) = 2019;
     
-- DROP TABLE?
DROP TABLE products;
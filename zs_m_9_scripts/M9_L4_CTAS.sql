DROP TABLE IF EXISTS products;

CREATE TABLE products (
	product_name VARCHAR(100),
	product_code VARCHAR(10),
	product_quantity NUMERIC(10,2),
	manufactured_date DATE
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

-- CTAS 
CREATE TABLE IF NOT EXISTS products_manufactured_in_2019 AS
	SELECT product_name,
		   product_code,
		   product_quantity,
		   manufactured_date,
		   EXTRACT(YEAR FROM manufactured_date)
      FROM products 
     WHERE EXTRACT(YEAR FROM manufactured_date) = 2019;

-- SELECT + DATA TYPES
SELECT * FROM products_manufactured_in_2019;

SELECT table_catalog, table_schema, column_name, data_type, udt_name
  FROM information_schema."columns" c 
 WHERE c.table_name = 'products_manufactured_in_2019'
   AND c.table_schema = 'public'

DROP TABLE products_manufactured_in_2019;


-- CTAS 
CREATE TABLE IF NOT EXISTS products_manufactured_in_2019 AS
	SELECT product_name,
		   product_code,
		   product_quantity,
		   manufactured_date,
		   EXTRACT(YEAR FROM manufactured_date)
      FROM products 
     WHERE EXTRACT(YEAR FROM manufactured_date) = 2019 
 WITH NO DATA;
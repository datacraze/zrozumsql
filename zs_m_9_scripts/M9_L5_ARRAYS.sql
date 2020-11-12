DROP TABLE IF EXISTS products CASCADE;

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

-- ARRAY
  SELECT EXTRACT(YEAR FROM manufactured_date) AS year_manufactured, 
	     product_code, 
	     array_agg(product_name)
    FROM products
   WHERE EXTRACT(YEAR FROM manufactured_date) = 2019
GROUP BY year_manufactured, product_code;

-- CTAS
CREATE TABLE aggregated_products AS 
  SELECT EXTRACT(YEAR FROM manufactured_date) AS year_manufactured, 
	     product_code, 
	     array_agg(product_name) AS prd_name_array
    FROM products
   WHERE EXTRACT(YEAR FROM manufactured_date) = 2019
GROUP BY year_manufactured, product_code;

-- SELECT
SELECT * FROM aggregated_products;

SELECT table_catalog, table_schema, column_name, data_type, udt_name
  FROM information_schema."columns" c 
 WHERE c.table_name = 'aggregated_products'
   AND c.table_schema = 'public'

-- SELECT 
SELECT *,
	   prd_name_array[1],
	   prd_name_array[2]
  FROM aggregated_products;

SELECT * 
  FROM aggregated_products
 WHERE 'Product 1' = ANY(prd_name_array);
 
-- IS EQUAL
SELECT *
  FROM aggregated_products
 WHERE product_code = 'PRD2'
   AND prd_name_array = '{Product 2, Product 1}';
  
SELECT *
  FROM aggregated_products
 WHERE product_code = 'PRD2'
   AND prd_name_array = '{Product 1, Product 2}';  
  
-- UPS
SELECT *
  FROM aggregated_products
 WHERE product_code = 'PRD2'
   AND prd_name_array = ARRAY['Product 1', 'Product 2'];    
  
-- DATA TYPES  
SELECT *
  FROM aggregated_products
 WHERE product_code = 'PRD2'
   AND prd_name_array = ARRAY['Product 1', 'Product 2']::varchar[]; 
  
SELECT *
  FROM aggregated_products
 WHERE product_code = 'PRD2'
   AND prd_name_array = CAST(ARRAY['Product 1', 'Product 2'] AS VARCHAR[]);  
  
-- UNNEST
SELECT year_manufactured,
       product_code,
       unnest(prd_name_array) AS product_name
  FROM aggregated_products;    
  
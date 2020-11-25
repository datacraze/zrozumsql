-- JAKOSC DANYCH
DROP TABLE IF EXISTS products CASCADE;

CREATE TABLE products (
	id SERIAL,
	product_name VARCHAR(100),
	product_code VARCHAR(10),
	product_quantity NUMERIC(10,2),	
	manufactured_date DATE
);

INSERT INTO products (product_name, product_code, product_quantity, manufactured_date)					    
 	 VALUES ('Product 1', 'PRD1', 100.25, '20/11/2019'),
		 	('Product 1', 'PRD1', 100.25, '20/11/2019'),
 	 		('PrOduCt 1', 'PRD2', 92.25, '1/11/2019'),
 	 		('Product 2', 'prd2', 12.25, '1/11/2019'),
 	 		('Product 3', 'NULL', 25.25, '2/11/2019'),
 	 		('Product 4', NULL, 68.25, NULL)
;

-- PROBLEMY
-- 1. Duplikaty
SELECT product_name, product_code, product_quantity, manufactured_date, count(*)
  FROM products 
 GROUP BY product_name, product_code, product_quantity, manufactured_date
 HAVING count(*) > 1;

-- 2. Niespójność
SELECT CASE 
		WHEN 'Product' = substring(product_name,1,7) THEN TRUE
		ELSE FALSE
	   END,
	   product_name
  FROM products;	 
 
SELECT * 
  FROM products
 WHERE product_code NOT LIKE 'PRD%' 
    OR product_code IS NULL;
   
-- JAK PORADZIC?   
SELECT upper(product_name),
	   product_name
  FROM products;	   

SELECT COALESCE(product_code,'<unknown>') AS product_code, 
       COALESCE(manufactured_date,'1900/01/01') AS manufactured_date,
	   *
  FROM products;
  
SELECT id, product_name, product_code, product_quantity, manufactured_date
  FROM (
	SELECT row_number() OVER (PARTITION BY product_name, 
										   product_code, 
										   product_quantity, 
										   manufactured_date 
							  ORDER BY id) rn,
		   *
	  FROM products
) sq
WHERE rn = 1;
	   
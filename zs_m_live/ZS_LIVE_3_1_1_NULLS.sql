-- NULLS

-- Jak najlepiej obsłużyć wartości Null w kolumnach stringowych? Co wtedy zamiast Null ? Blank string?

DROP TABLE IF EXISTS products CASCADE;

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
 	 		('Product 5', NULL, NULL, 11.11, '12/12/2020')
;

SELECT product_code,
	   COALESCE(product_code,'<unknown>') AS product_code2,
	   COALESCE(product_code,NULL,'<unknown>2') AS product_code2,
	   CASE 
	   		WHEN product_code IS NOT NULL THEN product_code
	   		WHEN NULL IS NOT NULL THEN NULL
	   		WHEN '<unknown>2' IS NOT NULL THEN '<unknown>2'
	   		ELSE ''
	    END AS product_code_case
  FROM products;
 
SELECT product_name,
	   product_code,
	   manufactured_region,
	   CASE 
	   		WHEN manufactured_region = 'EMEA' THEN 0.25 
	   		WHEN manufactured_region = 'APAC' THEN 0
	   		WHEN manufactured_region = 'North America' THEN 5
	   		ELSE 0
	   	END AS prd_discount_per_region
  FROM products;

SELECT * 
  FROM products
 WHERE product_code = NULL
--WHERE product_code is null
 ;


SELECT * 
  FROM products
 --WHERE product_code <> NULL
 --WHERE product_code NOT IN ('EMEA') -- OR product_code IS NULL
  WHERE coalesce(product_code,'<unknown>') NOT IN ('EMEA') 
--WHERE product_code is not null
 ;

SELECT COALESCE(product_name,'') || ' ' || COALESCE(product_code,'') || ' ' || COALESCE(manufactured_region,''),
	   CONCAT(product_name,' ',product_code,' ',manufactured_region),
       * 
  FROM products;


-- M10_L10_WSCHEPOTEZNY_NULL
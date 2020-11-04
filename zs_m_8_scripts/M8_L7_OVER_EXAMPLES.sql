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

CREATE TABLE product_manufactured_region (
	id SERIAL,
	region_name VARCHAR(25),
	region_code VARCHAR(10),
	established_year INTEGER
);

INSERT INTO products (product_name, product_code, manufactured_region, product_quantity, manufactured_date)					    
 	 VALUES ('Product 1', 'PRD1', 'Europe', 100.25, '20/11/2019'),
 	 		('Product 1', 'PRD2', 'EMEA', 92.25, '1/11/2019'),
 	 		('Product 2', 'PRD2', 'APAC', 12.25, '1/11/2019'),
 	 		('Product 3', 'PRD3', 'APAC', 25.25, '2/11/2019'),
 	 		('Product 4', 'PRD4', 'North America', 68.25, '3/11/2019'),
 	 		('Product 5', NULL, NULL, 11.11, '12/12/2020')
;

INSERT INTO product_manufactured_region (region_name, region_code, established_year)
	  VALUES ('EMEA', NULL, 2010),
	  		 ('APAC', NULL, 2019),
	  		 ('North America', NULL, 2012);

-- 
    SELECT p.*,
           pmr.* 
      FROM products p
 LEFT JOIN product_manufactured_region pmr ON pmr.region_name = p.manufactured_region
;

-- AVG per region name
    SELECT p.product_name,
    	   p.product_code,
    	   p.product_quantity, 
    	   pmr.region_name 
      FROM products p
 LEFT JOIN product_manufactured_region pmr ON pmr.region_name = p.manufactured_region
  ORDER BY p.product_code
;

SELECT p.product_name,
    	   p.product_code,
    	   p.product_quantity, 
    	   pmr.region_name,
    	   apr.region_name,
    	   apr.avg_per_region
      FROM products p
 LEFT JOIN product_manufactured_region pmr ON pmr.region_name = p.manufactured_region
 LEFT JOIN (SELECT pmr2.region_name,
                   avg(p2.product_quantity) avg_per_region
              FROM products p2
  	          JOIN product_manufactured_region pmr2 ON pmr2.region_name = p2.manufactured_region
 	      GROUP BY pmr2.region_name) apr ON apr.region_name = pmr.region_name
  ORDER BY p.product_code
;  

    SELECT p.product_name,
    	   p.product_code,
    	   p.product_quantity, 
   	       pmr.region_name,
    	   avg(p.product_quantity) OVER (PARTITION BY pmr.region_name) avg_per_region
      FROM products p
 LEFT JOIN product_manufactured_region pmr ON pmr.region_name = p.manufactured_region
  ORDER BY p.product_code
; 

    SELECT p.product_name,
    	   p.product_code,
    	   p.product_quantity, 
   	       pmr.region_name,
    	   CASE WHEN pmr.region_name IS NULL THEN NULL 
    	        ELSE avg(p.product_quantity) OVER (PARTITION BY pmr.region_name)
    	    END AS avg_per_region
      FROM products p
 LEFT JOIN product_manufactured_region pmr ON pmr.region_name = p.manufactured_region
  ORDER BY p.product_code
; 

-- OVER + PARTITION + ORDER BY

SELECT *,
	   extract(YEAR FROM manufactured_date) AS year_manufactured
  FROM products;

WITH prepared_products AS (
	SELECT product_name,
	       product_code,	
	       manufactured_date,
	       extract(YEAR FROM manufactured_date) AS year_manufactured
      FROM products
) SELECT product_name,
	     product_code,
	     manufactured_date,
		 ROW_NUMBER() OVER (PARTITION BY year_manufactured ORDER BY manufactured_date ASC)
    FROM prepared_products
ORDER BY 3,4;

WITH prepared_products AS (
	SELECT product_name,
	       product_code,	
	       manufactured_date,
	       extract(YEAR FROM manufactured_date) AS year_manufactured
      FROM products
) SELECT product_name,
	     product_code,
	     manufactured_date,
		 ROW_NUMBER() OVER (PARTITION BY year_manufactured ORDER BY manufactured_date DESC)
    FROM prepared_products
ORDER BY 3,4;
-- M7L12 - WITH
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

TRUNCATE TABLE products, product_manufactured_region;

INSERT INTO products (product_name, product_code, manufactured_region, product_quantity, manufactured_date)					    
 	 VALUES ('Product 1', 'PRD1', 'Europe', 100.25, '20/11/2019'),
 	 		('Product 1', 'PRD2', 'EMEA', 92.25, '1/11/2019'),
 	 		('Product 2', 'PRD2', 'APAC', 12.25, '1/11/2019'),
 	 		('Product 3', 'PRD3', 'APAC', 25.25, '2/11/2019'),
 	 		('Product 4', 'PRD4', 'North America', 68.25, '3/11/2019'),
 	 		('Product 5', NULL, NULL, 11.11, '12/12/2020')
;

INSERT INTO product_manufactured_region (region_name, region_code, established_year)
	  VALUES ('EMEA', 'East EMEA', 2010),
			 ('EMEA', 'West EMEA', 2010),
			 ('Africa', NULL, 2018),
	  		 ('APAC', NULL, 2019),
	  		 ('North America', NULL, 2012);
	  		 

-- WITH
	 SELECT p.product_name,
		    p.product_code, 
		    p.manufactured_region,
		    mr.established_year AS region_establed_at
       FROM products p 
  LEFT JOIN (SELECT pmr.region_name,
  					pmr.established_year
			   FROM product_manufactured_region pmr
			  WHERE pmr.established_year < 2019) mr ON mr.region_name = p.manufactured_region
;

WITH region_prior_2019 AS (
	SELECT pmr.region_name,
  		   pmr.established_year
	  FROM product_manufactured_region pmr
	 WHERE pmr.established_year < 2019
)  SELECT p.product_name,
		  p.product_code, 
		  p.manufactured_region,
		  rp.established_year AS region_establed_at
     FROM products p
LEFT JOIN region_prior_2019 rp ON rp.region_name = p.manufactured_region

-- WITH 2
WITH different_region_upsert AS (
	SELECT p.manufactured_region, 
	       EXTRACT(YEAR FROM p.manufactured_date) manufactured_year
	  FROM products p
 LEFT JOIN product_manufactured_region pmr ON pmr.region_name = p.manufactured_region
     WHERE pmr.region_name IS NULL
       AND p.manufactured_region  IS NOT NULL
) INSERT INTO product_manufactured_region (region_name, region_code, established_year)
   SELECT manufactured_region, NULL, manufactured_year
     FROM different_region_upsert;
     
SELECT * FROM product_manufactured_region;

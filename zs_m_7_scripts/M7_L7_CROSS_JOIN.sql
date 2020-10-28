-- M7L7 - CROSS
DROP TABLE IF EXISTS products, region CASCADE;

CREATE TABLE products (
	id SERIAL,
	product_name VARCHAR(100),
	product_code VARCHAR(10),
	product_quantity NUMERIC(10,2),
	manufactured_date DATE,	
	added_by TEXT DEFAULT 'admin',
	created_date TIMESTAMP DEFAULT now()
);

CREATE TABLE region (
	id SERIAL,
	region_name VARCHAR(25),
	region_code VARCHAR(10),
	established_year INTEGER
);

TRUNCATE TABLE products, region;

INSERT INTO products (product_name, product_code, product_quantity, manufactured_date)					    
 	 VALUES ('Product 1', 'PRD1', 100.25, '20/11/2019'),
 	 		('Product 1', 'PRD2', 92.25, '1/11/2019'),
 	 		('Product 2', 'PRD2', 12.25, '1/11/2019'),
 	 		('Product 3', 'PRD3', 25.25, '2/11/2019'),
 	 		('Product 4', 'PRD4', 68.25, '3/11/2019'),
 	 		('Product 5', NULL, 11.11, '12/12/2020')
;

INSERT INTO region (region_name, region_code, established_year)
	  VALUES ('EMEA', NULL, 2010),
	  		 ('APAC', NULL, 2019),
	  		 ('North America', NULL, 2012),
  	  		 ('Africa', NULL, 2020);

-- CROSS JOIN
	 SELECT p.product_name,
		    p.product_code, 		   
		    r.region_name,
		    r.established_year AS region_establed_at
       FROM products p 
 CROSS JOIN region r
;

-- CROSS JOIN 2
	 SELECT p.product_name,
		    p.product_code, 		   
		    r.region_name,
		    r.established_year AS region_establed_at
       FROM products p, region r
;

-- CROSS JOIN 3
	 SELECT p.product_name,
		    p.product_code, 		   
		    r.region_name,
		    r.established_year AS region_establed_at
       FROM products p
 INNER JOIN region r ON 1=1 
;

-- CROSS JOIN 4
EXPLAIN ANALYZE
	 SELECT p.product_name,
		    p.product_code, 		   
		    r.region_name,
		    r.established_year AS region_establed_at
       FROM products p, region r
;

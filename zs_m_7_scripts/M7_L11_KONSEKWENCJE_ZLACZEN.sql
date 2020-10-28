-- M7L11 - KONSEKWENCJE ZLACZEN
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
	  		 

-- KONSEKWENCJA 1
	 SELECT p.product_name,
		    p.product_code, 
		    p.manufactured_region,
		    mr.established_year AS region_establed_at
       FROM products p 
 LEFT OUTER JOIN product_manufactured_region mr 
 				ON mr.region_name = p.manufactured_region
;

-- KONSEKWENCJA 2
	 SELECT p.product_name,
		    p.product_code, 
		    p.manufactured_region,
		    mr.established_year AS region_establed_at
       FROM products p 
 LEFT OUTER JOIN product_manufactured_region mr 
 				ON mr.region_name = p.manufactured_region
 				OR 1=1
;

-- KONSEKWENCJA 3
	 SELECT p.product_name,
		    p.product_code, 
		    p.manufactured_region,
		    mr.established_year AS region_establed_at
       FROM products p, product_manufactured_region mr 
  	  WHERE mr.established_year > 2010				
;

-- KONSEKWENCJA 4
    SELECT p.product_name,
    	   p.product_code, 
           p2.product_name AS same_product_name_diff_code
      FROM products p
 LEFT JOIN products p2 ON p2.product_code = p.product_code
  ORDER BY p.product_name, p.product_code
;

    SELECT p.*,
    	   p2.*
      FROM products p
 LEFT JOIN products p2 ON p2.product_code = p.product_code
  ORDER BY p.product_name, p.product_code
;

-- KONSEKWENCJA 5
	 SELECT p.product_name,
		    p.product_code, 
		    p.manufactured_region,
		    mr.established_year AS region_establed_at
       FROM products p 
  LEFT JOIN product_manufactured_region mr 
 			ON mr.region_name = p.manufactured_region
 		   AND mr.established_year = 2012
;

	 SELECT p.product_name,
		    p.product_code, 
		    p.manufactured_region,
		    mr.established_year AS region_establed_at
       FROM products p 
  LEFT JOIN product_manufactured_region mr 
 			ON mr.region_name = p.manufactured_region		   
      WHERE mr.established_year = 2012
;
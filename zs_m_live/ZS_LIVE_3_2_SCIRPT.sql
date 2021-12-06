-- LIVE #2 EDYCJA 3 

---- BOOLEAN @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

CREATE TABLE test_bool (
	f_text text,
    f_bool boolean
);

INSERT INTO test_bool (f_text) VALUES ('Yes'), ('No'),('Y'),('N'),('1'),('0'),('True'),('False');

SELECT *,
	   CAST(f_text AS BOOLEAN)
  FROM test_bool;
  
INSERT INTO test_bool (f_text) VALUES ('YEEES');

SELECT * FROM test_bool;

INSERT INTO test_bool (f_bool) VALUES ('Yes');

---- INSERT @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

DROP TABLE IF EXISTS sales;

CREATE TABLE sales (
	id SERIAL,
	sal_description TEXT,
	sal_date DATE,
	sal_value NUMERIC(10,2),
	added_by TEXT DEFAULT 'admin',
	created_date TIMESTAMP DEFAULT now()
);

EXPLAIN ANALYZE
INSERT INTO sales (sal_description, sal_date, sal_value)
     SELECT left(md5(i::text), 10),
	        NOW() + (random() * (interval '90 days')) + '30 days',
        	random() * 10 + 1        
       FROM generate_series(1, 20000) s(i);

SELECT COUNT(*) FROM sales;      
      
TRUNCATE TABLE sales RESTART IDENTITY;

-- Option 1 Execute Script Separate Inserts
-- Option 2 Execute Script Combined Inserts
-- Option 3 COPY
-- COPY public.sales TO 'D:\PostgreSQL_dump\M5_L13_SALES20K_COPY.copy';
-- COPY public.sales FROM 'D:\PostgreSQL_dump\M5_L13_SALES20K_COPY.copy';

---- UPDATE / DELETE @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

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
	  VALUES ('EMEA', NULL, 2010),
	  		 ('APAC', NULL, 2019),
	  		 ('North America', NULL, 2012),
  	  		 ('Africa', NULL, 2020);

-- UPDATE
   UPDATE products p 
      SET manufactured_region = '<unknown>'
     FROM products po 
LEFT JOIN product_manufactured_region pmr ON pmr.region_name = po.manufactured_region
    WHERE p.id = po.id AND pmr.region_name IS NULL
RETURNING *;

SELECT * FROM products;

	UPDATE products p 
  	   SET manufactured_region = '<unknown>'
  	  WHERE EXISTS (SELECT 1
   	  				  FROM products po 
				 LEFT JOIN product_manufactured_region pmr ON pmr.region_name = po.manufactured_region
				     WHERE p.id = po.id AND pmr.region_name IS NULL)
  RETURNING *;
				     
-- DELETE 
  DELETE FROM product_manufactured_region pmr
   USING products p 
 RIGHT JOIN product_manufactured_region pmr2 ON pmr2.region_name = p.manufactured_region
  WHERE p.manufactured_region IS NULL
    AND pmr.id = pmr2.id
   RETURNING *;
   
  DELETE FROM product_manufactured_region pmr
        WHERE EXISTS (SELECT 1
   	  				  FROM products p 
 			    RIGHT JOIN product_manufactured_region pmr2 ON pmr2.region_name = p.manufactured_region
				     WHERE pmr2.id = pmr.id 
				       AND p.manufactured_region IS NULL)
    RETURNING *;

-- FLYWAY @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 
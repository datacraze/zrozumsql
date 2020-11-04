DROP TABLE IF EXISTS products, sales;

CREATE TABLE products (
	id SERIAL,
	product_name VARCHAR(100),
	product_code VARCHAR(10),
	product_quantity NUMERIC(10,2),
	manufactured_date DATE,	
	added_by TEXT DEFAULT 'admin',
	created_date TIMESTAMP DEFAULT now()
);

CREATE TABLE sales (
	id SERIAL,
	sal_description TEXT,
	sal_date DATE,
	sal_value NUMERIC(10,2),
	sal_discount NUMERIC (10,2),
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

INSERT INTO sales (sal_description, sal_date, sal_value, sal_discount)
  	 VALUES ('201901_sale', '12/12/2019', 1000, 90),
  	  	    ('201902_sale', '24/06/2019', 10000, 190),
      	    ('201801_sale', '05/04/2018', 5630, 102),
      	    ('202001_sale', '07/04/2020', 7230, 0);
      	    
--  COUNT
	SELECT count(*) FROM products;
	 
    SELECT COUNT(product_name) FROM products;
   
    SELECT COUNT(product_name, product_code) FROM products;
   
    SELECT COUNT(product_name||'-'||product_code) FROM products;
   
    SELECT DISTINCT COUNT(product_name) FROM products;
   
    SELECT COUNT(DISTINCT *) FROM products;
   
    SELECT COUNT(*) FROM (SELECT DISTINCT * FROM products) p;
   
    SELECT COUNT(DISTINCT product_name) FROM products;
    
    SELECT COUNT(DISTINCT product_name||'-'||product_code) FROM products;
    
-- SUM 
 SELECT sum(product_quantity)
   FROM products;
  
 SELECT sum(product_quantity)
   FROM products
  WHERE EXTRACT(YEAR FROM manufactured_date) < 2019;
 
 SELECT COALESCE(sum(product_quantity),0)
   FROM products
  WHERE EXTRACT(YEAR FROM manufactured_date) < 2019; 
  
 SELECT sum(DISTINCT product_quantity)
   FROM products;
  
 SELECT sum(COALESCE(product_quantity,1000))
   FROM products;  
   
 SELECT product_name, product_code
   FROM products
  WHERE sum(product_quantity) > 50;  

  SELECT product_name, product_code
    FROM products
GROUP BY product_name, product_code
  HAVING sum(product_quantity) > 50; 
  
-- AVG

DROP TABLE IF EXISTS old_sales;

CREATE TABLE old_sales (
	id SERIAL,
	sal_description TEXT,
	sal_date DATE,
	sal_value NUMERIC(10,2),
	sal_discount NUMERIC (10,2),
	added_by TEXT DEFAULT 'admin',
	created_date TIMESTAMP DEFAULT now()
); 

SELECT avg(sal_value) FROM old_sales;

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

   SELECT pmr.region_name, 
	      avg(p.product_quantity)
     FROM products p 
     JOIN product_manufactured_region pmr ON pmr.region_name = p.manufactured_region
 GROUP BY pmr.region_name

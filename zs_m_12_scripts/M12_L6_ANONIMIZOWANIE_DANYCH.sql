-- ANONIMIZOWANIE DANYCH

DROP TABLE IF EXISTS products, sales, product_manufactured_region CASCADE;

CREATE TABLE products (
	id SERIAL,
	product_name VARCHAR(100),
	product_code VARCHAR(10),
	product_quantity NUMERIC(10,2),	
	manufactured_date DATE,
	product_man_region INTEGER,
	added_by TEXT DEFAULT 'admin',
	created_date TIMESTAMP DEFAULT now()
);

CREATE TABLE sales (
	id SERIAL,
	sal_description TEXT,
	sal_date DATE,
	sal_value NUMERIC(10,2),
	sal_prd_id INTEGER,
	added_by TEXT DEFAULT 'admin',
	created_date TIMESTAMP DEFAULT now()
);

CREATE TABLE product_manufactured_region (
	id SERIAL,
	region_name VARCHAR(25),
	region_code VARCHAR(10),
	established_year INTEGER
);

INSERT INTO product_manufactured_region (region_name, region_code, established_year)
	  VALUES ('EMEA', 'E_EMEA', 2010),
	  		 ('EMEA', 'W_EMEA', 2012),
	  		 ('APAC', NULL, 2019),
	  		 ('North America', NULL, 2012),
	  		 ('Africa', NULL, 2012);

INSERT INTO products (product_name, product_code, product_quantity, manufactured_date, product_man_region)
     SELECT 'Product '||floor(random() * 10 + 1)::int,
            'PRD'||floor(random() * 10 + 1)::int,
            random() * 10 + 1,
            CAST((NOW() - (random() * (interval '90 days')))::timestamp AS date),
            CEIL(random()*(10-5))::int
       FROM generate_series(1, 10) s(i);  
      
INSERT INTO sales (sal_description, sal_date, sal_value, sal_prd_id)
     SELECT left(md5(i::text), 15),
     		CAST((NOW() - (random() * (interval '60 days'))) AS DATE),	
     		random() * 100 + 1,
        	floor(random() * 10)+1::int            
       FROM generate_series(1, 10000) s(i); 
      
-- Próbkowanie
SELECT *
  FROM sales
  TABLESAMPLE BERNOULLI(20);
  
-- Stała wartość
SELECT 'DESCRIPTION' AS sal_description,
	   sal_date,
	   sal_value,
	   sal_prd_id,
	   added_by,
	   created_date
  FROM sales;
 
 
--UPDATE sales SET sal_description = 'DESCRIPTION' ;

-- LOSOWA WARTOSC  
SELECT 'TEST';
SELECT md5('TEST');
SELECT random();
SELECT random()*10;
SELECT floor(random()*10)+1;
SELECT now();
SELECT now() + random();
SELECT now() + (random() * (interval '60 days'));
SELECT CAST(now() + (random() * (interval '60 days')) AS DATE);
  

-- ZAMIESZANIE OBECNEJ WARTOSCI
SELECT * FROM products;

SELECT *, concat(part3,part2,part1)
  FROM (		
		SELECT substring(product_name,
						 1,
						 CASE 
						 	WHEN 3 > length(product_name) THEN length(product_name)
						    ELSE 3
						  END) AS part1,
			   RIGHT(product_name, 2) AS part2,	
			   substring(product_name,
						 CASE 
						 	WHEN 3 < length(product_name) THEN 3
						    ELSE length(product_name) - 2
						  END,
						 length(product_name)- 4
						 ) AS part3,
			   product_name
		  FROM products
) sq;

-- SZYFROWANIE

CREATE EXTENSION pgcrypto;

SELECT crypt('name', gen_salt('md5'));


-- MOCK

CREATE TABLE mock AS 
	SELECT *  
	  FROM (
			VALUES (1, 'Krzysztof Bury'),
	       		   (2, 'Onufry Zagłoba'),
	       		   (3, 'Jan Skrzetuski')) AS t (id, name);
	       		   
SELECT * FROM mock;	  

SELECT *,
	   (SELECT name FROM mock TABLESAMPLE BERNOULLI (random()*33) LIMIT 1) AS added_by_mock
  FROM products ;
  
-- CZESCIOWE UKRYCIE
 
SELECT *,
	   CONCAT(SUBSTRING(sal_description,1,3), ' ...')	  
  FROM sales;
  
SELECT product_name,
	   CONCAT(SUBSTRING(product_name,1,length(product_name)-1),'X') AS product_name_anon
  FROM products;
-- AUTOINCREMENT
DROP TABLE IF EXISTS products;
CREATE TABLE products (
	id SERIAL,
	product_name VARCHAR(100),
	product_code VARCHAR(10),
	product_quantity NUMERIC(10,2),	
	manufactured_date DATE,
	added_by TEXT DEFAULT 'admin',
	created_date TIMESTAMP DEFAULT now()
);
INSERT INTO products (product_name, product_code, product_quantity, manufactured_date)
     SELECT 'Product '||floor(random() * 10 + 1)::int,
            'PRD'||floor(random() * 10 + 1)::int,
            random() * 10 + 1,
            CAST((NOW() - (random() * (interval '90 days')))::timestamp AS date)
       FROM generate_series(1, 10) s(i);  

SELECT * FROM products;      

SELECT last_value FROM public.products_id_seq;

INSERT INTO products (id, product_name, product_code, product_quantity, manufactured_date)
     VALUES (11, 'Product 11', 'PRD11', random() * 10 + 1, CAST((NOW() - (random() * (interval '90 days')))::timestamp AS date)),
     		(12, 'Product 12', 'PRD12', random() * 10 + 1, CAST((NOW() - (random() * (interval '90 days')))::timestamp AS date)),
     		(13, 'Product 13', 'PRD13', random() * 10 + 1, CAST((NOW() - (random() * (interval '90 days')))::timestamp AS date));
     
SELECT * FROM products;
SELECT last_value FROM public.products_id_seq;

INSERT INTO products (product_name, product_code, product_quantity, manufactured_date)
     VALUES ('Product '||floor(random() * 10 + 1)::int, 'PRD'||floor(random() * 10 + 1)::int, random() * 10 + 1, CAST((NOW() - (random() * (interval '90 days')))::timestamp AS date));
 
SELECT * FROM products;
SELECT last_value FROM public.products_id_seq;

DELETE FROM products WHERE id = 11;
ALTER TABLE products ADD CONSTRAINT pk_products_id PRIMARY KEY (id);

SELECT * FROM products;
SELECT last_value FROM public.products_id_seq;

INSERT INTO products (product_name, product_code, product_quantity, manufactured_date)
     VALUES ('Product '||floor(random() * 10 + 1)::int, 'PRD'||floor(random() * 10 + 1)::int, random() * 10 + 1, CAST((NOW() - (random() * (interval '90 days')))::timestamp AS date));

    
-- GROUP BY / ORDER BY
SELECT product_code AS prdtr, min(product_quantity)
  FROM products
  GROUP BY prdtr
  
SELECT product_code, min(product_quantity)
  FROM products
  GROUP BY 1

SELECT product_name,  min(product_quantity)
  FROM products
  GROUP BY 1

SELECT extract(YEAR FROM manufactured_date)||'_'||
		extract(MONTH FROM manufactured_date),
	   count(*)
  FROM products 	   
GROUP BY 1;  

SELECT extract(YEAR FROM manufactured_date)||'_'||
		extract(MONTH FROM manufactured_date) AS year_month,
	   count(*)
  FROM products 	   
GROUP BY year_month;  

SELECT extract(YEAR FROM manufactured_date)||'_'||
		extract(MONTH FROM manufactured_date),
	   count(*)
  FROM products 	   
GROUP BY extract(YEAR FROM manufactured_date)||'_'||
		extract(MONTH FROM manufactured_date); 

SELECT year_month, count(*) 
    FROM (SELECT extract(YEAR FROM manufactured_date)||'_'||
		   	extract(MONTH FROM manufactured_date) AS year_month,
		   *
 	  FROM products ) sq
 GROUP BY year_month;  

SELECT extract(YEAR FROM manufactured_date)||'_'||
		extract(MONTH FROM manufactured_date),
	   count(*)
  FROM products 	   
GROUP BY extract(YEAR FROM manufactured_date)||'_'||
		extract(MONTH FROM manufactured_date); 		

-- NULLS
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

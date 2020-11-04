-- M8 L12 - Data Science?
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
	  		 ('North America', NULL, 2012),
  	  		 ('Africa', NULL, 2020);
  	  		 
-- ZEBRANIE + PRZECHOWANIE - DONE
-- CZYSZCZENIE

SELECT * FROM products;

-- ILE REKORDOW
SELECT COUNT(*) FROM products;

-- Unikatowych kodow produktow

SELECT COUNT(DISTINCT product_code) FROM products;

-- Atrybuty z możliwym NULL: product_code, product_quantity, manufactured_region

-- Jak zaadresuje? 
-- PRODUCT_CODE: '<unknown>'
-- PRODUCT_QUANTITY: 0
-- MANUFACTURED_REGION: '<unknown>'

SELECT product_name,
	   COALESCE(product_code,'<unknown>') product_code,
	   COALESCE(product_quantity,0) product_quantity,
	   manufactured_date,
	   EXTRACT(YEAR FROM manufactured_date) AS year_manufactured,
	   EXTRACT(YEAR FROM manufactured_date)||'_'||EXTRACT(MONTH FROM manufactured_date)  AS year_month_manufactured,
	   'Q'||EXTRACT(quarter FROM manufactured_date)||EXTRACT(YEAR FROM manufactured_date) AS year_qtr_manufactured,
	   COALESCE(manufactured_region, '<unknown>') manufactured_region,
	   id AS unq_identifier
  FROM products p;

SELECT * FROM product_manufactured_region;

-- Atrybuty z możliwym NULL: region_name, region_code

-- Jak zaadresuje? 
-- REGION_NAME: '<unknown>'
-- REGION_CODE: usunę z przetwarzania

SELECT COALESCE(region_name,'<unknown>') AS region_name,
	   established_year
  FROM product_manufactured_region;
  
-- POLACZENIE MIEDZY TABELI  
      SELECT *, 
      		 TRUNC(cnt_of_elements_diff/elpmr.cnt::NUMERIC,2) AS degree_of_not_matching_elements
        FROM (
      SELECT count(*) AS cnt_of_elements_diff,
      		 'product_manufactured_region'
        FROM products p 
   FULL JOIN product_manufactured_region pmr ON pmr.region_name = p.manufactured_region         
       WHERE p.id IS NULL
       ) sq 
       JOIN (SELECT COUNT(*) AS cnt FROM product_manufactured_region) elpmr ON 1=1
       UNION 
      SELECT *, 
      		 TRUNC(cnt_of_elements_diff/elpmr.cnt::NUMERIC,2)
        FROM (
      SELECT count(*) AS cnt_of_elements_diff,
      		 'products'
        FROM products p 
   FULL JOIN product_manufactured_region pmr ON pmr.region_name = p.manufactured_region         
       WHERE pmr.id IS NULL
       ) sq 
       JOIN (SELECT COUNT(*) AS cnt FROM products) elpmr ON 1=1     
      
-- ANALIZA       
WITH prep_products AS (
	SELECT product_name,
		   COALESCE(product_code,'<unknown>') product_code,
		   COALESCE(product_quantity,0) product_quantity,
		   manufactured_date,
		   EXTRACT(YEAR FROM manufactured_date) AS year_manufactured,
		   EXTRACT(YEAR FROM manufactured_date)||'_'||EXTRACT(MONTH FROM manufactured_date)  AS year_month_manufactured,
		   'Q'||EXTRACT(quarter FROM manufactured_date)||EXTRACT(YEAR FROM manufactured_date) AS year_qtr_manufactured,
		   COALESCE(manufactured_region, '<unknown>') manufactured_region,
		   id AS unq_identifier
	  FROM products p
), prep_prd_man_region AS (
	SELECT COALESCE(region_name,'<unknown>') AS region_name,
		   established_year
	  FROM product_manufactured_region
)       SELECT avg(product_quantity) OVER (PARTITION BY p.year_manufactured) AS avg_qty_per_year,
			   avg(product_quantity) OVER (PARTITION BY p.year_manufactured, prm.region_name) AS avg_qty_per_year_region_name,
			   avg(product_quantity) OVER () AS global_avg_qty,
			   stddev(product_quantity) OVER (), 
			   p.*,
	           prm.*
	      FROM prep_products p 
	 LEFT JOIN prep_prd_man_region prm ON prm.region_name = p.manufactured_region
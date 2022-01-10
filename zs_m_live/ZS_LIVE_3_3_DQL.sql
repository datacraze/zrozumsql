---- FOREIGN KEY
DROP TABLE IF EXISTS products, sales, product_manufactured_region CASCADE;

CREATE TABLE products (
	id SERIAL PRIMARY KEY,
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
	established_year INTEGER,
	product_id INTEGER
);

ALTER TABLE product_manufactured_region 
ADD CONSTRAINT fk_product_id 
FOREIGN KEY (product_id) 
REFERENCES products (id);

-- ALTER TABLE product_manufactured_region 
-- ADD CONSTRAINT fk_product_id 
-- FOREIGN KEY (product_id) 
-- REFERENCES sales (sal_prd_id);


ALTER TABLE sales 
ADD CONSTRAINT fk_product_id 
FOREIGN KEY (sal_prd_id) 
REFERENCES products (id);

--ALTER TABLE product_manufactured_region 
--ADD FOREIGN KEY (product_id) 
--REFERENCES products (id);
--
--ALTER TABLE sales 
--ADD FOREIGN KEY (sal_prd_id) 
--REFERENCES products (id);

SELECT DISTINCT
    tc.table_schema, 
    tc.constraint_name, 
    tc.table_name, 
    kcu.column_name, 
    ccu.table_schema AS foreign_table_schema,
    ccu.table_name AS foreign_table_name,
    ccu.column_name AS foreign_column_name 
FROM 
    information_schema.table_constraints AS tc 
    JOIN information_schema.key_column_usage AS kcu
      ON tc.constraint_name = kcu.constraint_name
      AND tc.table_schema = kcu.table_schema
    JOIN information_schema.constraint_column_usage AS ccu
      ON ccu.constraint_name = tc.constraint_name
      AND ccu.table_schema = tc.table_schema
WHERE tc.constraint_type = 'FOREIGN KEY' 
   AND tc.table_schema='public';

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

------------------------------------------------------------

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

-- OVER vs GROUP BY
      
-- 1: Przygotuj widok bazodanowy na podstawie danych sprzedażowych SALES,
--  który będzie przedstawiał dane za ostatni kwartał roku 2020, 
--  dla wszystkich produktów biorących udział w transakcjach sprzedażowych 
--  wytworzonych w regionie EMEA.      

-- 2: Zmień zapytanie z zadania pierwszego w taki sposób aby w wynikach dodatkowo, 
-- obliczyć sumę sprzedaży w podziale na kod produktu (product_code) 
-- sortowane według daty sprzedaży (sal_date), 
-- wynik wyświetl dla każdego wiersza (OVER). 

      -- dups
select p.product_code,
       p.product_name,
       pmr.region_name,
       s.sal_date,
       s.sal_value
       --sum(s.sal_value) over (partition by p.product_name)
  from products p 
  inner join product_manufactured_region pmr on p.product_man_region = pmr.id 
  inner join sales s on s.sal_prd_id=p.id
          --and (extract(year from s.sal_date)=2020 and extract (quarter from s.sal_date)=4)          
  order by s.sal_date , p.product_name;
      
 -- group by 
 
 select p.product_code,
       p.product_name,
       pmr.region_name,
       s.sal_date,
       sum(s.sal_value)
       --sum(s.sal_value) over (partition by p.product_name)
   from products p 
   inner join product_manufactured_region pmr on p.product_man_region = pmr.id 
   inner join sales s on s.sal_prd_id=p.id
          --and (extract(year from s.sal_date)=2020 and extract (quarter from s.sal_date)=4)
GROUP BY p.product_code,
         p.product_name,
         pmr.region_name,
         s.sal_date                              
   order by s.sal_date , p.product_name
   
   
   -- over
   
select p.product_code,
       p.product_name,
       pmr.region_name,
       s.sal_date,
       sum(s.sal_value) over (partition by p.product_name)
  from products p 
  inner join product_manufactured_region pmr on p.product_man_region = pmr.id 
  inner join sales s on s.sal_prd_id=p.id
          --and (extract(year from s.sal_date)=2020 and extract (quarter from s.sal_date)=4)                             
  order by s.sal_date , p.product_name
   
  -- part of over
  select p.product_name,      
         sum(s.sal_value)
   from products p 
   inner join product_manufactured_region pmr on p.product_man_region = pmr.id 
   inner join sales s on s.sal_prd_id=p.id
          --and (extract(year from s.sal_date)=2020 and extract (quarter from s.sal_date)=4) 
GROUP BY p.product_name;
  
--final 
SELECT DISTINCT 
       p.product_code,
       p.product_name,
       pmr.region_name,
       s.sal_date,
       sum(s.sal_value) OVER (PARTITION BY p.product_name) AS sales_values_for_product_name_groups
  FROM products p 
  JOIN product_manufactured_region pmr ON p.product_man_region = pmr.id 
  JOIN sales s ON s.sal_prd_id=p.id
  			  AND EXTRACT(year from s.sal_date)=2020 
  			  and EXTRACT(quarter from s.sal_date)=4
  ORDER BY s.sal_date , p.product_name
  
  -- ROLLING SUM
  
  SELECT p.product_code,
       p.product_name,
       pmr.region_name,
       s.sal_date,
       sum(s.sal_value) OVER (PARTITION BY p.product_name) AS sales_values_for_product_name_groups
  FROM products p 
  JOIN product_manufactured_region pmr ON p.product_man_region = pmr.id 
  JOIN sales s ON s.sal_prd_id=p.id
WHERE product_code = 'PRD5'  
  AND product_name = 'Product 1'
  AND region_name = 'EMEA'
  AND s.sal_date = '2020-09-28'
  ORDER BY s.sal_date , p.product_name
  
  
SELECT DISTINCT 
       p.product_code,
       p.product_name,
       pmr.region_name,
       s.sal_date,
       sum(s.sal_value) OVER (PARTITION BY p.product_name ORDER BY s.sal_date) AS sales_values_for_product_name_groups
  FROM products p 
  JOIN product_manufactured_region pmr ON p.product_man_region = pmr.id 
  JOIN sales s ON s.sal_prd_id=p.id
WHERE product_code = 'PRD5'  
  AND product_name = 'Product 1'
  AND region_name = 'EMEA'
  ORDER BY s.sal_date , p.product_name  
  
-- CTAS 

DROP TABLE IF EXISTS sales_archive;

      
CREATE TABLE sales_archive AS 
	SELECT CAST(NULL AS INTEGER) AS id,
	       CAST(NULL AS TEXT) AS sal_description,
	       CAST(NULL AS DATE) AS sal_date,
	       CAST(NULL AS NUMERIC(10,2)) AS sal_value,
	       CAST(NULL AS INTEGER) AS sal_prd_id,
		   CAST(NULL AS VARCHAR(1)) AS sal_operation_type,
	       CAST(NULL AS TEXT) AS added_by,
	       CAST(NULL AS TIMESTAMP) AS archived_at;

CREATE TABLE sales_archive (id, sal_description, s_date) AS 
	SELECT CAST(NULL AS INTEGER) AS id,
	       CAST(NULL AS TEXT) AS sal_description,
	       CAST(NULL AS DATE) AS sal_date,
	       CAST(NULL AS NUMERIC(10,2)) AS sal_value,
	       CAST(NULL AS INTEGER) AS sal_prd_id,
		   CAST(NULL AS VARCHAR(1)) AS sal_operation_type,
	       CAST(NULL AS TEXT) AS added_by,
	       CAST(NULL AS TIMESTAMP) AS archived_at;

---------------------------------------

DROP TABLE offer;

CREATE TABLE offer (
	id SERIAL,
	offer_code TEXT,
	offer_name TEXT
);

INSERT INTO offer (offer_code, offer_name)
	 VALUES ('TV Package 3', 'Package of 3 channels'),
	 		('TV Package 5', 'Package of 5 channels'),
	 		('TV Package Info', 'Package of only info channels.'),
	 		(' TV Full', 'All Packages.');
	 	
DROP TABLE article;	 	

CREATE TABLE article (
	id SERIAL,
	article_name TEXT,
	offer_id INTEGER
);

-- ARTICLE OCZYWISCIE POWINNO BY ROZDZIELONE OSOBNO NA ARTICLE i ARTICLE_OFFER

INSERT INTO article (article_name, offer_id)
	 VALUES ('TVP', 1),
	 		('TVP2', 1),
	 		('TVP Sport', 1),
	 		('TVP', 2),
	 		('TVP2', 2),
	 		('TVP Sport', 2),
	 		('Polsat Sport', 2),
	 		('TVN',2),
	 		('TVP', 3),
	 		('TVP2', 3),
	 		('TVN',3),	
	 		('TVP', 4),
	 		('TVP2', 4),
	 		('TVP Sport', 4),
	 		('Polsat Sport', 4),
	 		('TVN',4);

DROP TABLE client;	 

CREATE TABLE client (
	id SERIAL,
	name TEXT,
	offer_selected INTEGER[]
);

INSERT INTO client (name, offer_selected)
	 VALUES ('Krzysiek B.', '{4}'),
	 		('Zagloba', '{2,3}'),
	 		('Jan', '{1}');

SELECT cu.name, o.*, article_name
  FROM (SELECT c.name, 
	           unnest(c.offer_selected) AS offer_id
	      FROM client c) cu
  JOIN offer o ON o.id = cu.offer_id
  JOIN article a ON a.offer_id = o.id
-- W WHERE PARAMETRY TAK JAK DO FUNKCJI
WHERE cu.name = 'Zagloba'
  AND o.id = 2
	 	
-- TAB A - oferty (id, kod, nazwa)
-- TAB Z - artykuly dla ofery (id_artykulu, 
							-- id_oferty)

-- TAB B - sprawdzane sa oferty np. klienci 
-- Klient ma dana oferte i wszystkie artykuly

-- numer klienta
-- kod oferty

-- wynik lista kodow artykulow
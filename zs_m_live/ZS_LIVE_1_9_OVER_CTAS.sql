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
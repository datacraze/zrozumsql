-- PROCEDURY

M9 -> L7 
DROP TABLE IF EXISTS products CASCADE;

CREATE TABLE products (
	product_name VARCHAR(100),
	product_code VARCHAR(10),
	product_quantity NUMERIC(10,2),
	manufactured_date DATE
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

-- PROCEDURA

	CREATE PROCEDURE remove_all_unset_product_names()
	LANGUAGE sql
	AS $$
		BEGIN
			DELETE FROM products WHERE product_name IS NULL;			
		END
	$$;
	
	CREATE PROCEDURE remove_all_unset_product_names()
	LANGUAGE sql
	AS $$
		DELETE FROM products WHERE product_name IS NULL;			
	$$;

	SELECT * FROM products;
	CALL remove_all_unset_product_names();
	
-- FUNKCJA

CREATE FUNCTION count_of_products_for_year(y integer)  
	RETURNS integer
	LANGUAGE sql
	AS $$	
		DECLARE count_p integer;
		BEGIN
			SELECT count(*) INTO count_p
			  FROM products 
			 WHERE EXTRACT(YEAR FROM manufactured_date) = y;

			RETURN count_p;
		END
	$$;
	
CREATE FUNCTION count_of_products_for_year(y integer)  
	RETURNS integer
	LANGUAGE plpgsql
	AS $$	
		DECLARE count_p integer;
		BEGIN
			SELECT count(*) INTO count_p
			  FROM products 
			 WHERE EXTRACT(YEAR FROM manufactured_date) = y;

			RETURN count_p;
		END
	$$;
	
SELECT *,
	   count_of_products_for_year(2019)
  FROM products;

-- QUALIFY (WINDOW FUNCTION)

    https://modern-sql.com/caniuse/qualify
    -- SNOWFLAKE 
    https://docs.snowflake.com/en/sql-reference/constructs/qualify.html

    select *
         , count(*) over (partition by o_clerk) count_of_order_serviced_by_clerk
      from orders 
   qualify count_of_order_serviced_by_clerk > 1440
     limit 500;

    M8 zadania teoria 7

       SELECT p.product_name,
    	   p.product_code,
    	   p.manufactured_date,
    	   p.product_man_region,
    	   pmr.region_name,
    	   sum(p.product_quantity) OVER (PARTITION BY pmr.region_name)
      FROM products p
 LEFT JOIN product_manufactured_region pmr ON pmr.id = p.product_man_region; 

-- 7: Na podstawie zapytania i wyników z zadania 6. Stwórz ranking według posiadanej ilości produktów od największej do najmniejszej, w taki sposób aby w rankingu nie było brakujących elementów (liczb). W wyniku wyświetl te produkty, których ilość jest 2 największą ilością. Atrybuty do wyświetlenia, PRODUCT_NAME, REGION_NAME, suma ilości per region (obliczona w zadaniu 6).
WITH prd_qty_per_region AS (
		SELECT p.product_name,
	    	   p.product_code,
	    	   p.manufactured_date,
	    	   p.product_man_region,
	    	   pmr.region_name,
	    	   sum(p.product_quantity) OVER (PARTITION BY pmr.region_name) AS sum_qty_per_region
	      FROM products p
	 LEFT JOIN product_manufactured_region pmr ON pmr.id = p.product_man_region
), product_qty_ranking AS (
  SELECT product_name,
		 region_name,
		 sum_qty_per_region,
		 DENSE_RANK() OVER (ORDER BY sum_qty_per_region DESC) prd_rank
    FROM prd_qty_per_region
) SELECT product_name,
		 region_name,
		 sum_qty_per_region
    FROM product_qty_ranking
   WHERE prd_rank = 2;
  


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


select sum(product_quantity)
     , pmr.region_name
  from products p
inner join product_manufactured_region pmr on pmr.id = p.product_man_region
group by pmr.region_name;

select sum(product_quantity)
     , case when pmr.region_name = 'EMEA' or  pmr.region_name = 'Africa' then 'REGION1' else 'REGION2' end
  from products p
inner join product_manufactured_region pmr on pmr.id = p.product_man_region
group by pmr.region_name;

select sum(product_quantity)
     , case when pmr.region_name = 'EMEA' or  pmr.region_name = 'Africa' then 'REGION1' else 'REGION2' end
  from products p
inner join product_manufactured_region pmr on pmr.id = p.product_man_region
group by case when pmr.region_name = 'EMEA' or  pmr.region_name = 'Africa' then 'REGION1' else 'REGION2' end;

---------------------------------------------

------------
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
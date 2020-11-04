


-- GETTING ROWS 
SELECT 'SELECT ' || STRING_AGG('s.' || column_name, ', ') || ' FROM sales AS s;'
  FROM information_schema.columns
 WHERE table_name = 'sales'
   AND table_schema = 'public'
   AND column_name NOT IN ('sales_qty');

-- JDBC

COPY expense_tracker.bank_account_owner (id_ba_own, owner_name, owner_desc, user_login, active, insert_date, update_date) FROM stdin;
1	Janusz Kowalski	Pan Janusz - Głowa Rodziny	1	1	2020-10-29 19:02:16.665897	2020-10-29 19:02:16.665897
2	Grażyna Kowalska	Pani Grażyna - Szyja Rodziny	2	1	2020-10-29 19:02:16.665897	2020-10-29 19:02:16.665897
3	Janusz i Grażynka	Pan Janusz i Grażynka właściciele.	2	1	2020-10-29 19:02:16.665897	2020-10-29 19:02:16.665897
;

SELECT * FROM expense_tracker.bank_account_owner;

-- GROUP BY 

SELECT product_code AS prdtr, min(product_quantity)
  FROM products
  GROUP BY prdtr
  
SELECT product_code, min(product_quantity)
  FROM products
  GROUP BY 1

SELECT product_name,  min(product_quantity)
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
	
-------------

EXPLAIN ANALYZE
     SELECT p.product_name,
		    p.product_code, 
		    p.manufactured_region,
		    mr.established_year AS region_establed_at
       FROM products p 
 INNER JOIN product_manufactured_region mr ON mr.region_name = p.manufactured_region
 	  WHERE mr.established_year = 2019
;

DISCARD ALL;

CREATE TABLE test1 (
	id SERIAL,
	test_column TEXT
);	

CREATE TABLE test2 (
	id SERIAL,
	test_column TEXT
);	


SELECT t1.id,
       t1.test_column AS t1_test_column,
       t2.test_column AS t2_test_column
  FROM test1 t1
  JOIN test2 t2 ON t2.id = t1.id;
 
 
     SELECT p.*, 
            mr.region_name
       FROM products p 
 INNER JOIN product_manufactured_region mr ON mr.region_name = p.manufactured_region
 	  									  AND  mr.established_year = 2019
;

 

     SELECT p.product_name,
		    p.product_code, 
		    p.manufactured_region,
		    mr.established_year AS region_establed_at
       FROM products p 
 INNER JOIN (SELECT * FROM product_manufactured_region mr) mr ON mr.region_name = p.manufactured_region
     WHERE mr.established_year = 2019;
    
    
    
    
     SELECT p.product_name,
		    p.product_code, 
		    p.manufactured_region,
		    mr.established_year AS region_establed_at
       FROM products p 
 INNER JOIN (SELECT * FROM product_manufactured_region mr WHERE mr.established_year = 2019) 
 		mr ON mr.region_name = p.manufactured_region

--L12: Daj Mi Wszystko Czyli * Tu * Tam

/* 
Antywzorzec: Wykorzystywanie * lub innych "skrótów" w zapytaniach
Powody:
	* "oszczędność" czasu
	* można więc dlaczego nie
	* lenistwo
Poznasz go po:
	* SELECT *
	* ORDER BY 1
	* GROUP BY 1  
Na Twoje usprawiedliwienie:
	* Jak się uczysz 
	* Jak budujesz coś do sprawdzenia (NIE PRODUKCYJNIE!)
	* Jak zakres z * i bez gwiazdki nie ma znaczenia
	* Jak dodatkowe kolumny w * są pomijalne (rozmiar)
*/ 

DROP TABLE IF EXISTS products;

CREATE TABLE products (
	id SERIAL,
	product_name VARCHAR(100),
	product_code VARCHAR(10),
	product_quantity NUMERIC(10,2),	
	product_description TEXT,
	manufactured_date DATE,
	added_by TEXT DEFAULT 'admin',
	created_date TIMESTAMP DEFAULT now()
);

INSERT INTO products (product_name, product_code, product_quantity, product_description, manufactured_date)
     SELECT 'Product '||floor(random() * 10000 + 1)::int,
            'PRD'||floor(random() * 1000 + 1)::int,
            random() * 10 + 1,
	        md5('PRD'||floor(random() * 1000 + 1)::int),
            CAST((NOW() - (random() * (interval '90 days')))::timestamp AS date)
       FROM generate_series(1, 1000000) s(i);  

SELECT * FROM products; 

SELECT relname as "Table",
       pg_size_pretty(pg_total_relation_size(relid)) As "Size",
       pg_size_pretty(pg_total_relation_size(relid) - pg_relation_size(relid)) as "External Size"
  FROM pg_catalog.pg_statio_user_tables 
 WHERE relname = 'products'
 ORDER BY pg_total_relation_size(relid) DESC;

DROP TABLE IF EXISTS products_limited;
CREATE TABLE products_limited AS 
 SELECT product_name, 
        product_code,
        product_quantity,
        manufactured_date
   FROM products;
  
SELECT relname as "Table",
       pg_size_pretty(pg_total_relation_size(relid)) As "Size",
       pg_size_pretty(pg_total_relation_size(relid) - pg_relation_size(relid)) as "External Size"
  FROM pg_catalog.pg_statio_user_tables 
 WHERE relname = 'products_limited'
 ORDER BY pg_total_relation_size(relid) DESC;  

EXPLAIN ANALYZE
SELECT p.product_name, 
       p.product_code,
       p.product_quantity,
       p.manufactured_date,
       p2.product_code
  FROM products p 
  JOIN (SELECT * FROM products_limited) p2 ON p.product_name = p2.product_name
 										  AND p.product_code = p2.product_code;

DISCARD ALL;

EXPLAIN ANALYZE
SELECT p.product_name, 
       p.product_code,
       p.product_quantity,
       p.manufactured_date,
       p2.product_code
  FROM products p 
  JOIN (SELECT product_name, 
  			   product_code 
          FROM products_limited) p2 ON p.product_name = p2.product_name
 								   AND p.product_code = p2.product_code;

SELECT product_name,
	   product_code,
	   product_quantity
  FROM products 
 ORDER BY 1;

SELECT product_quantity,	  
	   product_code,	   
  FROM products 
 ORDER BY 1;

SELECT product_code,
	   sum(product_quantity)
  FROM products 
 GROUP BY 1;
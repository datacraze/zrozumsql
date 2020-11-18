DROP TABLE IF EXISTS products CASCADE;

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
     SELECT 'Product '||floor(random() * 10000 + 1)::int,
            'PRD'||floor(random() * 10 + 1)::int,
            random() * 10 + 1,
            CAST((NOW() - (random() * (interval '90 days')))::timestamp AS date)
       FROM generate_series(1, 1000000) s(i);  

DISCARD ALL;      

/* KROK 1 */

EXPLAIN ANALYZE
SELECT * 
  FROM products;

 -- Cost - umowna jednostka (disk_page_fetches)
 -- Rows - ilość rekordów na wyjściu tego kroku
 -- Width - rozmiar wiersza w bajatch
 
 -- Planning Time
 -- Execution Time
 
 -- Seq Scan - przechodzę wiersz po wierszu
 
/* KROK 2 */
 
DISCARD ALL;
EXPLAIN ANALYZE
SELECT * 
  FROM products p
 WHERE product_code = 'PRD4';
 
 -- Seq Scan - przechodzę wiersz po wierszu
 	-- Filter - odfiltrowuję po ...
	 -- Rows Removed by Filter - ilość wierszy usuniętych

/* KROK 3 */ 

DISCARD ALL;

CREATE INDEX idx_products_product_code ON products (product_code);

EXPLAIN ANALYZE
SELECT * 
  FROM products p
 WHERE product_code = 'PRD4';
 
-- Bitmap Heap Scan -- pobierz wiersze na podstawie indeksu
	-- Bitmap Index Scan -- skanowanie po indeksie
		-- Index Cond: warunek do indeksu

/* KROK 4 */ 

DISCARD ALL;

EXPLAIN ANALYZE
SELECT * 
  FROM products p
 WHERE product_code = 'PRD4'
   AND product_name = 'Product 5';
   
-- Bitmap Heap Scan -- pobierz wiersze na podstawie indeksu
	-- Filter -- ogranicz do warunku
	 -- Rows Removed by Filter -- ilość wierszy usuniętych
	-- Bitmap Index Scan -- skanowanie po indeksie
		-- Index Cond: warunek do indeksu  
  
 -- Czy szybciej ;) ? 
  
 /* KROK 5 */
  
DISCARD ALL;

CREATE INDEX idx_products_product_name ON products (product_name);

EXPLAIN ANALYZE
SELECT * 
  FROM products p
 WHERE product_code = 'PRD4'
   AND product_name = 'Product 5';
  
-- Bitmap Heap Scan -- pobierz wiersze na podstawie indeksu
	-- Filter -- ogranicz do warunku (dlaczego nie indkes :D)? 
	 -- Rows Removed by Filter -- ilość wierszy usuniętych
	-- Bitmap Index Scan -- skanowanie po indeksie
		-- Index Cond: warunek do indeksu    
 
 /* KROK 6 */  

DISCARD ALL;

DROP TABLE sales CASCADE;
CREATE TABLE sales (
	id SERIAL PRIMARY KEY,
	sal_description TEXT,
	sal_date DATE,
	sal_value NUMERIC(10,2),
	sal_prd_id INTEGER,
	added_by TEXT DEFAULT 'admin',
	created_date TIMESTAMP DEFAULT now()
);

INSERT INTO sales (sal_description, sal_date, sal_value, sal_prd_id)
     SELECT left(md5(i::text), 15),
     		CAST((NOW() - (random() * (interval '60 days'))) AS DATE),	
     		random() * 100 + 1,
        	floor(random() * 10)+1::int            
       FROM generate_series(1, 10000) s(i);  
       
      
DISCARD ALL;

EXPLAIN ANALYZE
SELECT s.*,
	   p.*
  FROM sales s
  JOIN products p ON p.id = s.sal_prd_id;
 
-- Hash Join  -- algorytmy złączenia
  -- Hash Cond: -- warunek
	--  ->  Seq Scan on sales s  
	 -- ->  Hash 
    --	Buckets: 65536  Batches: 32  Memory Usage: 3184kB
      --  ->  Seq Scan on products p 
      
DISCARD ALL;

EXPLAIN ANALYZE
SELECT s.*,
	   p.*
  FROM sales s
  JOIN products p ON p.id = s.sal_prd_id AND p.product_code = 'PRD4'
 WHERE  s.id < 10;      
 
-- Gather - scalanie wyników 
	-- Workers Planned - ilość równoległych planów
	-- Workers Launched - ilość równoległych wykonawców
	
 /* KROK 7 */  

DISCARD ALL;

DROP TABLE sales CASCADE;

CREATE TABLE sales (
	id SERIAL PRIMARY KEY,
	sal_description TEXT,
	sal_date DATE,
	sal_value NUMERIC(10,2),
	sal_prd_id INTEGER,
	added_by TEXT DEFAULT 'admin',
	created_date TIMESTAMP DEFAULT now()
);

INSERT INTO sales (sal_description, sal_date, sal_value, sal_prd_id)
     SELECT left(md5(i::text), 15),
     		CAST((NOW() - (random() * (interval '60 days'))) AS DATE),	
     		random() * 100 + 1,
        	floor(random() * 10)+1::int            
       FROM generate_series(1, 10000) s(i);
       
DISCARD ALL;

EXPLAIN ANALYZE
SELECT s.*,
	   p.*
  FROM sales s
  JOIN products p ON p.id = s.sal_prd_id AND p.product_code = 'PRD4'
 WHERE  s.id = 100;        
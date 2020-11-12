--L9: Indeksujemy Wszystko

/* 
Antywzorzec: Indeksowanie za dużej / za małej ilości kolumn
Powody:
	* indeksy źle działają na operacje INSERT / UPDATE / DELETE
	* nie wiem jak będę odpytywać moją bazę to dam indeks wszędzie
Poznasz go po:
	* braku indeksów w Twojej bazie danych
	* nadmiarowych indeksach w bazie
Na Twoje usprawiedliwienie:
	* baza danych się zmienia / problemy się zmieniają 
	  to co kiedyś było dobrym pomysłem nie musi być takie teraz
*/ 

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
     SELECT 'Product '||floor(random() * 10000 + 1)::int,
            'PRD'||floor(random() * 1000 + 1)::int,
            random() * 10 + 1,
            CAST((NOW() - (random() * (interval '90 days')))::timestamp AS date)
       FROM generate_series(1, 1000000) s(i);  

EXPLAIN ANALYZE       
SELECT p.* 
  FROM products p 
 WHERE p.product_code = 'PRD1';

SELECT relname as "Table",
       pg_size_pretty(pg_total_relation_size(relid)) As "Size",
       pg_size_pretty(pg_total_relation_size(relid) - pg_relation_size(relid)) as "External Size"
  FROM pg_catalog.pg_statio_user_tables 
 WHERE relname = 'products'
 ORDER BY pg_total_relation_size(relid) DESC;

CREATE INDEX idx_prd_product_code ON products (product_code);

-- WHAT SIZE? 

SELECT pg_size_pretty(pg_indexes_size('products'));

EXPLAIN ANALYZE       
SELECT p.* 
  FROM products p 
 WHERE p.product_code = 'PRD1';

-- DATE
EXPLAIN ANALYZE
SELECT p.* 
  FROM products p 
 WHERE p.manufactured_date = '2020-11-01';

CREATE INDEX idx_prd_manufactured_date ON products (manufactured_date);

SELECT relname as "Table",
       pg_size_pretty(pg_total_relation_size(relid)) As "Size",
       pg_size_pretty(pg_total_relation_size(relid) - pg_relation_size(relid)) as "External Size"
  FROM pg_catalog.pg_statio_user_tables 
 WHERE relname = 'products'
 ORDER BY pg_total_relation_size(relid) DESC;


SELECT pg_size_pretty(pg_indexes_size('products'));

-- DATE
EXPLAIN ANALYZE
SELECT p.* 
  FROM products p 
 WHERE p.manufactured_date = '2020-11-01';

-- DATE
EXPLAIN ANALYZE
SELECT p.* 
  FROM products p 
 WHERE EXTRACT(MONTH FROM p.manufactured_date) = 11;

CREATE INDEX idx_prd_manufactured_month ON products (EXTRACT(MONTH FROM manufactured_date));

EXPLAIN ANALYZE
SELECT p.* 
  FROM products p 
 WHERE EXTRACT(MONTH FROM p.manufactured_date) = 11;

SELECT relname as "Table",
       pg_size_pretty(pg_total_relation_size(relid)) As "Size",
       pg_size_pretty(pg_total_relation_size(relid) - pg_relation_size(relid)) as "External Size"
  FROM pg_catalog.pg_statio_user_tables 
 WHERE relname = 'products'
 ORDER BY pg_total_relation_size(relid) DESC;

SELECT pg_size_pretty(pg_indexes_size('products'));

/*
ROZWIAZANIE: 
	* Dopasuj indeksy do Twoich pytań
	* Sprawdzaj wykorzystanie indeksów
	* Rób audyt 
 */ 
  
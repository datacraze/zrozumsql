--L11: Google Dla Biednych Czyli Wyszukiwanie Na %

/* 
Antywzorzec: Dopasowywanie wzorców po LIKE / REGEXP
Powody:
	* chcemy wyszukiwać różnych fragmentów w tekście żeby dopasowywać
	* nigdy nie wiemy co nasz klient wpisze w pasku SZUKAJ
Poznasz go po:
	* LIKE %%
	* używaniu wyrażeń regularnych za pomocą REGEXP_MATCH 
Na Twoje usprawiedliwienie:
	* LIKE odpowiednio użyty jest ok
	* do "jednorazowych" akcji jak najbardziej
	* gdy dane nie stanowią problemu (wydajność / ilość)
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

--EXPLAIN ANALYZE
SELECT * 
  FROM products p 
 WHERE product_code LIKE 'PRD6%';

--EXPLAIN ANALYZE
SELECT * 
  FROM products p 
 WHERE product_description LIKE '%190%';

CREATE INDEX idx_prd_product_code ON products USING BTREE(product_code) ;

CREATE INDEX idx_prd_product_description ON products USING BTREE(product_description) ;

DISCARD ALL;

EXPLAIN ANALYZE
SELECT * 
  FROM products p 
 WHERE product_code LIKE 'PRD6%';

EXPLAIN ANALYZE
SELECT * 
  FROM products p 
 WHERE product_description LIKE '%190%';

DISCARD ALL;

/*
ROZWIAZANIE: 
	* Korzystaj z odpowiednich technologii do problemów Apache Solr / Elastic Search
	* Sprawdź co do zaoferowania ma Twoja baza danych
		* Full Text Search
		* Specjalne typy indeksów
 */ 

-- TSVECTOR

ALTER TABLE products ADD COLUMN ts_product_description TSVECTOR;

CREATE TRIGGER ts_product_description 
	BEFORE INSERT OR UPDATE ON products
		FOR EACH ROW EXECUTE PROCEDURE 
			tsvector_update_trigger(ts_product_description, 'pg_catalog.english', product_description);

CREATE INDEX idx_prd_ts_product_decs ON products USING GIN(ts_product_description);

DISCARD ALL;

TRUNCATE TABLE products RESTART IDENTITY;

INSERT INTO products (product_name, product_code, product_quantity, product_description, manufactured_date)
     SELECT 'Product '||floor(random() * 10000 + 1)::int,
            'PRD'||floor(random() * 1000 + 1)::int,
            random() * 10 + 1,
	        md5('PRD'||floor(random() * 1000 + 1)::int),
            CAST((NOW() - (random() * (interval '90 days')))::timestamp AS date)
       FROM generate_series(1, 1000000) s(i);  

SELECT * FROM products;

EXPLAIN ANALYZE
SELECT * 
  FROM products p 
 WHERE ts_product_description @@ to_tsquery('190');

-- TRIGRAM

EXPLAIN ANALYZE
SELECT * 
  FROM products p 
 WHERE product_description LIKE '%190%';

CREATE EXTENSION pg_trgm;

CREATE INDEX idx_trf_prd_product_description ON products USING GIN(product_description gin_trgm_ops);

DISCARD ALL;

EXPLAIN ANALYZE
SELECT * 
  FROM products p 
 WHERE product_description LIKE '%190%'; 

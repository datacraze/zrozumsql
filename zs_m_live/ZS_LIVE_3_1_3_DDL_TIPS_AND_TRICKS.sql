/* TYPY DANY */
DROP TABLE IF EXISTS data_types_check_text, data_types_check_10;

CREATE TABLE data_types_check_text (
    product_name text
);

CREATE TABLE data_types_check_10 (
    product_name varchar(10)
);

INSERT INTO data_types_check_text (product_name)
select 'Product '||floor(random() * 10 + 1)::int
  from generate_series(1, 1000000) s(i);

INSERT INTO data_types_check_10 (product_name)
select 'Product '||floor(random() * 10 + 1)::int
  from generate_series(1, 1000000) s(i);

SELECT pg_size_pretty( pg_table_size('public.data_types_check_text'));
SELECT pg_size_pretty( pg_table_size('public.data_types_check_10'));

CREATE INDEX product_name_text ON data_types_check_text USING btree(product_name);
CREATE INDEX product_name_10 ON data_types_check_10 USING btree(product_name);

SELECT pg_size_pretty( pg_table_size('product_name_text'));
SELECT pg_size_pretty( pg_table_size('product_name_10'));

-- PRONS OR CONS
insert into data_types_check_10 (product_name) values ('Product 111');

-- https://www.postgresql.org/docs/13/datatype-character.html

/* NUMERIC 9.9999 na 10.00 */
  
DROP TABLE IF EXISTS precision_nums;
CREATE TABLE precision_nums (
	quantity NUMERIC(10,2), 
	quantity_real REAL);

SELECT * FROM precision_nums;

INSERT INTO precision_nums VALUES (9.9999, 9.9999);
INSERT INTO precision_nums VALUES (9.9899, 9.9999);
INSERT INTO precision_nums VALUES (TRUNC(9.9999,2), 9.9999);

TRUNCATE TABLE precision_nums;

INSERT INTO precision_nums SELECT 9.9999, 9.9999 FROM generate_series(1,1000000);

SELECT count(*) FROM precision_nums;
SELECT sum(quantity) FROM precision_nums;
SELECT sum(quantity_real) FROM precision_nums;

TRUNCATE TABLE precision_nums;

INSERT INTO precision_nums SELECT TRUNC(9.9999,2), 9.9999 FROM generate_series(1,1000000);

SELECT count(*) FROM precision_nums;
SELECT sum(quantity) FROM precision_nums;
SELECT sum(quantity_real) FROM precision_nums;
SELECT sum(quantity_real::NUMERIC(20,8)) FROM precision_nums;

-- https://www.postgresql.org/docs/13/datatype-numeric.html

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



/* 
Antywzorzec: Tworzenie wielu kolumn dla opisu jednego atrybutu 
Powody:
	* latwiej jest dodać nową kolumnę niż zmienić strukturę istniejącą
	* lenistwo
	* zrobienia na szybko, bo takie są teraz wymagania
Poznasz go po:
	* wielu atrybutach dotyczących tego samego, zawierających różne wartości
Na Twoje usprawiedliwienie:
	* brak usprawiedliwienia :)
*/ 

DROP TABLE IF EXISTS products;

CREATE TABLE products (
	id SERIAL,
	product_name VARCHAR(100),
	product_code VARCHAR(10),
	product_quantity NUMERIC(10,2),	
	manufactured_date DATE,
	tag1 TEXT,
	tag2 TEXT,
	tag3 TEXT
);


INSERT INTO products (product_name, product_code, product_quantity, manufactured_date, tag1, tag2, tag3)
 	 VALUES ('Product 1', 'PRD1', 100.25, '20/11/2019', 'agd', 'home', 'kitchen'),
 	 		('Product 1', 'PRD2', 92.25, '1/11/2019', 'agd', 'casual', NULL),
 	 		('Product 2', 'PRD2', 12.25, '1/11/2019', 'tech', NULL, NULL),
 	 		('Product 3', 'PRD3', 25.25, '2/11/2019', 'casual', NULL, NULL),
 	 		('Product 4', 'PRD4', 68.25, '3/11/2020', 'smart home', 'agd', NULL);

SELECT * FROM products;

-- WSZYSTKIE AGD

SELECT * 
  FROM products 
 WHERE CONCAT(tag1,tag2,tag3) LIKE '%agd%';

SELECT * 
  FROM products 
 WHERE tag1 = 'agd'
    OR tag2 = 'agd'
    OR tag3 = 'agd';

/*
ROZWIAZANIE: 
	* Utworzenie tabeli zależnej 
 */ 
  
DROP TABLE IF EXISTS product_tags;   
CREATE TABLE product_tags (
	id serial,
	tag TEXT UNIQUE
);

INSERT INTO product_tags (tag) 
	VALUES ('agd'), ('home'), ('kitchen'), ('casual'), ('tech'), ('smart home');

DROP TABLE IF EXISTS products, products_tags;

CREATE TABLE products (
	id SERIAL,
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
 	 		('Product 4', 'PRD4', 68.25, '3/11/2020');
 	 	
CREATE TABLE products_tags (
	product_id INTEGER,
	tag_id INTEGER
);	

INSERT INTO products_tags (product_id, tag_id)
 	 VALUES (1,1), (1,2), (1,3), (2,1), (2,4), (3,5), (4,4), (5,6), (5,1);

SELECT p.*,
	   t.tag
  FROM products p 
LEFT JOIN products_tags pt ON pt.product_id = p.id 
LEFT JOIN product_tags t ON t.id = pt.tag_id
 WHERE t.tag = 'agd';

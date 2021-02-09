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
-- https://docs.aws.amazon.com/redshift/latest/dg/r_Character_types.html#r_Character_types-text-and-bpchar-types


/* NUMERIC 9.9999 na 10.00 */
  
DROP TABLE IF EXISTS precision_nums;
CREATE TABLE precision_nums (quantity NUMERIC(10,2), 
				   quantity_real REAL);

SELECT * FROM precision_nums;

INSERT INTO precision_nums VALUES (9.9999, 9.9999);
INSERT INTO precision_nums VALUES (9.9899, 9.9999);
INSERT INTO precision_nums VALUES (TRUNC(9.9999,2), 9.9999);

TRUNCATE TABLE precision_nums;

INSERT INTO precision_nums SELECT 9.9999 FROM generate_series(1,1000000);

SELECT count(*) FROM precision_nums;
SELECT sum(quantity) FROM precision_nums;

TRUNCATE TABLE precision_nums;

INSERT INTO precision_nums SELECT TRUNC(9.9999,2) FROM generate_series(1,1000000);

SELECT count(*) FROM precision_nums;
SELECT sum(quantity) FROM precision_nums;

-- https://www.postgresql.org/docs/13/datatype-numeric.html

/* SCHEMAS AND DEPENDENCIES */
DROP TABLE IF EXISTS products;

CREATE TABLE products (
	id SERIAL,
	product_name VARCHAR(100),
	product_code VARCHAR(10),
	product_category varchar(25),
	product_quantity NUMERIC(10,2),
	manufactured_date DATE,	
	added_by TEXT DEFAULT 'admin',
	created_date TIMESTAMP DEFAULT now()
);

INSERT INTO products (product_name, product_code, product_category, product_quantity, manufactured_date)					    
 	 VALUES ('Product 1', 'PRD1', 'Food', 100.25, '20/11/2019'),
 	 		('Product 1', 'PRD2', 'Food', 92.25, '1/11/2019'),
 	 		('Product 2', 'PRD2', 'Tech', 12.25, '1/11/2019'),
 	 		('Product 3', 'PRD3', 'Tech', 25.25, '2/11/2019'),
 	 		('Product 4', 'PRD4', 'Books', 68.25, '3/11/2019'),
 	 		('Product 5', NULL, 'Books', 11.11, '12/12/2020')
;

DROP TABLE IF EXISTS products_over_100;
CREATE TABLE products_over_100 AS 
SELECT * FROM public.products WHERE product_quantity > 100;


CREATE OR REPLACE VIEW expense_tracker.aggr_products_over_100 AS 
SELECT product_code, 
       sum(product_quantity)
  FROM public.products_over_100 
GROUP BY product_code;

-- https://flywaydb.org/
-- https://www.liquibase.org/
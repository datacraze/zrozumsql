
-- POZIOMY IZOLACJI

https://edu.datacraze.pl/zrozum-sql/modul-2-wprowadzenie-do-baz-danych/lekcja-14-typy-izolacji/ 
https://edu.datacraze.pl/zrozum-sql/modul-2-wprowadzenie-do-baz-danych/lekcja-14-typy-izolacji/?bpmj_eddpc_url=y04EV5FYAZzmHA2jM2XW0m1TMZC6CPpUegat2QEQP5PCSRGOhTWBndlJ6RZY44SITga9EDJ490FDPZbxK6cg0NZpG8JWCJ2fLjAWWFgl1UU1AyRKtnwcu4BfeiyDSLx7EhCF%2BDZO%2FiYpMfMZ%2BnDgmoN%2FHzzLk1KbMTpsWVdP2TCICVu4YFoWw2CfTSj%2BnHhM

SET TRANSACTION transaction_mode [, ...]

ISOLATION LEVEL { SERIALIZABLE | REPEATABLE READ | READ COMMITTED | READ UNCOMMITTED }

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
 	 VALUES ('Product 1', 'PRD1', 100.25, '11/21/2019'),
 	 		('Product 2', 'PRD2', 12.25, '1/11/2019'),
 	 		('Product 3', 'PRD3', 25.25, '2/11/2019'),
 	 		('Product 4', 'PRD4', 68.25, '3/11/2019')
;

-- READ COMMITTED
    -- sesion1 

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SELECT * FROM products;

UPDATE products SET product_code = 'PRD99' WHERE product_code = 'PRD1';

    -- session 2

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SELECT * FROM products;

UPDATE products SET product_code = 'PRD-1' WHERE product_code = 'PRD1';


-- REPEATABLE READ 
    -- sesion1 

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SELECT * FROM products;

UPDATE products SET product_code = 'PRD99' WHERE product_code = 'PRD1';

    -- session 2

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SELECT * FROM products;

UPDATE products SET product_code = 'PRD-1' WHERE product_code = 'PRD1';

select * from products where product_code = 'PRD1';

-- SERIALIZABLE 
    -- sesion1 

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SELECT * FROM products;

UPDATE products SET product_code = 'PRD99' WHERE product_code = 'PRD1';

    -- session 2

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SELECT * FROM products;

UPDATE products SET product_code = 'PRD-1' WHERE product_code = 'PRD1';

select * from products where product_code = 'PRD1';

-- INSERTY
-- READ COMMITTED
    -- s1
    INSERT INTO products (product_name, product_code, product_quantity, manufactured_date)
 	 VALUES ('Product 5', 'PRD5', 99, '11/21/2022');

    -- s2
    select count(*) from products;

-- REPEATABLE READ 
    -- s1
    INSERT INTO products (product_name, product_code, product_quantity, manufactured_date)
 	 VALUES ('Product 5', 'PRD5', 99, '11/21/2022');

    -- s2
    select count(*) from products;
    INSERT INTO products (product_name, product_code, product_quantity, manufactured_date)
 	 VALUES ('Product 5', 'PRD5', 99, '11/21/2022');
     
-- SERIALIZABLE
    -- s1
    INSERT INTO products (product_name, product_code, product_quantity, manufactured_date)
 	 VALUES ('Product 5', 'PRD5', 99, '11/21/2022');

    -- s2
    select count(*) from products;
    INSERT INTO products (product_name, product_code, product_quantity, manufactured_date)
 	 VALUES ('Product 5', 'PRD5', 99, '11/21/2022');

-- INDEKSY - kiedy nie stosowac

https://edu.datacraze.pl/zrozum-sql/modul-11-wydajnosc/lekcja-7-czym-jest-selektywnosc-selectivity/
https://edu.datacraze.pl/zrozum-sql/modul-11-wydajnosc/lekcja-8-czym-jest-kardynalnosc-cardinality/

Cardinality: select count(distinct (deptno)) from employee;

Selectivity = (total unique count/total records)
                  = (2/20,000)
                  = 0.0001

DROP TABLE IF EXISTS sales;

CREATE TABLE sales (
	id SERIAL,
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
       FROM generate_series(1, 1000000) s(i);


select * from pg_indexes where schemaname = 'public';

explain analyze select * from sales where id = 1500;

select count(*) from sales; -- 1000000
select count(distinct id) from sales; -- 1000000 <-- cardinality

select count(distinct id)/count(*) from sales; -- 1 <-- selectivity

create index idx_id_sales on sales (id);

explain analyze select * from sales where id = 1500;

explain analyze select * from sales where added_by = 'test';
explain analyze select * from sales where added_by = 'admin';

select count(*) from sales; -- 1000000
select count(distinct added_by) from sales; -- 1 <-- cardinality
select count(distinct added_by)::float/count(*) from sales; -- 0.000001 <-- selectivity

create index idx_added_by_sales on sales (added_by);

explain analyze select * from sales where added_by = 'test';
explain analyze select * from sales where added_by = 'admin';

-- SEARCH PATH + PUBLIC

SHOW search_path ;

"$user", public

CREATE ROLE test WITH LOGIN PASSWORD 'abc123';
CREATE SCHEMA test AUTHORIZATION test;

CREATE TABLE test_tbl (id serial);

select * from pg_tables where tablename = 'test_tbl';

CREATE TABLE test_tbl2 (id serial);

select * from pg_tables where tablename = 'test_tbl2';

-- ALIASY

https://www.postgresql.org/docs/current/datatype.html

int8 -> 8-byte -> 1 byte = 256 (2^8)^8

-- PUBLIC

https://www.postgresql.org/docs/current/release-15.html

-- KOPIA ZAPASOWA AWS

https://stackoverflow.com/questions/31881786/how-to-pg-dump-an-rds-postgres-database
https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_ExportSnapshot.html


pg_dump -h zrozumsql.cagve7etwfmh.eu-west-1.rds.amazonaws.com -U postgres -d postgres -f ~/Downloads/zrozumsql_dump.sql
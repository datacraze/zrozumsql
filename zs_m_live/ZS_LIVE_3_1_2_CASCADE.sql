DROP SCHEMA IF EXISTS test_cascade1;
DROP SCHEMA IF EXISTS test_cascade2;

CREATE SCHEMA test_cascade1;
CREATE SCHEMA test_cascade2;

DROP TABLE IF EXISTS test_cascade1.products;

CREATE TABLE test_cascade1.products (
	id SERIAL,
	product_name VARCHAR(100),
	product_code VARCHAR(10),
	product_quantity NUMERIC(10,2),
	manufactured_date DATE,	
	manufactured_region VARCHAR(25),
	added_by TEXT DEFAULT 'admin',
	created_date TIMESTAMP DEFAULT now()
);

INSERT INTO test_cascade1.products (product_name, product_code, manufactured_region, product_quantity, manufactured_date)					    
 	 VALUES ('Product 1', 'PRD1', 'Europe', 100.25, '20/11/2019'),
 	 		('Product 1', 'PRD2', 'EMEA', 92.25, '1/11/2019'),
 	 		('Product 2', 'PRD2', 'APAC', 12.25, '1/11/2019'),
 	 		('Product 3', 'PRD3', 'APAC', 25.25, '2/11/2019'),
 	 		('Product 4', 'PRD4', 'North America', 68.25, '3/11/2019'),
 	 		('Product 5', NULL, NULL, 11.11, '12/12/2020')
;

SELECT * FROM test_cascade1.products;

CREATE OR REPLACE VIEW test_cascade2.products_europe 
AS 
SELECT *
  FROM test_cascade1.products
 WHERE manufactured_region = 'Europe';
 
SELECT * FROM test_cascade2.products_europe;

--DROP TABLE test_cascade1.products CASCADE;
--
--DROP SCHEMA IF EXISTS test_cascade1 CASCADE;

-- OPTION 2

CREATE ROLE user_training WITH LOGIN PASSWORD 'user#tra1nin9$';
GRANT CONNECT ON DATABASE postgres TO user_training;
CREATE SCHEMA training AUTHORIZATION user_training;


CREATE ROLE reporting_ro WITH LOGIN PASSWORD 'reporting#us3r$1';
GRANT CONNECT ON DATABASE postgres TO reporting_ro;
GRANT USAGE ON SCHEMA training TO reporting_ro;
CREATE SCHEMA reporting AUTHORIZATION reporting_ro;

REVOKE USAGE ON SCHEMA reporting FROM user_training;
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA reporting FROM user_training;
GRANT SELECT ON ALL TABLES IN SCHEMA training TO reporting_ro;


-- USER 1 
DROP TABLE IF EXISTS training.products;

CREATE TABLE training.products (
	id SERIAL,
	product_name VARCHAR(100),
	product_code VARCHAR(10),
	product_quantity NUMERIC(10,2),
	manufactured_date DATE,	
	manufactured_region VARCHAR(25),
	added_by TEXT DEFAULT 'admin',
	created_date TIMESTAMP DEFAULT now()
);

INSERT INTO training.products (product_name, product_code, manufactured_region, product_quantity, manufactured_date)					    
 	 VALUES ('Product 1', 'PRD1', 'Europe', 100.25, '20/11/2019'),
 	 		('Product 1', 'PRD2', 'EMEA', 92.25, '1/11/2019'),
 	 		('Product 2', 'PRD2', 'APAC', 12.25, '1/11/2019'),
 	 		('Product 3', 'PRD3', 'APAC', 25.25, '2/11/2019'),
 	 		('Product 4', 'PRD4', 'North America', 68.25, '3/11/2019'),
 	 		('Product 5', NULL, NULL, 11.11, '12/12/2020')
;

SELECT * FROM training.products;

-- USER 2
CREATE OR REPLACE VIEW reporting.products_europe 
AS 
SELECT *
  FROM training.products
 WHERE manufactured_region = 'Europe';
 
SELECT * FROM reporting.products_europe;

-- https://www.postgresql.org/docs/12/sql-dropschema.html
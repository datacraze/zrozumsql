-- SQL SKRYPT Z WYTŁUMACZENIEM 9.9999 na 10.00
DROP TABLE test;
CREATE TABLE test (quantity NUMERIC(10,2));

SELECT * FROM test;

INSERT INTO test VALUES (9.9999, 9.9999);
INSERT INTO test VALUES (9.9899, 9.9999);
INSERT INTO test VALUES (TRUNC(9.9999,2), 9.9999);

INSERT INTO test 
SELECT 9.9999 FROM generate_series(1,1000000);

SELECT count(*) FROM test;
SELECT sum(quantity) FROM test;

INSERT INTO test 
SELECT TRUNC(9.9999,2) FROM generate_series(1,1000000);

SELECT count(*) FROM test;
SELECT sum(quantity) FROM test;
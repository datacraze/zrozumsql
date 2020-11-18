DROP TABLE IF EXISTS sales_partitioned, sales;

CREATE TABLE sales_partitioned (
	id SERIAL,
	sal_description TEXT,
	sal_date DATE,
	sal_value NUMERIC(10,2),
	added_by TEXT DEFAULT 'admin',
	created_date TIMESTAMP DEFAULT now()
) PARTITION BY RANGE (sal_date);

CREATE TABLE sales_y2018 PARTITION OF sales_partitioned
    FOR VALUES FROM ('2018-01-01') TO ('2019-01-01');

CREATE TABLE sales_y2019 PARTITION OF sales_partitioned
    FOR VALUES FROM ('2019-01-01') TO ('2020-01-01');
   
CREATE TABLE sales_y2020 PARTITION OF sales_partitioned
    FOR VALUES FROM ('2020-01-01') TO ('2021-01-01');

CREATE TABLE sales (
	id SERIAL,
	sal_description TEXT,
	sal_date DATE,
	sal_value NUMERIC(10,2),
	added_by TEXT DEFAULT 'admin',
	created_date TIMESTAMP DEFAULT now()
);

INSERT INTO sales_partitioned (sal_description, sal_date, sal_value)
     SELECT left(md5(i::text), 15),
     		CAST((NOW() - (random() * (interval '360 days'))) AS DATE),	
     		random() * 100 + 1           
       FROM generate_series(1, 100000) s(i);
   
INSERT INTO sales SELECT * FROM sales_partitioned;    


SELECT * FROM sales;

SELECT * FROM sales_partitioned;

EXPLAIN ANALYZE
SELECT *
  FROM sales
 WHERE sal_date = '2019/01/02';

DISCARD ALL;
EXPLAIN ANALYZE
SELECT *
  FROM sales_partitioned
 WHERE sal_date = '2019/01/02' ;
 
/* UPS */
EXPLAIN ANALYZE
SELECT *
  FROM sales
 WHERE EXTRACT(YEAR FROM sal_date) = 2019;

DISCARD ALL;
EXPLAIN ANALYZE
SELECT *
  FROM sales_partitioned
 WHERE EXTRACT(YEAR FROM sal_date) = 2019;

/* OK */
EXPLAIN ANALYZE
SELECT *
  FROM sales
 WHERE EXTRACT(YEAR FROM sal_date) = 2019;

DISCARD ALL;
EXPLAIN ANALYZE
SELECT *
  FROM sales_partitioned
 WHERE sal_date BETWEEN '2019/01/01' AND '2019/12/31';

/* DROP */
EXPLAIN ANALYZE
DELETE FROM sales 
 WHERE EXTRACT(YEAR FROM sal_date) = 2020;

DROP TABLE sales_y2020;
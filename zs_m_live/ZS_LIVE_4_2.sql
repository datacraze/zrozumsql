--- 1

DROP TABLE IF EXISTS products, sales, product_manufactured_region CASCADE;

CREATE TABLE products (
	id SERIAL,
	product_name VARCHAR(100),
	product_code VARCHAR(10),
	product_quantity NUMERIC(10,2),
	manufactured_date DATE,
	product_man_region INTEGER,
	added_by TEXT DEFAULT 'admin',
	created_date TIMESTAMP DEFAULT now()
);

CREATE TABLE sales (
	id SERIAL,
	sal_description TEXT,
	sal_date DATE,
	sal_value NUMERIC(10,2),
	sal_prd_id INTEGER,
	added_by TEXT DEFAULT 'admin',
	created_date TIMESTAMP DEFAULT now()
);

CREATE TABLE product_manufactured_region (
	id SERIAL,
	region_name VARCHAR(25),
	region_code VARCHAR(10),
	established_year INTEGER
);

INSERT INTO product_manufactured_region (region_name, region_code, established_year)
	  VALUES ('EMEA', 'E_EMEA', 2010),
	  		 ('EMEA', 'W_EMEA', 2012),
	  		 ('APAC', NULL, 2019),
	  		 ('North America', NULL, 2012),
	  		 ('Africa', NULL, 2012);

INSERT INTO products (product_name, product_code, product_quantity, manufactured_date, product_man_region)
     SELECT 'Product '||floor(random() * 10 + 1)::int,
            'PRD'||floor(random() * 10 + 1)::int,
            random() * 10 + 1,
            CAST((NOW() - (random() * (interval '90 days')))::timestamp AS date),
            CEIL(random()*(10-5))::int
       FROM generate_series(1, 10) s(i);

INSERT INTO sales (sal_description, sal_date, sal_value, sal_prd_id)
     SELECT left(md5(i::text), 15),
     		CAST((NOW() - (random() * (interval '60 days'))) AS DATE),
     		random() * 100 + 1,
        	floor(random() * 10)+1::int
       FROM generate_series(1, 10000) s(i);

discard all;
explain analyze
   select count(*)
     from sales s
left join products p on p.id = s.sal_prd_id
    where p.product_code = 'PRD3'

explain analyze
   select count(*)
     from sales s
left join products p on p.id = s.sal_prd_id
                    and p.product_code = 'PRD3'

discard all;
explain analyze
   select count(*)
     from sales s
inner join products p on p.id = s.sal_prd_id
                    and p.product_code = 'PRD3'

discard all;
explain analyze
   select count(*)
     from sales s
inner join products p on p.id = s.sal_prd_id
     where p.product_code = 'PRD3'

-- https://stackoverflow.com/questions/65673841/sql-join-in-postgresql-different-execution-plan-in-where-clause-than-in-on-cla

CREATE TABLE t1 (
    t1_nr int8 NOT NULL,
    name varchar(60),
    CONSTRAINT t1_pk PRIMARY KEY (t1_nr)
);

INSERT INTO t1 (t1_nr, name) SELECT s, left(md5(random()::text), 10) FROM generate_series(1, 1000000) s; -- 1 million records

CREATE TABLE t2 (
    t2_nr int8 NOT NULL,
    CONSTRAINT t2_pk PRIMARY KEY (t2_nr)
);

INSERT INTO t2 (t2_nr) SELECT s FROM generate_series(1, 10000000) s; -- 10 million records

CREATE TABLE t3 (
    t1_nr int8 NOT NULL,
    t2_nr int8 NOT NULL,
    CONSTRAINT t3_pk PRIMARY KEY (t2_nr, t1_nr)
);

INSERT INTO t3 (t1_nr, t2_nr) SELECT (s-1)/10+1, s FROM generate_series(1, 10000000) s; -- 10 t2 records per t1 records --> 10 million records

discard all;
EXPLAIN (BUFFERS, ANALYZE)
SELECT t1.*
FROM t1 t1
WHERE EXISTS (
    SELECT 1
    FROM t3 t3
    JOIN t2 t2 ON t2.t2_nr = t3.t2_nr
    --AND t3.t1_nr = t1.t1_nr /* GOOD (using ON-CLAUSE) */
    WHERE t3.t1_nr = t1.t1_nr /* BAD (using WHERE-CLAUSE) */
)
LIMIT 1000;

Limit  (cost=0.00..23884041.41 rows=1000 width=19) (actual time=126.633..240.216 rows=1000 loops=1)
  Buffers: shared hit=12734 read=17788 written=8
  ->  Seq Scan on t1  (cost=0.00..11942020703.39 rows=500000 width=19) (actual time=0.078..113.588 rows=1000 loops=1)
        Filter: (SubPlan 1)
        Buffers: shared hit=12734 read=17788 written=8
        SubPlan 1
          ->  Nested Loop  (cost=0.43..179123.98 rows=15 width=0) (actual time=0.113..0.113 rows=1 loops=1000)
                Buffers: shared hit=12734 read=17781 written=8
                ->  Seq Scan on t3  (cost=0.00..179057.19 rows=15 width=8) (actual time=0.112..0.112 rows=1 loops=1000)
                      Filter: (t1_nr = t1.t1_nr)
                      Rows Removed by Filter: 4995
                      Buffers: shared hit=9760 read=17754 written=5
                ->  Index Only Scan using t2_pk on t2  (cost=0.43..4.45 rows=1 width=8) (actual time=0.001..0.001 rows=1 loops=1000)
                      Index Cond: (t2_nr = t3.t2_nr)
                      Heap Fetches: 0
                      Buffers: shared hit=2974 read=27 written=3
Planning:
  Buffers: shared hit=143 read=7
Planning Time: 4.036 ms
JIT:
  Functions: 10
"  Options: Inlining true, Optimization true, Expressions true, Deforming true"
"  Timing: Generation 10.721 ms, Inlining 67.590 ms, Optimization 35.341 ms, Emission 22.067 ms, Total 135.719 ms"
Execution Time: 252.218 ms

Limit  (cost=387264.08..387419.17 rows=1000 width=19) (actual time=3403.731..3672.580 rows=1000 loops=1)
"  Buffers: shared hit=9350 read=95483 written=13, temp read=79123 written=123012"
  ->  Gather  (cost=387264.08..488065.07 rows=649967 width=19) (actual time=3389.128..3657.910 rows=1000 loops=1)
        Workers Planned: 2
        Workers Launched: 2
"        Buffers: shared hit=9350 read=95483 written=13, temp read=79123 written=123012"
        ->  Parallel Hash Semi Join  (cost=386264.08..422068.37 rows=270820 width=19) (actual time=3318.882..3319.093 rows=536 loops=3)
              Hash Cond: (t1.t1_nr = t3.t1_nr)
"              Buffers: shared hit=9350 read=95483 written=13, temp read=79123 written=123012"
              ->  Parallel Seq Scan on t1  (cost=0.00..10536.67 rows=416667 width=19) (actual time=0.181..33.437 rows=333333 loops=3)
                    Buffers: shared hit=7 read=6363
              ->  Parallel Hash  (cost=317903.87..317903.87 rows=4166657 width=8) (actual time=3216.140..3216.148 rows=3333333 loops=3)
                    Buckets: 131072  Batches: 256  Memory Usage: 0kB
"                    Buffers: shared hit=9185 read=89118 written=13, temp read=78844 written=116868"
                    ->  Parallel Hash Join  (cost=154274.78..317903.87 rows=4166657 width=8) (actual time=1547.231..2711.090 rows=3333333 loops=3)
                          Hash Cond: (t3.t2_nr = t2.t2_nr)
"                          Buffers: shared hit=9185 read=89118 written=13, temp read=78844 written=80884"
                          ->  Parallel Seq Scan on t3  (cost=0.00..95722.40 rows=4166740 width=16) (actual time=0.047..236.487 rows=3333333 loops=3)
                                Buffers: shared hit=9185 read=44870
                          ->  Parallel Hash  (cost=85914.57..85914.57 rows=4166657 width=8) (actual time=694.891..694.891 rows=3333333 loops=3)
                                Buckets: 131072  Batches: 256  Memory Usage: 2592kB
"                                Buffers: shared read=44248 written=13, temp written=34868"
                                ->  Parallel Seq Scan on t2  (cost=0.00..85914.57 rows=4166657 width=8) (actual time=0.022..203.497 rows=3333333 loops=3)
                                      Buffers: shared read=44248 written=13
Planning:
  Buffers: shared hit=19 read=5
Planning Time: 1.726 ms
JIT:
  Functions: 49
"  Options: Inlining false, Optimization false, Expressions true, Deforming true"
"  Timing: Generation 3.053 ms, Inlining 0.000 ms, Optimization 2.520 ms, Emission 22.676 ms, Total 28.249 ms"
Execution Time: 3674.205 ms

-- https://www.postgresql.org/docs/12/planner-stats.html

--- 2

DROP TABLE IF EXISTS test;
CREATE TABLE test (q_num NUMERIC(10,2)
                 , q_real real);

SELECT * FROM test;

INSERT INTO test VALUES (9.9999, 9.9999);
INSERT INTO test VALUES (9.9899, 9.9999);
INSERT INTO test VALUES (TRUNC(9.9999,2), 9.9999);

INSERT INTO test
SELECT 9.9999, 9.9999 FROM generate_series(1,1000000);

SELECT count(*) FROM test;
SELECT sum(q_num), sum(q_real) FROM test;

truncate table test;

INSERT INTO test
SELECT TRUNC(9.9999,2), 9.9999 FROM generate_series(1,1000000);

SELECT count(*) FROM test;
SELECT sum(q_num), sum(q_real) FROM test;

INSERT INTO test
SELECT TRUNC(1/3::numeric,2), 1/3::real FROM generate_series(1,1000000);

SELECT count(*) FROM test;
SELECT * FROM test;
SELECT sum(q_num), sum(q_real) FROM test;

select 9/10::float;
--- 3

DROP TABLE IF EXISTS products CASCADE;

CREATE TABLE products (
	id SERIAL,
	product_name VARCHAR(100),
	product_code VARCHAR(10),
	product_quantity NUMERIC(10,2),
	manufactured_date DATE,
	manufactured_region VARCHAR(25),
	added_by TEXT DEFAULT 'admin',
	created_date TIMESTAMP DEFAULT now()
);

INSERT INTO products (product_name, product_code, manufactured_region, product_quantity, manufactured_date)
 	 VALUES ('Product 1', 'PRD1', 'Europe', 100.25, '20/11/2019'),
 	 		('Product 1', 'PRD2', 'EMEA', 92.25, '1/11/2019'),
 	 		('Product 2', 'PRD2', 'APAC', 12.25, '1/11/2019'),
 	 		('Product 3', 'PRD3', 'APAC', 25.25, '2/11/2019'),
 	 		('Product 4', 'PRD4', 'North America', 68.25, '3/11/2019'),
 	 		('Product 5', NULL, NULL, 11.11, '12/12/2020')
;

SELECT product_code,
	   COALESCE(product_code,'<unknown>') AS product_code2,
	   COALESCE(product_code,NULL,'<unknown>2') AS product_code2,
	   CASE
	   		WHEN product_code IS NOT NULL THEN product_code
	   		WHEN NULL IS NOT NULL THEN NULL
	   		WHEN '<unknown>2' IS NOT NULL THEN '<unknown>2'
	   		ELSE ''
	    END AS product_code_case
  FROM products;

SELECT product_name,
	   product_code,
	   manufactured_region,
	   CASE
	   		WHEN manufactured_region = 'EMEA' THEN 0.25
	   		WHEN manufactured_region = 'APAC' THEN 0
	   		WHEN manufactured_region = 'North America' THEN 5
	   		ELSE 0
	   	END AS prd_discount_per_region
  FROM products;

SELECT *
  FROM products
 WHERE product_code = NULL
--WHERE product_code is null
 ;

SELECT *
  FROM products
 --WHERE product_code <> NULL
 --WHERE product_code NOT IN ('EMEA') -- OR product_code IS NULL
  WHERE coalesce(product_code,'<unknown>') NOT IN ('EMEA')
--WHERE product_code is not null
 ;

SELECT COALESCE(product_name,'') || ' ' || COALESCE(product_code,'') || ' ' || COALESCE(manufactured_region,''),
	   CONCAT(product_name,' ',product_code,' ',manufactured_region),
       *
  FROM products;


-- M10_L10_WSCHEPOTEZNY_NULL

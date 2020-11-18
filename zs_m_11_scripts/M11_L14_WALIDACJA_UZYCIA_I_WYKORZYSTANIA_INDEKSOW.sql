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

CREATE INDEX idx_products_product_code ON products (product_code);
CREATE INDEX idx_products_prd_code ON products (product_code);

SELECT * FROM pg_catalog.pg_indexes pi3;
  
SELECT t.relname,
 	   pi2.indexrelid::regclass AS idx,
 	   pi2.indrelid,
 	   pi2.indclass::text,
	   pi2.indkey::text,
	   pi2.indexprs::text,
	   pi2.indpred::text
  FROM pg_catalog.pg_index pi2 
  JOIN pg_class t ON t.oid = pi2.indexrelid
 WHERE t.relname LIKE 'idx_products%';
 
 SELECT pg_size_pretty(SUM(pg_relation_size(idx))::BIGINT) AS SIZE,
        (array_agg(idx))[1] AS idx1,
        (array_agg(idx))[2] AS idx2,
        (array_agg(idx))[3] AS idx3,
        (array_agg(idx))[4] AS idx4
   FROM (SELECT indexrelid::regclass AS idx,
 	    	    (indrelid::text ||
 	    	     E'\n'||
 	    	     indclass::text ||
 	    	     E'\n'||
 	    	     indkey::text ||
 	    	     E'\n'||
 	             COALESCE(indexprs::text,'')||
 	             E'\n' ||
 	             COALESCE(indpred::text,'')) AS KEY
 	        FROM pg_index pi2
 	        JOIN pg_class t ON t.oid = pi2.indexrelid
 WHERE t.relname LIKE 'idx_products%') sub
GROUP BY KEY HAVING COUNT(*)>1
ORDER BY SUM(pg_relation_size(idx)) DESC;

-- Get Information about indexes with less then 300 scans that are not unique   
WITH get_schema_names AS (
    SELECT schema_name
 	 FROM information_schema.schemata
 	WHERE schema_name = 'public'
)   SELECT idstat.schemaname AS schema_name,
     	  idstat.relname    AS table_name,
     	  indexrelname      AS index_name,
     	  idstat.idx_scan   AS times_used,
   pg_size_pretty(pg_relation_size(idstat.relname::regclass)) AS table_size,     	  pg_size_pretty(pg_relation_size(indexrelname::regclass))   AS index_size,
     	  n_tup_upd + n_tup_ins + n_tup_del AS num_writes,
     	  indexdef AS definition
 	 FROM pg_stat_user_indexes AS idstat
INNER JOIN pg_indexes ON indexrelname = indexname
INNER JOIN pg_stat_user_tables AS tabstat ON idstat.relname = tabstat.relname
INNER JOIN get_schema_names gt ON gt.schema_name = idstat.schemaname
 	WHERE idstat.idx_scan < 300
 	  AND indexdef !~* 'unique'
 ORDER BY idstat.relname, indexrelname;

SELECT * 
  FROM products 
 WHERE product_code = 'PRD4';

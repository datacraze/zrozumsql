-- ANALIZA STRUKTURY BAZODANOWEJ (SQL)

SELECT * FROM pg_catalog.pg_database pd;

SELECT pg_size_pretty(pg_database_size('postgres'));

SELECT * FROM pg_catalog.pg_tables pt;

SELECT * 
  FROM pg_catalog.pg_tables pt
 WHERE schemaname = 'expense_tracker';

SELECT * 
  FROM information_schema."columns" c 
 WHERE table_schema = 'expense_tracker'
 ORDER BY c.table_name, c.ordinal_position 
 
 SELECT pg_size_pretty(pg_relation_size(CONCAT(c.table_schema,'.',c.table_name)::regclass)),
 		c.table_schema,
 		c.table_name,
 		array_agg(CONCAT(c.column_name,': ',
 						 c.data_type, ' (', 
 						 c.character_maximum_length, '), Nullable? ', 
 						 c.is_nullable, ', Default? ', 
 						 c.column_default)) 	
   FROM information_schema."columns" c 
  WHERE table_schema = 'expense_tracker'
  GROUP BY pg_size_pretty(pg_relation_size(CONCAT(c.table_schema,'.',c.table_name)::regclass)),
 		   c.table_schema,
 		   c.table_name
  ORDER BY c.table_name;

SELECT * 
  FROM pg_catalog.pg_indexes pi2 
 WHERE schemaname = 'expense_tracker';

-- https://github.com/pgexperts/pgx_scripts
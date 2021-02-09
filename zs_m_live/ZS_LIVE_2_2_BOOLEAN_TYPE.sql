/* 
SHOW search_path;

ALTER DATABASE <database_name> SET search_path TO schema1,schema2;

ALTER ROLE <role_name> SET search_path TO schema1,schema2;
*/

CREATE TABLE test2 (
	field text
);

INSERT INTO test2 VALUES ('Yes'), ('No'),('Y'),('N'),('1'),('0'),('True'),('False');

SELECT *,
	   CAST(field AS BOOLEAN)
  FROM test2;
  
 
INSERT INTO test2 VALUES ('YEEES');

SELECT * FROM test2;

SELECT * FROM test3;

CREATE TABLE test3 (
	field boolean
);

INSERT INTO test3 VALUES ('Yes');
-- Jak znalezc sciezke wyszukiwania domyslna w PostgreSQL
show search_path;

-- Jak sprawdzic Collation
select datname, datcollate from pg_database;

-- Utworz nowa baze danych z innym typem Collation
CREATE DATABASE test_collation LC_COLLATE='C' TEMPLATE='template0';

-- Utworzo nowe polaczenie i zaloguj sie do nowej bazy 
-- w obu bazach z collation jak zainstalowane + w nowej utworzonej wyzej wykonaj zapytania i porownaj wyniki
DROP TABLE IF EXISTS tst_collation;

CREATE TABLE tst_collation (
	coll_text TEXT
);

INSERT INTO tst_collation 
	 VALUES ('aaaAAA'),
	 		('AAAaaa'),
	 		('aaaAAAbbbBBB'),
	 		('BBBbbbAAAaaa'),
	 		('aaa'),
	 		('bbb'),
	 		('AAA'),
	 		('BBB');

SELECT * FROM tst_collation ORDER BY coll_text; 	 

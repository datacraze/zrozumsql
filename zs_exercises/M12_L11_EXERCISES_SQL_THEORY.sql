-- #1 Korzystając z tabel administracyjnych bazy danych. Stwórz zapytanie, którego wynikiem będzie lista obiektów:
-- Tabel, widoków, indeksów, typem (t dla tabeli, v dla widoku, i dla indeksu) razem z ich właścicielami i schematem w jakim się znajdują. 

SELECT schemaname AS schema_name,
       viewname AS object_name, 
       'V' AS object_type,
       viewowner AS object_owner
  FROM pg_catalog.pg_views pv 
  UNION ALL
SELECT schemaname, 
       tablename, 
       'T' AS object_type,
       tableowner
  FROM pg_catalog.pg_tables pt
  UNION ALL
SELECT schemaname, 
       tablename,
       'I' AS object_type,
       indexname
  FROM pg_catalog.pg_indexes pi2;
  
-- #2 Korzystając z dodatku pgcrypto (lub z odpowiadających funkcji w Twojej bazie danych). 
-- Zaszyfruj tekst 'ultraSilneHa3l0$567' korzystając z opcji ENCRYPT (pamiętaj o rzutowaniu na typ bytea - ::bytea lub CAST(xxx as bytea)) or CRYPT
-- Następnie przedstaw sposób, sprawdzania hasła w sytuacji logowania użytkownika (DECRYPT / CRYPT)

SELECT 'ultraSilneHa3l0$567';
SELECT encrypt('ultraSilneHa3l0$567'::bytea, 'abc123$_salt'::bytea, 'aes');
SELECT crypt('ultraSilneHa3l0$567', gen_salt('md5'));
SELECT decrypt(
		encrypt('ultraSilneHa3l0$567'::bytea, 'abc123$_salt'::bytea, 'aes'),
		'abc123$_salt'::bytea, 
		'aes'
	   );
	   
SELECT '$1$y/wQ2ZUZ$SOofmwBjkZGOUd1RBFIeR0' = crypt('ultraSilneHa3l0$567', '$1$y/wQ2ZUZ$SOofmwBjkZGOUd1RBFIeR0');

-- #3 Dla danych z tabeli CUSTOMERS (skrypt poniżej), wykorzystaj znane Ci techniki anonimizowania danych.
-- Pozbądź się duplikatów. 
-- Nie pokazuj całego adresu email, tylko domenę firmy (np. X@polska.pl) - dla znalezienie domeny mailowej możesz wykorzystać REGEX - '@(.*)$' (w substring lub REGEXP_MATCH)
-- Pokaż tylko 3 ostatniej cyfry numeru telefonu (reszte zastąp X-ami).

DROP TABLE IF EXISTS customers CASCADE;

CREATE TABLE customers (
	id SERIAL,
	c_name TEXT,
	c_mail TEXT,
	c_phone VARCHAR(9),
	c_description TEXT
);

INSERT INTO customers (c_name, c_mail, c_phone, c_description)
	 VALUES ('Krzysztof Bury', 'kbur@domein.pl', '123789456', left(md5(random()::text), 15)),
	 		('Onufry Zagłoba', 'zagloba@ogniemimieczem.pl', '100000001', left(md5(random()::text), 15)),
	 		('Krzysztof Bury', 'kbur@domein.pl', '123789456', left(md5(random()::text), 15)),
	 		('Pan Wołodyjowski', 'p.wolodyj@polska.pl', '987654321', left(md5(random()::text), 15)),
	 		('Michał Skrzetuski', 'michal<at>zamek.pl', '654987231', left(md5(random()::text), 15)),
	 		('Bohun Tuhajbejowicz', NULL, NULL, left(md5(random()::text), 15));
	 		
SELECT DISTINCT
	   md5(c_name) AS c_name,
	   CONCAT(LEFT(c_mail,1),
	   		  '(at)',
	   		   COALESCE(
	   		   	SUBSTRING(c_mail from '@(.*)$'),
	   		   	SUBSTRING(c_mail from '<at>(.*)$'))) as domain,
	   'XXX XXX '||RIGHT(c_phone,3),
	   c_description
  FROM customers;
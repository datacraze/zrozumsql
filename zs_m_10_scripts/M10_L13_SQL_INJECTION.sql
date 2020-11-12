--L13: Wstrzykiwanie SQL-a  (SQL Injection) 

/* 
Antywzorzec: Dostęp do danych do których nie powinno być dostępu
Powody:
	* błąd bezpieczeństwa aplikacji
Poznasz go po:
	* stratach finansowych Twojej firmy przez wyciek danych
Na Twoje usprawiedliwienie:
	* -
*/ 

/*
  SELECT ... <- TUTAJ
    FROM ... <- TUTAJ
   WHERE ... <- TUTAJ
GROUP BY ... <- TUTAJ 
ORDER BY ... <- TUTAJ
*/

DROP TABLE IF EXISTS products, users;

CREATE TABLE products (
	product_name VARCHAR(100),
	product_code VARCHAR(10),
	product_quantity NUMERIC(10,2),
	manufactured_date DATE
);


CREATE TABLE users (
	id_user SERIAL,
	user_login varchar(25) NOT NULL,
	user_name varchar(50) NOT NULL,
	user_password varchar(100) NOT NULL,
	active bpchar(1) NOT NULL DEFAULT 1
);

INSERT INTO products (product_name, product_code, product_quantity, manufactured_date)
 	 VALUES ('Product 1', 'PRD1', 100.25, '20/11/2019'),
 	 		('Product 1', 'PRD2', 92.25, '1/11/2019'),
 	 		('Product 2', 'PRD2', 12.25, '1/11/2019'),
 	 		('Product 3', 'PRD3', 25.25, '2/11/2019'),
 	 		('Product 4', 'PRD4', 68.25, '3/11/2020'),
 	 		('Product 4', 'PRD4', 68.25, NULL),
            (NULL, 'PRD5', NULL, NULL)
;

INSERT INTO users (user_login,user_name,user_password,active) VALUES
	 ('jkowalski','Janusz Kowalski','b8dc82c15ae882bbe7e04659a60e3cba','1'),
	 ('gkowalska','Grażyna Kowalska','3c37f9d5ca7960423885c668a4058b21','1');

---- 

SELECT *
  FROM products p 
 WHERE product_code = $1; <-- PARAMETR Z ZEWNATRZ
 
'PRD2';SELECT * FROM users; 
'PRD2';DROP DATABASE postgres;

--https://dba.stackexchange.com/questions/49699/sql-injection-in-postgres-functions-vs-prepared-queries
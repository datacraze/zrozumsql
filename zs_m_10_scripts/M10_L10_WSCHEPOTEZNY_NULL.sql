--L10: Wszchpoteżny NULL

/* 
Antywzorzec: Strach przed wartością nieokreśloną / NULL
Powody:
	* unikanie dodatkowej składni do obsługi NULL
	* robimy tutaj tak, żeby w wyniku nie mieć NULL
Poznasz go po:
	* NULL w wynikach gdy spodziewana jest wartość
	* braku w wynikach przy wykorzystywaniu WHERE
	* dokumentowaniu "specjalnych" wartości dla kolumn
Na Twoje usprawiedliwienie:
	* gdy są postawione takie a nie inne wymagania biznesowe
	* gdy w innych warstwach nie możemy tego zmienić
*/ 

DROP TABLE IF EXISTS products;

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
 	 VALUES ('Product 1', 'PRD1', 100.25, '20/11/2019'),
 	 		('Product 1', NULL, 92.25, '1/11/2019'),
 	 		('Product 2', 'PRD2', 12.25, '1/11/2019'),
 	 		('Product 3', 'PRD3', 25.25, NULL),
 	 		(NULL, 'PRD4', 68.25, '3/11/2020');

SELECT * FROM products; 

SELECT * 
  FROM products p
 WHERE product_code LIKE 'PRD_';

SELECT * 
  FROM products p 
 WHERE product_code = NULL;

SELECT 2+NULL;

SELECT 'TEST'||NULL;

SELECT count(product_code) FROM products;

SELECT CASE 
	   	WHEN NULL = FALSE THEN 'TO JEST FALSE'
	   	WHEN NULL = TRUE THEN 'TO JEST TRUE'
	   	WHEN NULL = NULL THEN 'TO JEST NULL'
	   	ELSE '?'
	   END;

SELECT CASE 
	   	WHEN NULL = FALSE THEN 'TO JEST FALSE'
	   	WHEN NULL = TRUE THEN 'TO JEST TRUE'
	   	WHEN NULL = NULL THEN 'TO JEST NULL'
	   	WHEN NULL IS NULL THEN 'MAMY TO'
	   	ELSE '?'
	   END;	  

-- JAK SOBIE RADZIC

SELECT * 
  FROM products p 
 WHERE product_code IS NULL;	-- IS NOT NULL


SELECT * 
  FROM products p 
 WHERE COALESCE(product_code,'') = '';	

SELECT COALESCE(NULL,'Tekst')||' - '||'Inny Tekst';

SELECT CONCAT(NULL, ' - ', 'Inny Tekst');

SELECT count(COALESCE(product_code,'')) FROM products;

/*
ROZWIAZANIE: 
	* Korzystaj z odpowiedniej składni do obsługi NULL
	* wykorzystuj COALESCE
 */ 
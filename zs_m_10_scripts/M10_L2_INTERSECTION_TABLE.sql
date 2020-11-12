--L2: Przechowywanie Atrybutów Wielowartościowych

/* 
Antywzorzec: Kolumna z listą wartości oddzielonych przecinkami
Powody:
	* konieczność zmiany struktury
	* lenistwo
	* konieczność zmiany zapytań 
Poznasz go po:
	* kolumnie z identyfikatorami oddzielonymi przecinkami lub tablicy
	* "Potrzebuje wyciągnąć tylko część identyfikatoró z tej kolumny, jak mogę to zrobić?"
Na Twoje usprawiedliwienie:
	* świadoma denormalizacja wynikająca z zysków wydajności 	
*/ 

DROP TABLE IF EXISTS products, customers;

CREATE TABLE products (
	id SERIAL,
	product_name VARCHAR(100),
	product_code VARCHAR(10),
	product_quantity NUMERIC(10,2),
	manufactured_date DATE,	
	customers_id TEXT,
	added_by TEXT DEFAULT 'admin',
	created_date TIMESTAMP DEFAULT now()
);

CREATE TABLE customers (
	id SERIAL,
	customer_name TEXT,
	added_by TEXT DEFAULT 'admin',
	created_date TIMESTAMP DEFAULT now()
);

INSERT INTO products (product_name, product_code, product_quantity, manufactured_date, customers_id)
 	 VALUES ('Product 1', 'PRD1', 100.25, '20/11/2019', '1,5'),
 	 		('Product 1', 'PRD2', 92.25, '1/11/2019', '1,2'),
 	 		('Product 2', 'PRD2', 12.25, '1/11/2019', '2'),
 	 		('Product 3', 'PRD3', 25.25, '2/11/2019', '3'),
 	 		('Product 4', 'PRD4', 68.25, '3/11/2020', '4,5');

INSERT INTO customers (customer_name) 
	VALUES ('Krzysztof Bury'),
		   ('Onufry Zagłoba'),
		   ('Bohun Tuhajbejowicz'),
		   ('Michał Wołodyjowski'),
		   ('Longinus Podbipięta');

-- PROBLEM		  
SELECT p.*, 
       c.customer_name
  FROM products p
  JOIN customers c ON c.id = ANY(CAST(string_to_array(p.customers_id,',') AS INTEGER[]));
 
/* 
ROZWIAZANIE: Tabela Lącząca - Intersection Table - (wiele - do - wielu)
Opcjonalnie: Dodanie kluczy obcych pomiędzy tabelami. 
 */

DROP TABLE IF EXISTS products_customers;
CREATE TABLE products_customers (
	id SERIAL,
	product_id INTEGER, 
	customer_id INTEGER
 );

INSERT INTO products_customers (product_id, customer_id)
	SELECT p.id AS product_id,
		   c.id AS customer_id
	  FROM products p
	  JOIN customers c ON c.id = ANY(CAST(string_to_array(p.customers_id,',') AS INTEGER[]))
	 ORDER BY p.id, c.id;

ALTER TABLE products DROP COLUMN customers_id;

-- ROZWIAZANIE
SELECT p.*, 
       c.customer_name
  FROM products p
  JOIN products_customers pc ON pc.product_id = p.id 
  JOIN customers c ON c.id = pc.customer_id
ORDER BY p.id, c.id;

-- Przechowuj wartości w osobnej kolumnie i wierszu! 
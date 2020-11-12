--L5: Związki Polimorficzne

/* 
Antywzorzec: Związki polimorficzne (Polymorphic Associations) 
Powody:
	* odwoływanie się do różnych relacji jednym kluczem
Poznasz go po:
	* osobnym atrybucie w tabeli, który mówi do jakiej relacji się odwołać
Na Twoje usprawiedliwienie:
	* jeżeli coś za nas utrzymuj związek polimorficzny (Java Hibernate / RoR Active Record)
*/ 

DROP TABLE IF EXISTS products, customers, details_notes;

CREATE TABLE details_notes (
	id serial,
	detail_reference TEXT,
	detail_note TEXT
);

CREATE TABLE products (
	id SERIAL,
	product_name VARCHAR(100),
	product_code VARCHAR(10),
	product_quantity NUMERIC(10,2),	
	manufactured_date DATE,
	added_by TEXT DEFAULT 'admin',
	created_date TIMESTAMP DEFAULT now(),
	note_id INTEGER
);

CREATE TABLE customers (
	id SERIAL,
	customer_name VARCHAR(25),
	note_id INTEGER
);

INSERT INTO products (product_name, product_code, product_quantity, manufactured_date, note_id)
 	 VALUES ('Product 1', 'PRD1', 100.25, '20/11/2019', 1),
 	 		('Product 1', 'PRD2', 92.25, '1/11/2019', 2),
 	 		('Product 2', 'PRD2', 12.25, '1/11/2019', 3),
 	 		('Product 3', 'PRD3', 25.25, '2/11/2019', NULL),
 	 		('Product 4', 'PRD4', 68.25, '3/11/2020', NULL);

INSERT INTO customers (customer_name, note_id) 
	VALUES ('Krzysztof Bury', 3),
		   ('Onufry Zagłoba', 3),
		   ('Bohun Tuhajbejowicz', 4),
		   ('Michał Wołodyjowski', NULL),
		   ('Longinus Podbipięta', 5);
      
INSERT INTO details_notes (detail_reference, detail_note)
	VALUES ('PRODUCTS', 'Best selling products.'),
		   ('PRODUCTS', 'Possible decomission.'),
		   ('CUSTOMERS', 'Invest in this customer.'),
		   ('CUSTOMERS', 'One time client.'),
		   ('CUSTOMERS', 'All time best client.');

SELECT dn.*,
	   c.*,
	   p.*
  FROM details_notes dn
  LEFT JOIN products p ON p.note_id = dn.id AND dn.detail_reference = 'PRODUCTS'
  LEFT JOIN customers c ON c.note_id = dn.id AND dn.detail_reference = 'CUSTOMERS';
 		   
/*
ROZWIAZANIE: 
	* Tworzenie tabel łączących wiele do wielu 
	* Denormalizcja (dodanie atrybutów do tabel products / customers)
	* Tworzenie "nadtabeli" - dziedziczenie
 */ 
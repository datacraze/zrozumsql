--L3: Mylne Identyfikatory

/* 
Antywzorzec: Dodawanie kluczy zastępczych gdy nie są potrzebne
Powody:
	* tak uczyli mnie w szkole :) 
	* bo tak są szybsze złączenia
	* bo to mi daje unikatowość
Poznasz go po:
	* większość tabel w Twojej bazie danych ma dodatkowy atrybuty ID 
	  (nawet gdy jest tam idealny klucz naturalny)	
	* Po połączeniu tej tabeli współdzielonej mam duplikaty, dlaczego?
Na Twoje usprawiedliwienie:
	* przyjęta konwencja w projekcie
	* wymagania Frameworka
	* akceptowanie takiej sytuacji
	* zapytania które bazują wyłącznie na identyfikatorach
*/ 

DROP TABLE IF EXISTS products;

CREATE TABLE products (
	prd_id VARCHAR(50) UNIQUE,
	product_name VARCHAR(100),
	product_code VARCHAR(10),
	product_quantity NUMERIC(10,2),
	manufactured_date DATE,	
	customers_id TEXT,
	added_by TEXT DEFAULT 'admin',
	created_date TIMESTAMP DEFAULT now()
);

INSERT INTO products (prd_id, product_name, product_code, product_quantity, manufactured_date, customers_id)
 	 VALUES ('P1CD1', 'Product 1', 'PRD1', 100.25, '20/11/2019', '1,5'),
 	 		('P1CD2', 'Product 1', 'PRD2', 92.25, '1/11/2019', '1,2'),
 	 		('P2CD2', 'Product 2', 'PRD2', 12.25, '1/11/2019', '2'),
 	 		('P3CD3', 'Product 3', 'PRD3', 25.25, '2/11/2019', '3'),
 	 		('P4CD4', 'Product 4', 'PRD4', 68.25, '3/11/2020', '4,5');
 	 	
ALTER TABLE products ADD COLUMN id SERIAL; 	 	

UPDATE products p SET id = (SELECT rn 
							  FROM (SELECT pin.prd_id,
										   ROW_NUMBER() OVER (ORDER BY prd_id) rn
									  FROM products pin) sq
							 WHERE p.prd_id = sq.prd_id);

SELECT * FROM products;							

CREATE TABLE products_customers (
	id SERIAL,
	product_id INTEGER,
	customer_id INTEGER
);

INSERT INTO public.products_customers (product_id,customer_id) 
	VALUES (1,1), (1,5), (2,1), (2,2), (3,2), (4,3), (5,4), (5,5);
	
/*
ROZWIAZANIE: 
	* Rozważ używanie kluczy naturalnych jako PRIMARY KEY
	* Pamiętaj o możliwości korzystania z kluczy złożonych
 */

ALTER TABLE products_customers DROP COLUMN id;

ALTER TABLE products_customers 
	ADD CONSTRAINT pk_products_customers 
		PRIMARY KEY (product_id, customer_id);	
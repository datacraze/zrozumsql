--L6: Tworzenie Wielu Kolumn Dla Atrybutów Tabeli

/* 
Antywzorzec: Tworzenie wielu kolumn dla opisu jednego atrybutu 
Powody:
	* latwiej jest dodać nową kolumnę niż zmienić strukturę istniejącą
	* lenistwo
	* zrobienia na szybko, bo takie są teraz wymagania
Poznasz go po:
	* wielu atrybutach dotyczących tego samego, zawierających różne wartości
Na Twoje usprawiedliwienie:
	* brak usprawiedliwienia :)
*/ 

DROP TABLE IF EXISTS products;

CREATE TABLE products (
	id SERIAL,
	product_name VARCHAR(100),
	product_code VARCHAR(10),
	product_quantity NUMERIC(10,2),	
	manufactured_date DATE,
	tag1 TEXT,
	tag2 TEXT,
	tag3 TEXT
);


INSERT INTO products (product_name, product_code, product_quantity, manufactured_date, tag1, tag2, tag3)
 	 VALUES ('Product 1', 'PRD1', 100.25, '20/11/2019', 'agd', 'home', 'kitchen'),
 	 		('Product 1', 'PRD2', 92.25, '1/11/2019', 'agd', 'casual', NULL),
 	 		('Product 2', 'PRD2', 12.25, '1/11/2019', 'tech', NULL, NULL),
 	 		('Product 3', 'PRD3', 25.25, '2/11/2019', 'casual', NULL, NULL),
 	 		('Product 4', 'PRD4', 68.25, '3/11/2020', 'smart home', 'agd', NULL);

SELECT * FROM products;

-- WSZYSTKIE AGD

SELECT * 
  FROM products 
 WHERE CONCAT(tag1,tag2,tag3) LIKE '%agd%';

SELECT * 
  FROM products 
 WHERE tag1 = 'agd'
    OR tag2 = 'agd'
    OR tag3 = 'agd';

/*
ROZWIAZANIE: 
	* Utworzenie tabeli zależnej 
 */ 
  
DROP TABLE IF EXISTS product_tags;   
CREATE TABLE product_tags (
	id serial,
	tag TEXT UNIQUE
);

INSERT INTO product_tags (tag) 
	VALUES ('agd'), ('home'), ('kitchen'), ('casual'), ('tech'), ('smart home');

DROP TABLE IF EXISTS products, products_tags;

CREATE TABLE products (
	id SERIAL,
	product_name VARCHAR(100),
	product_code VARCHAR(10),
	product_quantity NUMERIC(10,2),	
	manufactured_date DATE
);

INSERT INTO products (product_name, product_code, product_quantity, manufactured_date)
 	 VALUES ('Product 1', 'PRD1', 100.25, '20/11/2019'),
 	 		('Product 1', 'PRD2', 92.25, '1/11/2019'),
 	 		('Product 2', 'PRD2', 12.25, '1/11/2019'),
 	 		('Product 3', 'PRD3', 25.25, '2/11/2019'),
 	 		('Product 4', 'PRD4', 68.25, '3/11/2020');
 	 	
CREATE TABLE products_tags (
	product_id INTEGER,
	tag_id INTEGER
);	

INSERT INTO products_tags (product_id, tag_id)
 	 VALUES (1,1), (1,2), (1,3), (2,1), (2,4), (3,5), (4,4), (5,6), (5,1);

SELECT p.*,
	   t.tag
  FROM products p 
LEFT JOIN products_tags pt ON pt.product_id = p.id 
LEFT JOIN product_tags t ON t.id = pt.tag_id
 WHERE t.tag = 'agd';

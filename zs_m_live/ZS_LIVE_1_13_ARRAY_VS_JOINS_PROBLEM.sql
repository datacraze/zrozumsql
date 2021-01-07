DROP TABLE offer;

CREATE TABLE offer (
	id SERIAL,
	offer_code TEXT,
	offer_name TEXT
);

INSERT INTO offer (offer_code, offer_name)
	 VALUES ('TV Package 3', 'Package of 3 channels'),
	 		('TV Package 5', 'Package of 5 channels'),
	 		('TV Package Info', 'Package of only info channels.'),
	 		(' TV Full', 'All Packages.');
	 	
DROP TABLE article;	 	

CREATE TABLE article (
	id SERIAL,
	article_name TEXT,
	offer_id INTEGER
);

-- ARTICLE OCZYWISCIE POWINNO BY ROZDZIELONE OSOBNO NA ARTICLE i ARTICLE_OFFER

INSERT INTO article (article_name, offer_id)
	 VALUES ('TVP', 1),
	 		('TVP2', 1),
	 		('TVP Sport', 1),
	 		('TVP', 2),
	 		('TVP2', 2),
	 		('TVP Sport', 2),
	 		('Polsat Sport', 2),
	 		('TVN',2),
	 		('TVP', 3),
	 		('TVP2', 3),
	 		('TVN',3),	
	 		('TVP', 4),
	 		('TVP2', 4),
	 		('TVP Sport', 4),
	 		('Polsat Sport', 4),
	 		('TVN',4);

DROP TABLE client;	 

CREATE TABLE client (
	id SERIAL,
	name TEXT,
	offer_selected INTEGER[]
);

INSERT INTO client (name, offer_selected)
	 VALUES ('Krzysiek B.', '{4}'),
	 		('Zagloba', '{2,3}'),
	 		('Jan', '{1}');

SELECT cu.name, o.*, article_name
  FROM (SELECT c.name, 
	           unnest(c.offer_selected) AS offer_id
	      FROM client c) cu
  JOIN offer o ON o.id = cu.offer_id
  JOIN article a ON a.offer_id = o.id
-- W WHERE PARAMETRY TAK JAK DO FUNKCJI
WHERE cu.name = 'Zagloba'
  AND o.id = 2
	 	
-- TAB A - oferty (id, kod, nazwa)
-- TAB Z - artykuly dla ofery (id_artykulu, 
							-- id_oferty)

-- TAB B - sprawdzane sa oferty np. klienci 
-- Klient ma dana oferte i wszystkie artykuly

-- numer klienta
-- kod oferty

-- wynik lista kodow artykulow
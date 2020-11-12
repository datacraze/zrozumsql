--L4: Rezygnacje Z Ograniczeń

/* 
Antywzorzec: Rezygnacja z kluczy obcych
Powody:
	* świadomy wybór
	* przeświadczenie, że to jest wolne
Poznasz go po:
	* braku ograniczeń kluczy obcach pomiędzy relacjami
Na Twoje usprawiedliwienie:
	* świadomy wybór
	* godzenie się z konsekwencjami
	* architektura rozwiązania (np. hurtownia danych)
*/ 

DROP TABLE IF EXISTS products, product_manufactured_region;

CREATE TABLE products (
	id SERIAL,
	product_name VARCHAR(100),
	product_code VARCHAR(10),
	product_quantity NUMERIC(10,2),	
	manufactured_date DATE,
	product_man_region INTEGER,
	added_by TEXT DEFAULT 'admin',
	created_date TIMESTAMP DEFAULT now()
);

CREATE TABLE product_manufactured_region (
	id SERIAL,
	region_name VARCHAR(25),
	region_code VARCHAR(10),
	established_year INTEGER
);

INSERT INTO products (product_name, product_code, product_quantity, manufactured_date, product_man_region)
     SELECT 'Product '||floor(random() * 10 + 1)::int,
            'PRD'||floor(random() * 10 + 1)::int,
            random() * 10 + 1,
            CAST((NOW() - (random() * (interval '90 days')))::timestamp AS date),
            CEIL(random()*(10-5))::int
       FROM generate_series(1, 10) s(i);  

INSERT INTO product_manufactured_region (region_name, region_code, established_year)
	  VALUES ('EMEA', 'E_EMEA', 2010),
	  		 ('EMEA', 'W_EMEA', 2012),
	  		 ('APAC', NULL, 2019),
	  		 ('North America', NULL, 2012),
	  		 ('Africa', NULL, 2012);
      
   SELECT p.*, 
	      pmr.id, pmr.region_name
     FROM products p 
LEFT JOIN product_manufactured_region pmr ON pmr.id = p.product_man_region;
 
DELETE FROM product_manufactured_region WHERE id = 5; -- AFRICA

    SELECT p.*, 
	       pmr.id, pmr.region_name
      FROM products p 
 LEFT JOIN product_manufactured_region pmr ON pmr.id = p.product_man_region;

-- CO TERAZ?

-- A Inaczej?

INSERT INTO products (product_name, product_code, product_quantity, manufactured_date, product_man_region)
 	 VALUES ('Product 6', 'PRD6', 99.25, '20/11/2019', 5);

    SELECT p.*, 
	       pmr.id, pmr.region_name
      FROM products p 
 LEFT JOIN product_manufactured_region pmr ON pmr.id = p.product_man_region;
 
-- CO POWINNISMY ZROBIC? 

INSERT INTO products (product_name, product_code, product_quantity, manufactured_date, product_man_region)
     SELECT * 
       FROM (SELECT 'Product 6' AS product_name, 
		            'PRD6' AS product_code, 
		            99.25 AS product_quantity, 
		            '20/11/2019'::date AS manufactured_date,
		            5 AS product_man_region
        	) sq 
     WHERE EXISTS (SELECT 1 
                     FROM product_manufactured_region pmr 
                    WHERE pmr.id = sq.product_man_region);
                   
-- NO DA SIĘ TYLKO PO CO? 

/*
ROZWIAZANIE: 
	* Pamiętaj o A.C.I.D - C - CONSISTENCY - Integralność / Spójność
	* Rozważ używanie ograniczeń albo pogodź się z konsekwencjami.
 */
                   
TRUNCATE TABLE products, product_manufactured_region RESTART IDENTITY;                   

INSERT INTO products (product_name, product_code, product_quantity, manufactured_date, product_man_region)
     SELECT 'Product '||floor(random() * 10 + 1)::int,
            'PRD'||floor(random() * 10 + 1)::int,
            random() * 10 + 1,
            CAST((NOW() - (random() * (interval '90 days')))::timestamp AS date),
            CEIL(random()*(10-5))::int
       FROM generate_series(1, 10) s(i);  

INSERT INTO product_manufactured_region (region_name, region_code, established_year)
	  VALUES ('EMEA', 'E_EMEA', 2010),
	  		 ('EMEA', 'W_EMEA', 2012),
	  		 ('APAC', NULL, 2019),
	  		 ('North America', NULL, 2012),
	  		 ('Africa', NULL, 2012);
	  		
ALTER TABLE product_manufactured_region
	ADD CONSTRAINT pk_product_man_region_id
		PRIMARY KEY (id);
	
ALTER TABLE products 
	ADD CONSTRAINT fk_product_man_region 
		FOREIGN KEY (product_man_region)
			REFERENCES product_manufactured_region (id);

SELECT * FROM products;		
SELECT * FROM product_manufactured_region;

DELETE FROM product_manufactured_region WHERE id = 5; -- AFRICA

INSERT INTO products (product_name, product_code, product_quantity, manufactured_date, product_man_region)
 	 VALUES ('Product 6', 'PRD6', 99.25, '20/11/2019', 6);

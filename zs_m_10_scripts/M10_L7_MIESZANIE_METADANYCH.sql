--L7: Mieszanie Metadanych Z Danymi

/* 
Antywzorzec: Powielanie tabel / kolumn
Powody:
	* chęć zysku na wydajności
Poznasz go po:
	* aktywnym wykorzystywaniu tabel / kolumn które w swoich nazwach mają metadane (np. rok)
Na Twoje usprawiedliwienie:
	* używanie do archiwizacji
	* używanie do kopii zapasowej
*/ 

DROP TABLE IF EXISTS sales_2018, sales_2019, sales_2020;

CREATE TABLE sales_2018 (
	id SERIAL,
	sal_description TEXT,
	sal_date DATE,
	sal_value NUMERIC(10,2)
);

INSERT INTO sales_2018 (sal_description, sal_date, sal_value)
	VALUES ('sales1','2018-10-10',1000),
		   ('sales2','2018-04-05',500);

CREATE TABLE sales_2019 (
	id SERIAL,
	sal_description TEXT,
	sal_date DATE,
	sal_value NUMERIC(10,2)
);

INSERT INTO sales_2019 (sal_description, sal_date, sal_value)
	VALUES ('sales3','2019-11-10',490),
		   ('sales4','2019-05-05',1200);

CREATE TABLE sales_2020 (
	id SERIAL,
	sal_description TEXT,
	sal_date DATE,
	sal_value NUMERIC(10,2)
);

INSERT INTO sales_2020 (sal_description, sal_date, sal_value)
	VALUES ('sales5','2020-02-10',1120),
		   ('sales6','2020-10-05',2048);

SELECT sal_description, sal_value
  FROM sales_2018
  UNION ALL
SELECT sal_description, sal_value
  FROM sales_2019
  UNION ALL
SELECT sal_description, sal_value
  FROM sales_2020;  
 
/*
ROZWIAZANIE: 
	* Partycjonowanie
	* Indeksy
 */ 
  
DROP TABLE IF EXISTS sales;

CREATE TABLE sales (
	id SERIAL,
	sal_description TEXT,
	sal_date DATE,
	sal_value NUMERIC(10,2),
	sal_discount NUMERIC (10,2),
	added_by TEXT DEFAULT 'admin',
	created_date TIMESTAMP DEFAULT now()
) PARTITION BY RANGE (sal_date);

CREATE TABLE sales_y2018 PARTITION OF sales
    FOR VALUES FROM ('2018-01-01') TO ('2018-12-31');

CREATE TABLE sales_y2019 PARTITION OF sales
    FOR VALUES FROM ('2019-01-01') TO ('2019-12-31');
   
CREATE TABLE sales_y2020 PARTITION OF sales
    FOR VALUES FROM ('2020-01-01') TO ('2020-12-31');

CREATE INDEX ON sales (sal_date);

INSERT INTO sales (sal_description, sal_date, 
				   sal_value, sal_discount)
  	 VALUES ('201901_sale', '12/12/2019', 1000, 90),
  	  	    ('201902_sale', '24/06/2019', 10000, 190),
      	    ('201801_sale', '05/04/2018', 5630, 102),
      	    ('202001_sale', '07/04/2020', 7230, 0);
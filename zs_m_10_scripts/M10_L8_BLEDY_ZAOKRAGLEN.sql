--L8: Błędy Zaokrągleń

/* 
Antywzorzec: Używanie nieodpowiednich typów numerycznych
Powody:
	* nieświadomość definicji danego typu
	* "bo tam tak robimy"
Poznasz go po:
	* różnicy w oczekiwanie wartości kontra wartości uzyskanej
Na Twoje usprawiedliwienie:
	* nie ma usprawiedliwienia :)
*/ 

DROP TABLE IF EXISTS numeric_vs_float;
CREATE TABLE numeric_vs_float (
	value_numeric NUMERIC(10,2),
	value_float FLOAT
);

SELECT * FROM numeric_vs_float;

INSERT INTO numeric_vs_float VALUES (9.9999, 9.9999);
INSERT INTO numeric_vs_float VALUES (9.9899, 9.9999);

SELECT * FROM numeric_vs_float;

INSERT INTO numeric_vs_float VALUES (TRUNC(9.9999,2), 9.9999);

SELECT * FROM numeric_vs_float;

DROP TABLE IF EXISTS sales CASCADE;

CREATE TABLE sales (
	id SERIAL,
	sal_description TEXT,
	sal_date DATE,
	sal_value_num NUMERIC(10,2),
	sal_value_float FLOAT,
	added_by TEXT DEFAULT 'admin',
	created_date TIMESTAMP DEFAULT now()
);

INSERT INTO sales (sal_description, sal_date, sal_value_num, sal_value_float)
     SELECT left(md5(i::text), 15),
     		CAST((NOW() - (random() * (interval '60 days'))) AS DATE),	
     		9.9999,
        	9.9999            
       FROM generate_series(1, 1000000) s(i);         

SELECT count(*) FROM sales;
SELECT sum(sal_value_num), sum(sal_value_float) FROM sales;

TRUNCATE TABLE sales RESTART IDENTITY;

INSERT INTO sales (sal_description, sal_date, sal_value_num, sal_value_float)
     SELECT left(md5(i::text), 15),
     		CAST((NOW() - (random() * (interval '60 days'))) AS DATE),	
     		TRUNC(9.9999,2),
        	9.9999            
       FROM generate_series(1, 1000000) s(i);  
      
SELECT count(*) FROM sales;
SELECT sum(sal_value_num), sum(sal_value_float) FROM sales;

/* 
 * ROZWIAZANIE: Używaj odpowiedniego typu danych do danego problemu.
 */

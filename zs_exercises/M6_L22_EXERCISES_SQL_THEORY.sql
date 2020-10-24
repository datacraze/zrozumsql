--- SKRYPT POCZĄTKOWY
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
     SELECT 'Product '||floor(random() * 10 + 1)::int,
            'PRD'||floor(random() * 10 + 1)::int,
            random() * 10 + 1,
            CAST((NOW() - (random() * (interval '90 days')))::timestamp AS date)
       FROM generate_series(1, 10) s(i);
  
DROP TABLE IF EXISTS sales;

CREATE TABLE sales (
	id SERIAL,
	sal_description TEXT,
	sal_date DATE,
	sal_value NUMERIC(10,2),
	sal_qty NUMERIC(10,2),
	sal_product_id INTEGER,
	added_by TEXT DEFAULT 'admin',
	created_date TIMESTAMP DEFAULT now()
);

INSERT INTO sales (sal_description, sal_date, sal_value, sal_qty, sal_product_id)
     SELECT left(md5(i::text), 15),
     		CAST((NOW() - (random() * (interval '60 days'))) AS DATE),	
     		random() * 100 + 1,
            floor(random() * 10 + 1)::int,
        	floor(random() * 10)::int            
       FROM generate_series(1, 10000) s(i);     

      
-- #1 Wyświetl unikatowe daty stworzenia produktó (według atrybutu manufactured_date) 

SELECT DISTINCT 
	   p.manufactured_date
  FROM products p;
 
-- #2 Jak sprawdzisz czy 10 wstawionych produktów to 10 unikatowyc kodów produktów?

SELECT p.product_code
  FROM products p;
 
--vs 

SELECT DISTINCT 
       product_code
  FROM products p;
 
SELECT p.product_code
  FROM products p
 ORDER BY p.product_code; 
 
SELECT count(p.product_code), 
       count(DISTINCT p.product_code)
  FROM products p; 
 
-- #3 Korzystając ze składni IN wyświetl produkty od kodach PRD1 i PRD9
SELECT p.* 
  FROM products p
 WHERE p.product_code IN ('PRD1','PRD9');

-- #4 Wyświetl wszystkie atrybuty z danych sprzedażowych, takie że data sprzedaży jest w zakresie od 1 sierpnia 2020 do 31 sierpnia 2020 (włącznie). Dane wynikowe mają byc posortowane według wartości sprzedaży malejąco i daty sprzedaży rosnąco.

SELECT s.*
  FROM sales s
 WHERE s.sal_date BETWEEN '01/08/2020' AND '31/08/2020'
ORDER BY s.sal_value DESC, s.sal_date;
 
-- #5 Korzystając ze składni NOT EXISTS wyświetl te produkty z tabeli PRODUCTS, które nie biorą udziału w transakcjach sprzedażowych (tabela SALES). ID z tabeli Products i SAL_PRODUCT_ID to klucz łączenia.

SELECT p.*
  FROM products p
 WHERE NOT EXISTS (SELECT 1
 					 FROM sales s
 					WHERE s.sal_product_id = p.id);

-- #6 Korzystając ze składni ANY i operatora = wyświetl te produkty, których występują w transakcjach sprzedażowych (według klucza Products ID, Sales SAL_PRODUCT_ID) takich, że wartośc sprzedazy w transakcji jest większa od 100.

SELECT * FROM products; 				

SELECT p.* 
  FROM products p
 WHERE p.id = ANY (SELECT s.sal_product_id 
					 FROM sales s
  				    WHERE s.sal_value > 100);

-- #7 Stwórz nową tabelę PRODUCTS_OLD_WAREHOUSE o takich samych kolumnach jak istniejąca tabela produktów (tabela PRODUCTS). Wstaw do nowej tabeli kilka wierszy - dowolnych według Twojego uznania. 

DROP TABLE IF EXISTS products_old_warehouse;
 				
CREATE TABLE IF NOT EXISTS products_old_warehouse (
	id SERIAL,
	product_name VARCHAR(100),
	product_code VARCHAR(10),
	product_quantity NUMERIC(10,2),
	manufactured_date DATE,	
	added_by TEXT DEFAULT 'admin',
	created_date TIMESTAMP DEFAULT now()
);

INSERT INTO products_old_warehouse (product_name, product_code, product_quantity, manufactured_date)
     SELECT 'Product '||floor(random() * 10 + 1)::int,
            'PRD'||floor(random() * 10 + 1)::int,
            random() * 10 + 1,
            CAST((NOW() - (random() * (interval '90 days')))::timestamp AS date)
       FROM generate_series(1, 4) s(i);
  
-- #8 Na podstawie tabeli z zadnaia 7, korzystając z operacji UNION oraz UNION ALL połącz tabelę PRODUCTS_OLD_WAREHOUSE z 5 dowolnym produktami z tabeli PRODUCTS, w wyniku wyświetl jedynie nazwę produktu (kolumna PRODUCT_NAME) i kod produktu (kolumna PRODUCT_CODE). Czy w przypadku wykorzystania UNION jakieś wierszy zostały pominięte? 				

SELECT p.product_name,
	   p.product_code
  FROM products p
 UNION 
SELECT pow.product_name,
	   pow.product_code
  FROM products_old_warehouse pow;

SELECT p.product_name,
	   p.product_code
  FROM products p
 UNION ALL
SELECT pow.product_name,
	   pow.product_code
  FROM products_old_warehouse pow;
 
-- #9 Na podstawie tabeli z zadnaia 7, korzystając z operacji EXCEPT znajdź różnicę zbiorów pomiędzy tabelą PRODUCTS_OLD_WAREHOUSE a PRODUCTS, w wyniku wyświetl jedynie kod produktu (kolumna PRODUCT_CODE). 				

SELECT pow.product_code
  FROM products_old_warehouse pow
EXCEPT 
SELECT p.product_code
  FROM products p; 
  
-- #10 Wyświetl 10 rekordów z tabeli sprzedażowej sales. Dane powinny być posortowane według wartości sprzedazy (kolumn SAL_VALUE) malejąco.

   SELECT s.* 
     FROM sales s
 ORDER BY s.sal_value DESC 
    LIMIT 10;
    
-- #11 Korzystając z funkcji SUBSTRING na atrybucie SAL_DESCRIPTION, wyświetl 3 dowolne wiersze z tabeli sprzedażowej w taki sposób aby w kolumnie wynikowej dla SUBSTRING z SAL_DESCRIPTION wyświetlonych zostało tylko 3 pierwsze znaki.

SELECT SUBSTRING(s.sal_description,1,3),
  	   s.*
  FROM sales s
 LIMIT 3;
 
-- #12 Korzystając ze składni LIKE znajdź wszystkie dane sprzedażowe, których opis sprzedaży (SAL_DESCRIPTION) zaczyna się od c4c.

SELECT s.* 
  FROM sales s 
 WHERE s.sal_description LIKE 'c4c%';
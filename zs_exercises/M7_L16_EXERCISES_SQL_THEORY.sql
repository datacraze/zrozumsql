DROP TABLE IF EXISTS products, sales, product_manufactured_region CASCADE;

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

CREATE TABLE sales (
	id SERIAL,
	sal_description TEXT,
	sal_date DATE,
	sal_value NUMERIC(10,2),
	sal_prd_id INTEGER,
	added_by TEXT DEFAULT 'admin',
	created_date TIMESTAMP DEFAULT now()
);

CREATE TABLE product_manufactured_region (
	id SERIAL,
	region_name VARCHAR(25),
	region_code VARCHAR(10),
	established_year INTEGER
);

INSERT INTO product_manufactured_region (region_name, region_code, established_year)
	  VALUES ('EMEA', 'E_EMEA', 2010),
	  		 ('EMEA', 'W_EMEA', 2012),
	  		 ('APAC', NULL, 2019),
	  		 ('North America', NULL, 2012),
	  		 ('Africa', NULL, 2012);

INSERT INTO products (product_name, product_code, product_quantity, manufactured_date, product_man_region)
     SELECT 'Product '||floor(random() * 10 + 1)::int,
            'PRD'||floor(random() * 10 + 1)::int,
            random() * 10 + 1,
            CAST((NOW() - (random() * (interval '90 days')))::timestamp AS date),
            CEIL(random()*(10-5))::int
       FROM generate_series(1, 10) s(i);  
      
INSERT INTO sales (sal_description, sal_date, sal_value, sal_prd_id)
     SELECT left(md5(i::text), 15),
     		CAST((NOW() - (random() * (interval '60 days'))) AS DATE),	
     		random() * 100 + 1,
        	floor(random() * 10)+1::int            
       FROM generate_series(1, 10000) s(i);     
      
-- #1 Korzystając z konstrukcji INNER JOIN połącz dane sprzedażowe (SALES, sal_prd_id) z danymi o produktach (PRODUCTS, id). 
-- W wynikach pokaż tylko te produkty, które powstały w regionie EMEA. Wyniki ogranicz do 100 wierszy.

SELECT s.*,
       p.*,
       pmr.*
  FROM sales s
  JOIN products p ON p.id = s.sal_prd_id 
  JOIN product_manufactured_region pmr ON pmr.id = p.product_man_region
    								  AND pmr.region_name = 'EMEA'
 LIMIT 100
 ;     
      
-- #2 Korzystając z konstrukcji LEFT JOIN połącz dane o produktach (PRODUCTS,  product_man_region) z danymi o regionach w których produkty powstały (PRODUCT_MANUFACTURED_REGION, id) 
-- W wynikach wyświetl wszystkie atrybuty z tabeli produktów i atrybut REGION_NAME z tabeli PRODUCT_MANUFACTURED_REGION. Dodatkowo w trakcie złączenia ogranicz dane brane przy złączenia do tych regionów które zostały założone po 2012 roku.

     SELECT p.*,
            pmr.*
       FROM products p  
  LEFT JOIN product_manufactured_region pmr ON pmr.id = p.product_man_region
    								       AND pmr.established_year > 2012
;

-- #3 Korzystając z konstrukcji LEFT JOIN połącz dane o produktach (PRODUCTS,  product_man_region) z danymi o regionach w których produkty powstały (PRODUCT_MANUFACTURED_REGION, id) 
-- W wynikach wyświetl wszystkie atrybuty z tabeli produktów i atrybut REGION_NAME z tabeli PRODUCT_MANUFACTURED_REGION. 
-- Dodatkowo wyfiltruj dane wynikowe taki sposób aby pokazać tylko te produkty, dla których regiony w których powstały zostały założone po 2012 roku.
-- Porównaj te wyniki z wynikami z zadania 2.

     SELECT p.*,
            pmr.*
       FROM products p  
  LEFT JOIN product_manufactured_region pmr ON pmr.id = p.product_man_region
      WHERE pmr.established_year > 2012
;

-- #4 Korzystając z konstrukcji RIGHT JOIN połącz dane sprzedażowe (SALES, sal_prd_id) z podzapytaniem w których dla danych produktowych uwzględnich tylko te produkty (PRODUCTS, id), których ilość jednostek jest większa od 5 (product_quantity).
-- W wynikach wyświetl unikatową nazwę prduktu (product_name) oraz złączeniem ROK_MIESIĄC z danych sprzedażowych - data sprzedaży. 
-- Dane posortuj według pierwszej kolumny malejąco.

     SELECT DISTINCT 
     		pro.product_name,
     		EXTRACT(YEAR FROM s.sal_date)||'_'||EXTRACT(MONTH FROM s.sal_date) AS sal_year_month
       FROM sales s
 RIGHT JOIN (SELECT p.* 
               FROM products p
              WHERE p.product_quantity > 5) pro ON pro.id = s.sal_prd_id
   ORDER BY 1 DESC 
;

-- #5 Dodaj nowy region do tabeli PRODUCT_MANUFACTURED_REGION. 
-- Następnie korzystając z konstrukcji FULL JOIN połącz dane o produktach (PRODUCTS,product_man_region) z danymi o regionach produktów w których zostały one stworzone (PRODUCT_MANUFACTURED_REGION, id)
-- Wyświetl w wynikach wszystkie atrybuty z obu table.

INSERT INTO product_manufactured_region (region_name, region_code, established_year)
     VALUES ('Australia', NULL, 2020);
	  
     SELECT p.*,
            pmr.*
       FROM products p  
  FULL JOIN product_manufactured_region pmr ON pmr.id = p.product_man_region
;    

-- #6 Uzyskaj te same wyniki co w zadaniu 5 dla stworzonego zapytania, tym razem nie korzystaj ze składni FULL JOIN. Wykorzystaj INNER JOIN / LEFT / RIGHT JOIN lub inne części SQL-a które znasz :)

     SELECT p.*,
            pmr.*
       FROM products p  
       JOIN product_manufactured_region pmr ON pmr.id = p.product_man_region
      UNION 
     SELECT p.*,
            pmr.*
       FROM products p  
  LEFT JOIN product_manufactured_region pmr ON pmr.id = p.product_man_region
      WHERE pmr.id IS NULL
      UNION 
     SELECT p.*,
            pmr.*
       FROM products p  
 RIGHT JOIN product_manufactured_region pmr ON pmr.id = p.product_man_region     
      WHERE p.id IS NULL;

-- #7 Wykorzystaj konstrukcję WITH i zmień Twoje zapytanie z zadania 4 w taki sposób aby podzapytanie znalazło się w skecji CTE (common table expression = WITH) zapytania. 

WITH product_with_qty_over_5 AS (
	SELECT p.* 
      FROM products p
     WHERE p.product_quantity > 5
)
     SELECT DISTINCT 
     		pro.product_name,
     		EXTRACT(YEAR FROM s.sal_date)||'_'||EXTRACT(MONTH FROM s.sal_date) AS sal_year_month
       FROM sales s
 RIGHT JOIN product_with_qty_over_5 pro ON pro.id = s.sal_prd_id
   ORDER BY 1 DESC 
;

-- #8 JOIN + DELETE      
-- Usuń wszystkie te produkty (PRODUCTS), które są przypisane do regionu EMEA i kodu E_EMEA.
-- SKorzystaj z konstrukcji USING lub EXISTS.

DELETE FROM products p
      WHERE EXISTS (SELECT 1 
					  FROM products p1
					  JOIN product_manufactured_region pmr ON p.id = p1.id
					   									  AND pmr.id = p1.product_man_region 
					  									  AND pmr.region_code = 'E_EMEA'
					  									  AND pmr.region_name = 'EMEA'
				   )
  RETURNING *;
 

-- OPCJONALNE: #9 Korzystając z konstrukcji WITH RECURSIVE stwórz ciąg Fibonacciego którego wyniki będą ograniczone do wartości poniżej 100.
-- https://pl.wikipedia.org/wiki/Ci%C4%85g_Fibonacciego

WITH RECURSIVE fibonacci(n, m) AS (
  VALUES (0,1)
  UNION ALL
  SELECT m, n + m
    FROM fibonacci
   WHERE n + m < 100
) SELECT m FROM fibonacci;
      
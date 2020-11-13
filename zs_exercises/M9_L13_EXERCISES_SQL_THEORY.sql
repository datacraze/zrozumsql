-- 1: Przygotuj widok bazodanowy na podstawie danych sprzedażowych SALES, który będzie przedstawiał dane za ostatni kwartał roku 2020, dla wszystkich produktów biorących udział w transakcjach sprzedażowych wytworzonych w regionie EMEA.      
      
CREATE VIEW sales_q4_2020_from_emea AS       
SELECT s.*,
	   p.product_name,
	   p.product_code,
	   p.product_quantity,
	   p.manufactured_date 
  FROM sales s
  JOIN products p ON p.id  = s.sal_prd_id  
  JOIN product_manufactured_region pmr ON pmr.id = p.product_man_region 
  									  AND pmr.region_name = 'EMEA'
 WHERE EXTRACT(QUARTER FROM sal_date) = 4
   AND EXTRACT(YEAR FROM sal_date) = 2020;
   
-- 2: Zmień zapytanie z zadania pierwszego w taki sposób aby w wynikach dodatkowo, obliczyć sumę sprzedaży w podziale na kod produktu (product_code) sortowane według daty sprzedaży (sal_date), wynik wyświetl dla każdego wiersza (OVER). Tak przygotowane zapytanie wykorzystaj do stworzenia widoku zmaterializowanego, który będzie mógł być odświeżany równolegle (CONCURRENTLY).

CREATE MATERIALIZED VIEW mv_sales_q4_2020_from_emea AS  
SELECT s.*,
	   p.product_name,
	   p.product_code,
	   p.product_quantity,
	   p.manufactured_date,
	   sum(s.sal_value) over(PARTITION BY p.product_code ORDER BY s.sal_date) AS sal_value_per_product_code
  FROM sales s
  JOIN products p ON p.id  = s.sal_prd_id  
  JOIN product_manufactured_region pmr ON pmr.id = p.product_man_region 
  									  AND pmr.region_name = 'EMEA'
 WHERE EXTRACT(QUARTER FROM sal_date) = 4
   AND EXTRACT(YEAR FROM sal_date) = 2020
WITH DATA;

CREATE UNIQUE INDEX idx_unq_mv_sales_q4_2020_emea_sales_id ON mv_sales_q4_2020_from_emea (id);

REFRESH MATERIALIZED VIEW CONCURRENTLY mv_sales_q4_2020_from_emea;

-- 3. Stwórz zapytanie w którego wynikach znajdą się atrybuty: PRODUCT_CODE, REGION_NAME i tablica zawierają nazwy produktów (PRODUCT_NAME) dla wszystkich produktów z tabeli PRODUCTS.

     SELECT p.product_code,
     		pmr.region_name,
     		array_agg(p.product_name) AS products_list_for_code_and_region
       FROM products p
  LEFT JOIN product_manufactured_region pmr ON pmr.id = p.product_man_region 
   GROUP BY p.product_code, pmr.region_name;

-- 4. Dla zapytania z zdania 3 stwórz nową tabelę korzystając z konstrukcji CTAS. Dodaj dodatkowo do nowej tabeli 1 kolumnę zawierającą wartość TRUE lub FALSE obliczaną na podstawie danych z atrybutu tablicy nazw produktów dla kodu i regionu (zadanie 3) w taki sposób, że gdy tablica zawiera więcej niż 1 element wartość ma być TRUE, w przeciwnym razie FALSE.

CREATE TABLE products_regions_with_pnames_list AS
WITH products_regions_listed AS (  
     SELECT p.product_code,
     		pmr.region_name,
     		array_agg(p.product_name) AS products_list_for_code_and_region
       FROM products p
  LEFT JOIN product_manufactured_region pmr ON pmr.id = p.product_man_region 
   GROUP BY p.product_code, pmr.region_name
) SELECT prl.*,
		 CASE array_length(prl.products_list_for_code_and_region,1) > 1 
		 	WHEN TRUE THEN TRUE
		 	ELSE FALSE
 		 END multiple_products
    FROM products_regions_listed prl;

-- 5. Stwórz nową tabelę SALES_ARCHIVE, która będzie miała strukturę na podstawie tabeli SALES z wyjątkami: 
-- * nowy atrybut: operation_type VARCHAR(1) NOT NULL
-- * nowy atrybut: archived_at TIMESTAMP z automatycznym przypisywaniem wartości NOW()
-- * atrybut created_date powinien być usunięty
  
CREATE TABLE sales_archive (
	id SERIAL,
	sal_description TEXT,
	sal_date DATE,
	sal_value NUMERIC(10,2),
	sal_prd_id INTEGER,
	operation_type VARCHAR(1) NOT NULL,
	added_by TEXT DEFAULT 'admin',
	archived_at TIMESTAMP DEFAULT now()
);
     
-- 6. Dla tabeli stworzonej w zadaniu 5, utwórz TRIGGER + FUNKCJE DLA TRIGGERA, który w momencie usuwania, lub aktualizacji wierszy w tabeli SALES, wstawi informację o poprzedniej wartości do tabeli SALES_ARCHIVE. Po przypisaniu TRIGGERA, usuń z tabeli SALES wszystkie dane sprzedażowe z Października 2020 (10.2020).

DROP FUNCTION sales_archive_audit CASCADE;
CREATE FUNCTION sales_archive_audit() 
	RETURNS TRIGGER
	LANGUAGE plpgsql
	AS $$
		BEGIN	
			IF (TG_OP = 'UPDATE') THEN
				INSERT INTO sales_archive (sal_description, sal_date, sal_value, sal_prd_id, operation_type)
					 VALUES(OLD.sal_description, OLD.sal_date, OLD.sal_value, OLD.sal_prd_id, 'U');
			ELSEIF (TG_OP = 'DELETE') THEN 
				INSERT INTO sales_archive (sal_description, sal_date, sal_value, sal_prd_id, operation_type)
					 VALUES(OLD.sal_description, OLD.sal_date, OLD.sal_value, OLD.sal_prd_id, 'D');
			END IF;
 		    RETURN NULL; -- rezultat zignoruj
		END
	$$;
    
CREATE TRIGGER sales_archive_audit_trg
	AFTER UPDATE OR DELETE ON sales
		FOR EACH ROW EXECUTE PROCEDURE sales_archive_audit();
	
DELETE FROM sales
	  WHERE TO_CHAR(sal_date,'MMYYYY') = '102020';
	 
SELECT * FROM sales_archive;
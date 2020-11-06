-- 1: Oblicz średnią ilość jednostek produktów (PRODUCTS) w podziale na regiony z tabeli PRODUCT_MANUFACTURED_REGION (atrybut region_name). W wynikach wyświetl tylko nazwę regionu (REGION_NAME) i obliczoną średnią. Dane posortuj według średniej malejąco.

    SELECT pmr.region_name,
    	   AVG(p.product_quantity) AS avg_prd_qty
      FROM products p
 LEFT JOIN product_manufactured_region pmr ON pmr.id = p.product_man_region
  GROUP BY pmr.region_name
  ORDER BY avg_prd_qty DESC;
  
-- 2: Korzystając z funkcji string_agg, dla każdej nazwy regionu z tabeli PRODUCT_MANUFACTURED_REGION stwórz listę nazw produktów (product_name) w tych regionach. Sprawdź czy wewnątrz funkcji STRING_AGG możesz użyć ORDER BY i jak ewentualnie to wpłynie na wyniki?
 
     SELECT pmr.region_name,
    	    STRING_AGG(p.product_name,',' ORDER BY p.product_name ASC) products_in_regions
      FROM products p
 LEFT JOIN product_manufactured_region pmr ON pmr.id = p.product_man_region
  GROUP BY pmr.region_name;
  
-- 3: Wyświetl ilość sprzedanych produktów COUNT(s.sal_prd_id), które wzięły udział w transakcjach sprzedażowych, filtrując dane jedynie do regionu EMEA, według tabeli PRODUCT_MANUFACTURED_REGION. W  danych wynikowych powinien się znaleźć region (REGION_NAME), nazwa produktu (PRODUCT_NAME) orac całkowita liczba z danych sprzedażowych.

    SELECT pmr.region_name,
    	   p.product_name,
    	   COUNT(p.id) count_of_products_sold
      FROM sales s 
 LEFT JOIN products p ON p.id = s.sal_prd_id
 LEFT JOIN product_manufactured_region pmr ON pmr.id = p.product_man_region
     WHERE pmr.region_name = 'EMEA'
  GROUP BY pmr.region_name, p.product_name;
  
-- 4: Wyświetl sumę sprzedaży na podstawie danych sprzedażowych (SALES) w podziale na nowy atrybut ROK_MIESIAC stworzony na podstawie kolumny SAL_DATE. Dane wynikowe posortuj od największej do najmniejszej sprzedaży.
 
	SELECT EXTRACT(YEAR FROM s.sal_date)||'_'||EXTRACT(MONTH FROM s.sal_date) year_month_of_sales,
		   SUM(s.sal_value) sum_of_sales
	  FROM sales s
  GROUP BY year_month_of_sales
  ORDER BY sum_of_sales DESC;

-- 5: Korzystając z konstrukcji GROUPING SETS oblicz średnią ilość jednostek produktow w grupach - kod produktu (PRODUCT_CODE), rok produkcji (na podstawie atrybutu MANUFACTURED_DATE) oraz regionu produkcji (REGION_NAME z tabeli PRODUCT_MANUFACTURED_REGION). Do danych wynikowych dołóż kolumnę z grupą rekordów korzystając ze składni GROUPING. 

     SELECT p.product_code, 
            EXTRACT(YEAR FROM p.manufactured_date) AS year_of_manufactured, 
            pmr.region_name,
            GROUPING(p.product_code, 
			         EXTRACT(YEAR FROM p.manufactured_date), 
		             pmr.region_name) AS groups_for_grouping,
    	    AVG(p.product_quantity) AS avg_prd_qty
       FROM products p
  LEFT JOIN product_manufactured_region pmr ON pmr.id = p.product_man_region
   GROUP BY GROUPING SETS (p.product_code,
   						   year_of_manufactured,
   						   pmr.region_name)
   ORDER BY groups_for_grouping;
 
-- 6: Dla każdego PRODUCT_NAME oblicz sumę ilości jednostek w podziale na region_name z tabeli PRODUCT_MANUFACTURED_REGION. Skorzystaj z funkcji okna.
-- W wynikach wyświetl: PRODUCT_NAME, PRODUCT_CODE, MANUFACTURED_DATE, PRODUCT_MAN_REGION, REGION_NAME i obliczoną sumę.

    SELECT p.product_name,
    	   p.product_code,
    	   p.manufactured_date,
    	   p.product_man_region,
    	   pmr.region_name,
    	   sum(p.product_quantity) OVER (PARTITION BY pmr.region_name)
      FROM products p
 LEFT JOIN product_manufactured_region pmr ON pmr.id = p.product_man_region; 

-- 7: Na podstawie zapytania i wyników z zadania 6. Stwórz ranking według posiadanej ilości produktów od największej do najmniejszej, w taki sposób aby w rankingu nie było brakujących elementów (liczb). W wyniku wyświetl te produkty, których ilość jest 2 największą ilością. Atrybuty do wyświetlenia, PRODUCT_NAME, REGION_NAME, suma ilości per region (obliczona w zadaniu 6).
WITH prd_qty_per_region AS (
		SELECT p.product_name,
	    	   p.product_code,
	    	   p.manufactured_date,
	    	   p.product_man_region,
	    	   pmr.region_name,
	    	   sum(p.product_quantity) OVER (PARTITION BY pmr.region_name) AS sum_qty_per_region
	      FROM products p
	 LEFT JOIN product_manufactured_region pmr ON pmr.id = p.product_man_region
), product_qty_ranking AS (
  SELECT product_name,
		 region_name,
		 sum_qty_per_region,
		 DENSE_RANK() OVER (ORDER BY sum_qty_per_region DESC) prd_rank
    FROM prd_qty_per_region
) SELECT product_name,
		 region_name,
		 sum_qty_per_region
    FROM product_qty_ranking
   WHERE prd_rank = 2;
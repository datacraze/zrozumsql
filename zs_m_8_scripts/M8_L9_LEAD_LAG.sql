DROP TABLE IF EXISTS sales;

CREATE TABLE sales (
	id SERIAL,
	sal_description TEXT,
	sal_date DATE,
	sal_value NUMERIC(10,2),
	sal_discount NUMERIC (10,2),
	added_by TEXT DEFAULT 'admin',
	created_date TIMESTAMP DEFAULT now()
);

INSERT INTO sales (sal_description, sal_date, sal_value, sal_discount)
  	 VALUES ('201901_sale', '12/12/2019', 1000, 90),
  	  	    ('201902_sale', '24/06/2019', 10000, 190),
      	    ('201801_sale', '05/04/2018', 5630, 102),
      	    ('202001_sale', '07/04/2020', 7230, 0);

-- PREVIOUS YEAR SALES       
WITH yearly_sales AS (
  SELECT EXTRACT(YEAR FROM sal_date) year_sal,
	     sum(sal_value) total_sales
    FROM sales
GROUP BY 1  
) SELECT ys.*,
		 (SELECT total_sales FROM yearly_sales ys2 WHERE ys2.year_sal < ys.year_sal LIMIT 1) AS previous_year_sales
    FROM yearly_sales ys
ORDER BY 1  
;

WITH yearly_sales AS (
  SELECT EXTRACT(YEAR FROM sal_date) year_sal,
	     sum(sal_value) total_sales
    FROM sales
GROUP BY 1  
)  SELECT ys.*,
		  ys2.total_sales
     FROM yearly_sales ys
LEFT JOIN (SELECT total_sales, year_sal FROM yearly_sales) ys2 ON ys2.year_sal < ys.year_sal
ORDER BY 1
;
 -- ups ... 

WITH yearly_sales AS (
  SELECT EXTRACT(YEAR FROM sal_date) year_sal,
	     sum(sal_value) total_sales
    FROM sales
GROUP BY 1  
)  SELECT ys.*,
		  ys2.year_sal,
		  ys2.total_sales
     FROM yearly_sales ys
LEFT JOIN (SELECT total_sales, year_sal FROM yearly_sales) ys2 ON ys2.year_sal < ys.year_sal
ORDER BY 1
;
-- :(

WITH yearly_sales AS (
  SELECT EXTRACT(YEAR FROM sal_date) year_sal,
	     sum(sal_value) total_sales
    FROM sales
GROUP BY 1  
) SELECT *,
		 lag(total_sales) OVER (ORDER BY year_sal) AS previous_year_sales
    FROM yearly_sales 
ORDER BY 1;
    


-- NEXT YEAR    
WITH yearly_sales AS (
  SELECT EXTRACT(YEAR FROM sal_date) year_sal,
	     sum(sal_value) total_sales
    FROM sales
GROUP BY 1  
) SELECT ys.*,
		 (SELECT total_sales FROM yearly_sales ys2 WHERE ys2.year_sal > ys.year_sal LIMIT 1) AS previous_year_sales
    FROM yearly_sales ys
ORDER BY 1  
;

WITH yearly_sales AS (
  SELECT EXTRACT(YEAR FROM sal_date) year_sal,
	     sum(sal_value) total_sales
    FROM sales
GROUP BY 1  
)  SELECT ys.*,
		  ys2.total_sales
     FROM yearly_sales ys
LEFT JOIN (SELECT total_sales, year_sal FROM yearly_sales) ys2 ON ys2.year_sal > ys.year_sal
ORDER BY 1
;
 -- ups ... 

WITH yearly_sales AS (
  SELECT EXTRACT(YEAR FROM sal_date) year_sal,
	     sum(sal_value) total_sales
    FROM sales
GROUP BY 1  
)  SELECT ys.*,
		  ys2.year_sal,
		  ys2.total_sales
     FROM yearly_sales ys
LEFT JOIN (SELECT total_sales, year_sal FROM yearly_sales) ys2 ON ys2.year_sal > ys.year_sal
ORDER BY 1
;
-- :(

WITH yearly_sales AS (
  SELECT EXTRACT(YEAR FROM sal_date) year_sal,
	     sum(sal_value) total_sales
    FROM sales
GROUP BY 1  
) SELECT *,
		 lead(total_sales) OVER (ORDER BY year_sal) AS previous_year_sales
    FROM yearly_sales 
ORDER BY 1;


-- BALANCE? SALES YEAR OVER YEAR

WITH yearly_sales AS (
  SELECT EXTRACT(YEAR FROM sal_date) year_sal,
	     sum(sal_value) total_sales
    FROM sales
GROUP BY 1  
), sales_yoy AS (
  SELECT *,
		 lag(total_sales) OVER (ORDER BY year_sal) AS previous_year_sales
    FROM yearly_sales 
) SELECT year_sal,
		 total_sales,
		 previous_year_sales,
		 previous_year_sales-total_sales AS yoy
    FROM sales_yoy;
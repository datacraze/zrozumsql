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
      	    
   SELECT * 
     FROM sales 
 ORDER BY sal_date;
 
-- PIERWSZ / OSTATNI W GRUPIE

SELECT sal_description,
       sal_date, 
       sal_value,
       first_value(EXTRACT(YEAR FROM sal_date)) 
       		OVER (ORDER BY sal_date ASC),
	   last_value(EXTRACT(YEAR FROM sal_date)) 
       		OVER (ORDER BY sal_date ASC),       		
       last_value(EXTRACT(YEAR FROM sal_date)) 
       		OVER (ORDER BY sal_date ASC RANGE BETWEEN 
            								UNBOUNDED PRECEDING AND 
            								UNBOUNDED FOLLOWING)
  FROM sales;

-- Z DOKUMENTACJI: 
-- Note that first_value, last_value, and nth_value consider only the rows within the “window frame”, 
-- which by default contains the rows from the start of the partition through the last peer of the current row.
-- This is likely to give unhelpful results for last_value and sometimes also nth_value. 
-- You can redefine the frame by adding a suitable frame specification (RANGE, ROWS or GROUPS) to the OVER clause

-- ILE DNI PO ZAKUPIE
   SELECT *,
		  FIRST_VALUE(sal_date) OVER (ORDER BY sal_date RANGE BETWEEN 
            												UNBOUNDED PRECEDING AND 
            												UNBOUNDED FOLLOWING),
   		  sal_date - FIRST_VALUE(sal_date) OVER (ORDER BY sal_date) AS days_after_first_purchase   		  									
     FROM sales 
 ORDER BY sal_date;

   SELECT *,
		  FIRST_VALUE(sal_date) OVER (ORDER BY sal_date),
   		  sal_date - FIRST_VALUE(sal_date) OVER (ORDER BY sal_date) AS days_after_first_purchase   		  									
     FROM sales 
 ORDER BY sal_date;

   SELECT *,
		  LAST_VALUE(sal_date) OVER (ORDER BY sal_date RANGE BETWEEN 
            												UNBOUNDED PRECEDING AND 
            												UNBOUNDED FOLLOWING),
   		  LAST_VALUE(sal_date) OVER (ORDER BY sal_date RANGE BETWEEN 
            												UNBOUNDED PRECEDING AND 
            												UNBOUNDED FOLLOWING)
            												- sal_date AS days_since_recent_purchase   		  									
     FROM sales ;

   SELECT *,
   		  FIRST_VALUE(sal_date) OVER (ORDER BY sal_date 
   		  								GROUPS BETWEEN CURRENT ROW AND 1 FOLLOWING 
   		  									EXCLUDE CURRENT ROW),
          FIRST_VALUE(sal_date) OVER (ORDER BY sal_date 
   		  								GROUPS BETWEEN CURRENT ROW AND 1 FOLLOWING 
   		  									EXCLUDE CURRENT ROW) - sal_date AS next_purchase_after_this_date 		  									
     FROM sales 
 ORDER BY sal_date;

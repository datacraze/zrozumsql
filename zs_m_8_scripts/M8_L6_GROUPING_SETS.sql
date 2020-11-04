DROP TABLE IF EXISTS products, sales;

CREATE TABLE products (
	id SERIAL,
	product_name VARCHAR(100),
	product_code VARCHAR(10),
	product_quantity NUMERIC(10,2),
	manufactured_date DATE,	
	added_by TEXT DEFAULT 'admin',
	created_date TIMESTAMP DEFAULT now()
);

CREATE TABLE sales (
	id SERIAL,
	sal_description TEXT,
	sal_date DATE,
	sal_value NUMERIC(10,2),
	sal_discount NUMERIC (10,2),
	added_by TEXT DEFAULT 'admin',
	created_date TIMESTAMP DEFAULT now()
);

INSERT INTO products (product_name, product_code, product_quantity, manufactured_date)
 	 VALUES ('Product 1', 'PRD1', 100.25, '20/11/2019'),
 	 		('Product 1', 'PRD2', 92.25, '1/11/2019'),
 	 		('Product 2', 'PRD2', 12.25, '1/11/2019'),
 	 		('Product 3', 'PRD3', 25.25, '2/11/2019'),
 	 		('Product 4', 'PRD4', 68.25, '3/11/2020'),
 	 		('Product 4', 'PRD4', 68.25, NULL),
            (NULL, 'PRD5', NULL, NULL)
;

INSERT INTO sales (sal_description, sal_date, sal_value, sal_discount)
  	 VALUES ('201901_sale', '12/12/2019', 1000, 90),
  	  	    ('201902_sale', '24/06/2019', 10000, 190),
      	    ('201801_sale', '05/04/2018', 5630, 102),
      	    ('202001_sale', '07/04/2020', 7230, 0);
      	    
-- GROUP BY 
  SELECT COALESCE(EXTRACT(YEAR FROM manufactured_date),2010) manufactured_year, 
         product_code,
         avg(product_quantity)
    FROM products
GROUP BY 1,2;

-- GROUPING SETS 
  SELECT COALESCE(EXTRACT(YEAR FROM manufactured_date),2010) manufactured_year, 
         product_code,
         avg(product_quantity)
    FROM products 
GROUP BY GROUPING SETS ((COALESCE(EXTRACT(YEAR FROM manufactured_date),2010)),
						(product_code),
					    ());

-- GROUPING SETS + GROUPING 					   
  SELECT COALESCE(EXTRACT(YEAR FROM manufactured_date),2010) manufactured_year, 
         product_code,
         GROUPING(COALESCE(EXTRACT(YEAR FROM manufactured_date),2010),
         		  product_code),
         avg(product_quantity)
    FROM products 
GROUP BY GROUPING SETS ((COALESCE(EXTRACT(YEAR FROM manufactured_date),2010)),
						(product_code),
					    ());					   


-- ROLLUP -  OD SZCZEGOLU DO OGOLU					   
  SELECT COALESCE(EXTRACT(YEAR FROM manufactured_date),2010) manufactured_year, 
         product_code,
         GROUPING(COALESCE(EXTRACT(YEAR FROM manufactured_date),2010),
         		  product_code),
         avg(product_quantity)
    FROM products 
GROUP BY ROLLUP ((COALESCE(EXTRACT(YEAR FROM manufactured_date),2010)),
				 (product_code));					   
    
-- ROLLUP - ODWROTNIE 			
  SELECT COALESCE(EXTRACT(YEAR FROM manufactured_date),2010) manufactured_year, 
         product_code,
         GROUPING(COALESCE(EXTRACT(YEAR FROM manufactured_date),2010),
         		  product_code),
         avg(product_quantity)
    FROM products 
GROUP BY ROLLUP ((product_code),
                 (COALESCE(EXTRACT(YEAR FROM manufactured_date),2010))
				 );					

-- CUBE			
  SELECT COALESCE(EXTRACT(YEAR FROM manufactured_date),2010) manufactured_year, 
         product_code,
         GROUPING(COALESCE(EXTRACT(YEAR FROM manufactured_date),2010),
         		  product_code),
         avg(product_quantity)
    FROM products 
GROUP BY CUBE ((COALESCE(EXTRACT(YEAR FROM manufactured_date),2010)),
				 (product_code));					
					
-- GROUPING SETS = CUBE				
  SELECT COALESCE(EXTRACT(YEAR FROM manufactured_date),2010) manufactured_year, 
         product_code,
         GROUPING(COALESCE(EXTRACT(YEAR FROM manufactured_date),2010),
         		  product_code),
         avg(product_quantity)
    FROM products 
GROUP BY GROUPING SETS ((COALESCE(EXTRACT(YEAR FROM manufactured_date),2010)),
						(product_code),
						((COALESCE(EXTRACT(YEAR FROM manufactured_date),2010)),
						 (product_code)),
					    ());	
    	 		  
-- UPORZADKUJMY					       	 		 
WITH prepared_products AS (
 SELECT product_code,
        COALESCE(EXTRACT(YEAR FROM manufactured_date),2010) manufactured_year,
        product_quantity
   FROM products        
) SELECT manufactured_year,
	     product_code,
	     avg(product_quantity)
    FROM prepared_products
GROUP BY GROUPING SETS (1,2,(1,2),()); 
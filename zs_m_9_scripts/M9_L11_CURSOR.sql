DROP TABLE IF EXISTS products CASCADE;

CREATE TABLE products (
	id SERIAL,
	product_name VARCHAR(100),
	product_code VARCHAR(10),
	product_quantity NUMERIC(10,2),
	manufactured_date DATE
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

DROP FUNCTION product_name_codes_list_cur;
CREATE OR REPLACE FUNCTION product_name_codes_list_cur(manufactured_year integer) 
   RETURNS TEXT 
   LANGUAGE plpgsql
   AS $$
   	DECLARE product_names_code_list TEXT DEFAULT '';
   			prd RECORD;
   			cur_prds CURSOR(manufactured_year integer) FOR SELECT * 
    														FROM products 
     													   WHERE EXTRACT(YEAR FROM manufactured_date) = manufactured_year;   			
		BEGIN
			OPEN cur_prds(manufactured_year);
		
			LOOP 
				FETCH cur_prds INTO prd;
			
				EXIT WHEN NOT FOUND;
			
				product_names_code_list := product_names_code_list || CONCAT(prd.product_name,'_',prd.product_code,',');
			
			END LOOP;
		
			CLOSE cur_prds;
		
			RETURN product_names_code_list;
		END;
	$$;

SELECT product_name_codes_list_cur(2019);
SELECT product_name_codes_list_cur(2020);

SELECT * FROM products;

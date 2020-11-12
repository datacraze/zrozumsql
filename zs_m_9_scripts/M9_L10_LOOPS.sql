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

-- PROCEDURA
DROP FUNCTION przyklad_petli;
CREATE FUNCTION przyklad_petli() 
   RETURNS integer 
   LANGUAGE plpgsql
   AS $$
   	DECLARE loop_pointer integer := 1;   			
		BEGIN
			LOOP
				IF loop_pointer > 10 THEN
					EXIT;		
				END IF;
				loop_pointer := loop_pointer + 1;				
			END LOOP;
			RETURN loop_pointer;
		END;
	$$;

SELECT przyklad_petli();
		
DROP FUNCTION przyklad_petli2;
CREATE FUNCTION przyklad_petli2() 
   RETURNS integer 
   LANGUAGE plpgsql
   AS $$
   	DECLARE loop_pointer integer := 1;   			
		BEGIN
			WHILE loop_pointer < 11 LOOP
				loop_pointer := loop_pointer + 1;				
			END LOOP;
			RETURN loop_pointer;
		END;
	$$;
		
SELECT przyklad_petli2();

DROP FUNCTION przyklad_petli3;
CREATE FUNCTION przyklad_petli3() 
   RETURNS integer 
   LANGUAGE plpgsql
   AS $$
   	DECLARE loop_pointer integer := 0;   			
		BEGIN
			FOR i IN 1..10 LOOP
				loop_pointer := loop_pointer + i;				
			END LOOP;
			RETURN loop_pointer;
		END;
	$$;

SELECT przyklad_petli3();

DROP FUNCTION przyklad_petli4;
CREATE OR REPLACE FUNCTION przyklad_petli4() 
   RETURNS numeric 
   LANGUAGE plpgsql
   AS $$
   	DECLARE product RECORD;
   			sum_of_quantity NUMERIC(10,2) := 0;
		BEGIN
			FOR product IN SELECT * FROM products LOOP
				sum_of_quantity := sum_of_quantity + product.product_quantity;
   			    --sum_of_quantity := sum_of_quantity + COALESCE(product.product_quantity,0);
			END LOOP;
			RETURN sum_of_quantity;
		END;
	$$;

SELECT przyklad_petli4();


DROP FUNCTION przyklad_petli5;
CREATE OR REPLACE FUNCTION przyklad_petli5() 
   RETURNS TEXT 
   LANGUAGE plpgsql
   AS $$
   	DECLARE prd_name TEXT;
   			array_to_text TEXT;
		BEGIN
			FOREACH prd_name IN ARRAY (SELECT grouped_name 
			                             FROM (SELECT EXTRACT(YEAR FROM manufactured_date) AS year_manufactured, 
											     product_code, 
											     array_agg(product_name) AS grouped_name
										    FROM products
										   WHERE EXTRACT(YEAR FROM manufactured_date) = 2019
										     AND product_code = 'PRD2'
										GROUP BY year_manufactured, product_code) sq)
			LOOP
				array_to_text = prd_name || ' _ ' || array_to_text;
				--array_to_text = CONCAT(prd_name,' _ ',array_to_text);
			END LOOP;
			RETURN array_to_text;
		END;
	$$;

SELECT przyklad_petli5();
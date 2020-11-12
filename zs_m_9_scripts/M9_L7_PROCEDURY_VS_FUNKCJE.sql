DROP TABLE IF EXISTS products CASCADE;

CREATE TABLE products (
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

	CREATE PROCEDURE remove_all_unset_product_names()
	LANGUAGE sql
	AS $$
		BEGIN
			DELETE FROM products WHERE product_name IS NULL;			
		END
	$$;
	
	CREATE PROCEDURE remove_all_unset_product_names()
	LANGUAGE sql
	AS $$
		DELETE FROM products WHERE product_name IS NULL;			
	$$;

	SELECT * FROM products;
	CALL remove_all_unset_product_names();
	
-- FUNKCJA

CREATE FUNCTION count_of_products_for_year(y integer)  
	RETURNS integer
	LANGUAGE sql
	AS $$	
		DECLARE count_p integer;
		BEGIN
			SELECT count(*) INTO count_p
			  FROM products 
			 WHERE EXTRACT(YEAR FROM manufactured_date) = y;

			RETURN count_p;
		END
	$$;
	
CREATE FUNCTION count_of_products_for_year(y integer)  
	RETURNS integer
	LANGUAGE plpgsql
	AS $$	
		DECLARE count_p integer;
		BEGIN
			SELECT count(*) INTO count_p
			  FROM products 
			 WHERE EXTRACT(YEAR FROM manufactured_date) = y;

			RETURN count_p;
		END
	$$;
	
SELECT *,
	   count_of_products_for_year(2019)
  FROM products;
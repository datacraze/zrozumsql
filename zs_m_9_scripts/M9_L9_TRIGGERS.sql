DROP TABLE IF EXISTS products, products_audit CASCADE;

CREATE TABLE products (
	id SERIAL,
	product_name VARCHAR(100),
	product_code VARCHAR(10),
	product_quantity NUMERIC(10,2),
	manufactured_date DATE
);

CREATE TABLE products_audit (
	id SERIAL,
	product_name VARCHAR(100),
	product_code VARCHAR(10),
	product_quantity NUMERIC(10,2),
	manufactured_date DATE,
	operation_type TEXT,
	archived_at TIMESTAMP DEFAULT now()
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

CREATE FUNCTION products_audit_function() 
   RETURNS TRIGGER 
   LANGUAGE plpgsql
	AS $$
		BEGIN
	        IF (TG_OP = 'DELETE') THEN
	            INSERT INTO products_audit (operation_type, product_name, product_code, product_quantity, manufactured_date)
	                 VALUES ('D', OLD.product_name, OLD.product_code, OLD.product_quantity, OLD.manufactured_date);
	        ELSIF (TG_OP = 'UPDATE') THEN
	            INSERT INTO products_audit (operation_type, product_name, product_code, product_quantity, manufactured_date)
	                 VALUES ('U', OLD.product_name, OLD.product_code, OLD.product_quantity, OLD.manufactured_date);
	        ELSIF (TG_OP = 'INSERT') THEN
	            INSERT INTO products_audit (operation_type, product_name, product_code, product_quantity, manufactured_date)
	                 VALUES ('I', OLD.product_name, OLD.product_code, OLD.product_quantity, OLD.manufactured_date);
	        END IF;
	        RETURN NULL; -- rezultat zignoruj
		END;
	$$;
		
CREATE TRIGGER products_audit_trigger 
	AFTER INSERT OR UPDATE OR DELETE
   	ON products
	FOR EACH ROW 
    EXECUTE PROCEDURE products_audit_function();
   
SELECT * FROM products;

SELECT * FROM products_audit;

DELETE FROM products WHERE product_name IS NULL RETURNING *;

UPDATE products 
   SET manufactured_date = now() 
 WHERE manufactured_date IS NULL 
 RETURNING *;

-- WHAT AFTER TABLE DELETE? 
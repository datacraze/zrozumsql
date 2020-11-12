DROP TABLE IF EXISTS products;

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

-- CREATE VIEW
CREATE MATERIALIZED VIEW products_manufactured_in_2019 AS
	SELECT product_name,
		   product_code,
		   product_quantity,
		   manufactured_date,
		   EXTRACT(YEAR FROM manufactured_date)
      FROM products 
     WHERE EXTRACT(YEAR FROM manufactured_date) = 2019
  WITH NO DATA;

-- SELECT
SELECT * FROM products_manufactured_in_2019;

-- REFRESH CONCURRENTLY
REFRESH MATERIALIZED VIEW CONCURRENTLY products_manufactured_in_2019;

-- REFRESH
REFRESH MATERIALIZED VIEW products_manufactured_in_2019;

-- REFRESH CONCURRENTLY
REFRESH MATERIALIZED VIEW CONCURRENTLY products_manufactured_in_2019;

-- INDEX - PO CZYM?

-- DROP VIEW
DROP MATERIALIZED VIEW products_manufactured_in_2019;

-- CREATE
CREATE MATERIALIZED VIEW products_manufactured_in_2019 AS
	SELECT ROW_NUMBER() OVER (ORDER BY manufactured_date, product_code, product_name) AS id,
		   product_name,
		   product_code,
		   product_quantity,
		   manufactured_date,
		   EXTRACT(YEAR FROM manufactured_date)
      FROM products 
     WHERE EXTRACT(YEAR FROM manufactured_date) = 2019
  WITH DATA;

CREATE UNIQUE INDEX products_unq_idx_mv_id ON products_manufactured_in_2019 (id);

REFRESH MATERIALIZED VIEW CONCURRENTLY products_manufactured_in_2019;

-- RENAME
ALTER MATERIALIZED VIEW products_manufactured_in_2019 
	RENAME TO mv_products_manufactured_in_2019;

SELECT * FROM products_manufactured_in_2019;

SELECT * FROM mv_products_manufactured_in_2019;
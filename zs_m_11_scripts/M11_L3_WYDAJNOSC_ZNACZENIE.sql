DROP TABLE IF EXISTS products CASCADE;

CREATE TABLE products (
	id SERIAL,
	product_name VARCHAR(100),
	product_code VARCHAR(10),
	product_quantity NUMERIC(10,2),	
	manufactured_date DATE,
	added_by TEXT DEFAULT 'admin',
	created_date TIMESTAMP DEFAULT now()
);

INSERT INTO products (product_name, product_code, product_quantity, manufactured_date)
     SELECT 'Product '||floor(random() * 10000 + 1)::int,
            'PRD'||floor(random() * 10 + 1)::int,
            random() * 10 + 1,
            CAST((NOW() - (random() * (interval '90 days')))::timestamp AS date)
       FROM generate_series(1, 1000000) s(i);  

EXPLAIN ANALYZE      
SELECT * 
  FROM products p
 WHERE product_code = 'PRD4';

DISCARD ALL;

CREATE INDEX idx_products_prd_code ON products USING BTREE(product_code);

EXPLAIN ANALYZE      
SELECT * 
  FROM products p
 WHERE product_code = 'PRD4';

-- 154 ms vs 27 ms
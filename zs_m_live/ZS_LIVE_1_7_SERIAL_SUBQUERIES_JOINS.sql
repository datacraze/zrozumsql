-- AUTOINCREMENT
DROP TABLE IF EXISTS products;
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
     SELECT 'Product '||floor(random() * 10 + 1)::int,
            'PRD'||floor(random() * 10 + 1)::int,
            random() * 10 + 1,
            CAST((NOW() - (random() * (interval '90 days')))::timestamp AS date)
       FROM generate_series(1, 10) s(i);  

SELECT * FROM products;      

SELECT last_value FROM public.products_id_seq;

INSERT INTO products (id, product_name, product_code, product_quantity, manufactured_date)
     VALUES (11, 'Product 11', 'PRD11', random() * 10 + 1, CAST((NOW() - (random() * (interval '90 days')))::timestamp AS date)),
     		(12, 'Product 12', 'PRD12', random() * 10 + 1, CAST((NOW() - (random() * (interval '90 days')))::timestamp AS date)),
     		(13, 'Product 13', 'PRD13', random() * 10 + 1, CAST((NOW() - (random() * (interval '90 days')))::timestamp AS date));
     
SELECT * FROM products;
SELECT last_value FROM public.products_id_seq;

INSERT INTO products (product_name, product_code, product_quantity, manufactured_date)
     VALUES ('Product '||floor(random() * 10 + 1)::int, 'PRD'||floor(random() * 10 + 1)::int, random() * 10 + 1, CAST((NOW() - (random() * (interval '90 days')))::timestamp AS date));
 
SELECT * FROM products;
SELECT last_value FROM public.products_id_seq;

DELETE FROM products WHERE id = 11;
ALTER TABLE products ADD CONSTRAINT pk_products_id PRIMARY KEY (id);

SELECT * FROM products;
SELECT last_value FROM public.products_id_seq;

INSERT INTO products (product_name, product_code, product_quantity, manufactured_date)
     VALUES ('Product '||floor(random() * 10 + 1)::int, 'PRD'||floor(random() * 10 + 1)::int, random() * 10 + 1, CAST((NOW() - (random() * (interval '90 days')))::timestamp AS date));
 
    
-- PODZAPYTANIA   
SELECT * 
  FROM products;
  
SELECT *, 
  	   (SELECT SUBSTRING(product_name,1,3) FROM products LIMIT 1) AS sub_prd_name
  FROM products;
 
SELECT *, 
  	   (SELECT SUBSTRING(product_name,1,3) FROM products) AS sub_prd_name
  FROM products;

 -- AUTOCOMIT ...
--DELETE FROM products WHERE id <> 1 ;

SELECT *, 
  	   (SELECT SUBSTRING(product_name,1,3), product_code FROM products LIMIT 1 ) AS sub_prd_name
  FROM products;
 
SELECT *, 
  	   (SELECT SUBSTRING(product_name,1,3)||product_code FROM products LIMIT 1 ) AS sub_prd_name
  FROM products;
 
SELECT *  	   
  FROM (SELECT SUBSTRING(product_name,1,3)||product_code 
          FROM products 
         LIMIT 1 ) sq
 
SELECT *  	   
  FROM (SELECT SUBSTRING(product_name,1,3), product_code 
          FROM products 
         ) sq  
         
SELECT product_code,
	   count(*)
  FROM products
 WHERE product_name = (SELECT product_name FROM products)
GROUP BY product_code;
      
SELECT product_code,
	   count(*)
  FROM products
 WHERE product_name = (SELECT product_name FROM products LIMIT 1)
GROUP BY product_code;

SELECT product_code,
	   count(*)
  FROM products
GROUP BY product_code, (SELECT product_name FROM products LIMIT 1);

SELECT product_code,
	   count(*)
  FROM products
GROUP BY product_code, (SELECT product_name FROM products);

SELECT product_code,
	   count(*)
  FROM products
GROUP BY product_code, (SELECT product_name, product_code FROM products LIMIT 1);

SELECT product_code,
	   count(*)
  FROM products
GROUP BY product_code, (SELECT product_name||product_code FROM products LIMIT 1);


-- JOINY W PROJEKCIE

SELECT t.id_transaction ,
	   tc.category_name,
       ts.subcategory_name,
       tt.transaction_type_name,
       t.transaction_date,
       t.transaction_value 
  FROM expense_tracker.transactions t 
  JOIN expense_tracker.transaction_type tt ON tt.id_trans_type = t.id_trans_type 
  JOIN expense_tracker.transaction_bank_accounts tba ON tba.id_trans_ba = t.id_trans_ba 
  JOIN expense_tracker.bank_account_owner bao ON bao.id_ba_own = tba.id_ba_own
  											 AND bao.owner_name = 'Janusz i Grażynka'
  JOIN expense_tracker.bank_account_types bat ON bat.id_ba_type = tba.id_ba_typ 
                                             AND bat.id_ba_own = bao.id_ba_own 
                                             AND bat.ba_type = 'OSZCZ - WSPÓLNY'                                             
  JOIN expense_tracker.transaction_category tc ON tc.id_trans_cat = t.id_trans_cat 
  JOIN expense_tracker.transaction_subcategory ts ON ts.id_trans_cat = tc.id_trans_cat 
                                                 AND ts.id_trans_subcat = t.id_trans_subcat
 WHERE EXTRACT(YEAR FROM t.transaction_date) = 2020
   AND t.id_transaction = 7115;
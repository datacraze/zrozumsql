--- DDL

CREATE TABLE sales (
    id SERIAL,
    sales_date TIMESTAMP,
    sales_amount NUMERIC(38,2)
);

DROP TABLE sales;

CREATE TABLE IF NOT EXISTS sales (
    id SERIAL,
    sales_date TIMESTAMP,
    sales_amount NUMERIC(38,2),
    sales_qty INTEGER,
    discount NUMERIC(38,2)
);

ALTER TABLE sales ADD COLUMN product_id varchar(100);

CREATE TABLE products (
	product_id varchar(100),
	product_name varchar(500),
	product_category varchar(250)
);

--- DML

-- INSERT 
INSERT INTO products (product_id, product_name, product_category) VALUES ('101', 'Product 1', 'Category 1');
INSERT INTO products (product_id, product_name, product_category) VALUES ('102', 'Product 1', 'Category 2');
INSERT INTO products (product_id, product_name, product_category) VALUES ('103', 'Product 1', 'Category 3');
INSERT INTO products (product_id, product_name, product_category) VALUES ('104', 'Product 2', 'Category 1');
INSERT INTO products (product_id, product_name, product_category) VALUES ('105', 'Product 3', 'Category 2');
INSERT INTO products (product_id, product_name, product_category) VALUES ('999', 'Product 999', 'Category 999');

-- UPDATE
UPDATE products SET product_name = 'Product 4';

-- Ups? 

-- DELETE 
DELETE FROM products;

-- INSERT AGAIN

UPDATE products SET product_name = 'Product 4' WHERE product_name = 'Product 3';

ALTER TABLE products ADD COLUMN random_desc TEXT;

-- ADD SOME DATA
TRUNCATE TABLE products RESTART IDENTITY CASCADE;
ALTER TABLE products ADD COLUMN random_desc TEXT;

DROP SEQUENCE IF EXISTS products_insert;
CREATE TEMP SEQUENCE products_insert MINVALUE 0 START WITH 0;

INSERT INTO products (product_id, product_name, product_category, random_desc)
select nextval('products_insert')::TEXT,
        'Product '||floor(random() * 10 + 1)::int,
        'Category '||floor(random() * 10 + 1)::int,
        left(md5(i::text), 15)
   from generate_series(1, 100) s(i);
   
TRUNCATE TABLE sales RESTART IDENTITY CASCADE;

INSERT INTO sales (sales_date, sales_amount, sales_qty, product_id)
 select NOW() + (random() * (interval '90 days')) + '30 days',
        random() * 10 + 1,
        floor(random() * 10 + 1)::int,
        floor(random() * 100)::int
   from generate_series(1, 10000) s(i);


-- SELECT
SELECT * 
FROM sales;   

-- alias?
select product_id as "Product ID", 
       sales_qty as "Sales Quantity" 
from sales;

-- WHERE
select *
from sales 
where sales_amount >5;

-- GROUP BY 
select sum(sales_amount)
from sales ;

select product_id, sum(sales_amount)
from sales
GROUP BY product_id;

-- HAVING
select extract(year from sales_date)||''||extract(month from sales_date), sum(sales_amount)
from sales 
group by extract(year from sales_date)||''||extract(month from sales_date)
having sum(sales_amount) > 10000;


CREATE TABLE basket_a (
    id INT PRIMARY KEY,
    fruit VARCHAR (100) NOT NULL
);
 
CREATE TABLE basket_b (
    id INT PRIMARY KEY,
    fruit VARCHAR (100) NOT NULL
);
 
INSERT INTO basket_a (id, fruit)
VALUES
    (1, 'Apple'),
    (2, 'Orange'),
    (3, 'Banana'),
    (4, 'Cucumber');
 
INSERT INTO basket_b (id, fruit)
VALUES
    (1, 'Orange'),
    (2, 'Apple'),
    (3, 'Watermelon'),
    (4, 'Pear');


-- INNER JOIN
SELECT
    a.id id_a,
    a.fruit fruit_a,
    b.id id_b,
    b.fruit fruit_b
FROM
    basket_a a
INNER JOIN basket_b b ON a.fruit = b.fruit;

-- LEFT JOIN
SELECT
    a.id id_a,
    a.fruit fruit_a,
    b.id id_b,
    b.fruit fruit_b
FROM
    basket_a a
LEFT JOIN basket_b b ON a.fruit = b.fruit;

-- RIGHT JOIN
SELECT
    a.id id_a,
    a.fruit fruit_a,
    b.id id_b,
    b.fruit fruit_b
FROM
    basket_a a
RIGHT JOIN basket_b b ON a.fruit = b.fruit;

-- FULL JOIN
SELECT
    a.id id_a,
    a.fruit fruit_a,
    b.id id_b,
    b.fruit fruit_b
FROM
    basket_a a
FULL OUTER JOIN basket_b b ON a.fruit = b.fruit;

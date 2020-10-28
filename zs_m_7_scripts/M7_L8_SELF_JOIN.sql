-- M7L8 - SELF JOIN
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

TRUNCATE TABLE products;

INSERT INTO products (product_name, product_code, product_quantity, manufactured_date)					    
 	 VALUES ('Product 1', 'PRD1', 100.25, '20/11/2019'),
 	 		('Product 1', 'PRD2', 92.25, '1/11/2019'),
 	 		('Product 2', 'PRD2', 12.25, '1/11/2019'),
 	 		('Product 3', 'PRD3', 25.25, '2/11/2019'),
 	 		('Product 4', 'PRD4', 68.25, '3/11/2019'),
 	 		('Product 5', NULL, 11.11, '12/12/2020')
;

-- SELF JOIN

SELECT p.* 
  FROM products p;
 
    SELECT p.product_name,
    	   p.product_code, 
           p2.product_name AS same_product_name_diff_code
      FROM products p
 LEFT JOIN products p2 ON p2.product_code = p.product_code
  ORDER BY p.product_name, p.product_code
;

 SELECT *
   FROM (
	    SELECT p.product_name,
	    	   p.product_code, 
	           CASE WHEN p2.product_name <> p.product_name THEN p2.product_name 
	           		ELSE NULL 
	           	END AS same_product_name_diff_code
	      FROM products p
	 LEFT JOIN products p2 ON p2.product_code = p.product_code
	  ORDER BY p.product_name, p.product_code
	) sq 
  WHERE sq.same_product_name_diff_code IS NOT NULL
;


-- SELF JOIN 2 
DROP TABLE IF EXISTS employee;

CREATE TABLE employee (
	employee_id INT PRIMARY KEY,
	first_name VARCHAR (255) NOT NULL,
	last_name VARCHAR (255) NOT NULL,
	manager_id INT
);

INSERT INTO employee (employee_id, first_name,	last_name,	manager_id)
VALUES (1, 'Krzysiek', 'Bury', NULL),
   	   (2, 'Ania', 'Kowalska', 1),
	   (3, 'Tomek', 'Sawyer', 1),
   	   (4, 'Jessica', 'Polska', 2),
   	   (5, 'Janusz', 'Podbipięta', 2),
   	   (6, 'Onufry', 'Zagłoba', 3),
   	   (7, 'Bohdan', 'Chmielnicki', 3),
       (8, 'Michał', 'Paliwoda', 3);
       
    SELECT e.first_name || ' ' || e.last_name employee,
           m .first_name || ' ' || m .last_name manager
      FROM employee e
INNER JOIN employee m ON m .employee_id = e.manager_id
  ORDER BY manager;  
  
     SELECT e.first_name || ' ' || e.last_name employee,
           m .first_name || ' ' || m .last_name manager
      FROM employee e
 LEFT JOIN employee m ON m .employee_id = e.manager_id
  ORDER BY manager;  
  
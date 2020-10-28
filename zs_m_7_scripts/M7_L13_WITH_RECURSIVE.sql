-- M7L13 - WITH RECURSIVE

WITH RECURSIVE numbers_generator(n) AS (
	SELECT 1
	UNION
	SELECT n+1 
	  FROM numbers_generator
  	 WHERE n < 100 
) SELECT sum(n) FROM numbers_generator;

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
  
 WITH RECURSIVE emp AS (
 	SELECT employee_id,
 		   CASE WHEN manager_id IS NULL THEN 'BOSS'
 		   		ELSE first_name || ' ' || last_name 
  	        END  AS manager_name, 		   		 		   
 	       first_name || ' ' || last_name employee
 	  FROM employee
 	 WHERE manager_id IS NULL 
  	 UNION ALL
    SELECT e.employee_id,
    	   wre.employee,    	  
    	   e.first_name || ' ' || e.last_name employee
 	  FROM emp wre, employee e 
 	 WHERE wre.employee_id = e.manager_id
) SELECT * FROM emp;

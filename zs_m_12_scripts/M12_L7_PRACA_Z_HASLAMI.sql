-- PRACA Z HASLAMI

CREATE EXTENSION pgcrypto;

SELECT crypt('name', gen_salt('md5'));

CREATE TABLE users2 AS SELECT * FROM expense_tracker.users;

SELECT * FROM users2 ;

UPDATE users2 SET user_password = 'abc123' WHERE user_login = 'jkowalski';

SELECT * FROM users2 ;

INSERT INTO users2 
 VALUES (3, 'kbury', 'Krzysztof Bury', 'abc123', '123$', '1', now(),now());

SELECT * FROM users2 ;

SELECT encrypt(user_password::bytea, password_salt::bytea,'aes'), 
       user_password,
       password_salt
  FROM users2;
  
SELECT encrypt(user_password::bytea, password_salt::bytea,'aes'),  
	   decrypt(
	   	encrypt(user_password::bytea, password_salt::bytea,'aes'), 
	   	password_salt::bytea,
	   	'aes'),
	   password_salt,
       user_password
  FROM users2; 

--- TAK NIE CHCEMY
 
-- TAK CHCEMY
SELECT crypt(user_password, gen_salt('md5')),
       user_password,
       password_salt
  FROM users2; 
  
ALTER TABLE users2 ADD COLUMN user_password_secret VARCHAR(100);

UPDATE users2 SET user_password_secret = crypt(user_password, gen_salt('md5'));

SELECT * FROM users2;

SELECT user_password_secret = crypt(user_password,user_password_secret) AS correct_password,
	   user_login
  FROM users2;
-- 1. Stwórz nowy schemat o nazwie expense_tracker.

CREATE SCHEMA IF NOT EXISTS EXPENSE_TRACKER;

-- 2. W schemacie expense_tracker na podstawie dołączonego diagramu ERD.
-- Stwórz wszystkie tabele projektowe, według dołączonego opisu.
-- Na tym etapie nie tworzymy kluczy obcych FOREIGN KEY.

-- Pamiętaj o wykorzystaniu IF EXISTS / IF NOT EXISTS.
-- Wszystkie operacje powinny się znaleźć w 1 skrypcie.
-- Kilkukrotne uruchomienie tego samego skrypty powinno dawać ten sam rezultat (utworzenie tabel).
-- Hint: DROP IF EXISTS + CREATE IF NOT EXISTS

-- Tabela: users
-- Kolumny:
-- id_user, typ całkowity, klucz główny
-- user_login, typ tekstowy 25 znaków, not null
-- user_name, typ tekstowy 50 znaków, not null
-- user_password, typ tekstowy 100 znaków, not null
-- password_salt, typ tekstowy 100 znaków, not null
-- active, typ tekstowy 1 znak  (lub prawda / fałsz (boolean)), dla typu znakowego wartość domyślna 1, dla prawdy fałsz ustaw prawdę, , not null
-- UWAGA: nie ma tego w materiałach wideo. Przeczytaj o atrybucie DEFAULT dla kolumny https://www.postgresql.org/docs/12/ddl-default.html
-- insert_date, typ data i czas, wartość domyślna current_timestamp (spowoduje wstawianie aktualnej daty i czasu w momencie wstawiania wierszy)
-- update_date, typ data i czas, wartość domyślna current_timestamp

DROP TABLE IF EXISTS EXPENSE_TRACKER.USERS CASCADE;

CREATE TABLE IF NOT EXISTS EXPENSE_TRACKER.USERS (
 	ID_USER serial PRIMARY KEY,
	USER_LOGIN varchar (25) NOT NULL,
	USER_NAME varchar (50) NOT NULL,
	USER_PASSWORD varchar (100) NOT NULL,
	PASSWORD_SALT varchar (100) NOT NULL,
	ACTIVE char(1) NOT NULL default 1,
	INSERT_DATE timestamp default current_timestamp,
	UPDATE_DATE timestamp default current_timestamp
);

ALTER TABLE EXPENSE_TRACKER.USERS OWNER TO expense_tracker_group;

-- Tabela: bank_account_owner
-- Kolumny:
-- id_ba_own, typ całkowity, klucz główny
-- owner_name, typ tekstowy 50 znaków, not null
-- owner_desc, typ tekstowy 250 znaków
-- user_login, typ całkowity, not null
-- active, typ tekstowy 1 znak  (lub prawda / fałsz (boolean)), dla typu znakowego wartość domyślna 1, dla prawdy fałsz ustaw prawdę, not null
-- UWAGA: nie ma tego w materiałach wideo. Przeczytaj o atrybucie DEFAULT dla kolumny https://www.postgresql.org/docs/12/ddl-default.html
-- insert_date, typ data i czas, wartość domyślna current_timestamp (spowoduje wstawianie aktualnej daty i czasu w momencie wstawiania wierszy)
-- update_date, typ data i czas, wartość domyślna current_timestamp

DROP TABLE IF EXISTS EXPENSE_TRACKER.BANK_ACCOUNT_OWNER CASCADE;

CREATE TABLE IF NOT EXISTS EXPENSE_TRACKER.BANK_ACCOUNT_OWNER (
	ID_BA_OWN serial PRIMARY KEY,
	OWNER_NAME varchar (50) NOT NULL,
	OWNER_DESC varchar (250) NULL,
	USER_LOGIN integer NOT NULL,
	ACTIVE char(1) NOT NULL default 1,
	INSERT_DATE timestamp default current_timestamp,
	UPDATE_DATE timestamp default current_timestamp
);

ALTER TABLE EXPENSE_TRACKER.BANK_ACCOUNT_OWNER OWNER TO expense_tracker_group;

-- Tabela: bank_account_types
-- Kolumny:
-- id_ba_type, typ całkowity, klucz główny
-- ba_type, typ tekstowy 50 znaków, not null
-- ba_desc, typ tekstowy 250 znaków
-- active, typ tekstowy 1 znak  (lub prawda / fałsz (boolean)), dla typu znakowego wartość domyślna 1, dla prawdy fałsz ustaw prawdę, , not null
-- UWAGA: nie ma tego w materiałach wideo. Przeczytaj o atrybucie DEFAULT dla kolumny https://www.postgresql.org/docs/12/ddl-default.html
-- is_common_account, typ tekstowy 1 znak  (lub prawda / fałsz (boolean)), dla typu znakowego wartość domyślna 0, dla prawdy fałsz ustaw fałsz, , not null
-- UWAGA: nie ma tego w materiałach wideo. Przeczytaj o atrybucie DEFAULT dla kolumny https://www.postgresql.org/docs/12/ddl-default.html
-- id_ba_own, typ całkowity
-- insert_date, typ data i czas, wartość domyślna current_timestamp (spowoduje wstawianie aktualnej daty i czasu w momencie wstawiania wierszy)
-- update_date, typ data i czas, wartość domyślna current_timestamp

DROP TABLE IF EXISTS EXPENSE_TRACKER.BANK_ACCOUNT_TYPES CASCADE;

CREATE TABLE IF NOT EXISTS EXPENSE_TRACKER.BANK_ACCOUNT_TYPES (
	ID_BA_TYPE serial PRIMARY KEY,
	BA_TYPE varchar (50) NOT NULL,
	BA_DESC varchar (250) NULL,
	ACTIVE char(1) NOT NULL DEFAULT 1,
	IS_COMMON_ACCOUNT char(1) NOT NULL DEFAULT 0,
	ID_BA_OWN integer REFERENCES EXPENSE_TRACKER.BANK_ACCOUNT_OWNER (ID_BA_OWN),
	INSERT_DATE timestamp DEFAULT current_timestamp,
	UPDATE_DATE timestamp DEFAULT current_timestamp
);

ALTER TABLE EXPENSE_TRACKER.BANK_ACCOUNT_TYPES OWNER TO expense_tracker_group;

-- Tabela: transaction_type
-- Kolumny:
-- id_trans_type, typ całkowity, klucz główny
-- transaction_type_name, typ tekstowy 50 znaków, not null
-- transaction_type_desc, typ tekstowy 250 znaków
-- active, typ tekstowy 1 znak  (lub prawda / fałsz (boolean)), dla typu znakowego wartość domyślna 1, dla prawdy fałsz ustaw prawdę, , not null
-- UWAGA: nie ma tego w materiałach wideo. Przeczytaj o atrybucie DEFAULT dla kolumny https://www.postgresql.org/docs/12/ddl-default.html
-- insert_date, typ data i czas, wartość domyślna current_timestamp (spowoduje wstawianie aktualnej daty i czasu w momencie wstawiania wierszy)
-- update_date, typ data i czas, wartość domyślna current_timestamp

DROP TABLE IF EXISTS EXPENSE_TRACKER.TRANSACTION_TYPE CASCADE;

CREATE TABLE IF NOT EXISTS EXPENSE_TRACKER.TRANSACTION_TYPE (
	ID_TRANS_TYPE serial PRIMARY KEY,
	TRANSACTION_TYPE_NAME varchar (50) NOT NULL,
	TRANSACTION_TYPE_DESC varchar (250) NULL,
	ACTIVE char(1) NOT NULL default 1,
	INSERT_DATE timestamp default current_timestamp,
	UPDATE_DATE timestamp default current_timestamp
);

ALTER TABLE EXPENSE_TRACKER.TRANSACTION_TYPE OWNER TO expense_tracker_group;

-- Tabela: transaction_category
-- Kolumny:
-- id_trans_cat, typ całkowity, klucz główny
-- category_name, typ tekstowy 50 znaków, not null
-- category_description, typ tekstowy 250 znaków
-- active, typ tekstowy 1 znak  (lub prawda / fałsz (boolean)), dla typu znakowego wartość domyślna 1, dla prawdy fałsz ustaw prawdę, , not null
-- UWAGA: nie ma tego w materiałach wideo. Przeczytaj o atrybucie DEFAULT dla kolumny https://www.postgresql.org/docs/12/ddl-default.html
-- insert_date, typ data i czas, wartość domyślna current_timestamp (spowoduje wstawianie aktualnej daty i czasu w momencie wstawiania wierszy)
-- update_date, typ data i czas, wartość domyślna current_timestamp

DROP TABLE IF EXISTS EXPENSE_TRACKER.TRANSACTION_CATEGORY CASCADE;

CREATE TABLE IF NOT EXISTS EXPENSE_TRACKER.TRANSACTION_CATEGORY (
	ID_TRANS_CAT serial PRIMARY KEY,
	CATEGORY_NAME varchar (50) NOT NULL,
	CATEGORY_DESCRIPTION varchar (250) NULL,
	ACTIVE char(1) NOT NULL default 1,
	INSERT_DATE timestamp default current_timestamp,
	UPDATE_DATE timestamp default current_timestamp
);

ALTER TABLE EXPENSE_TRACKER.TRANSACTION_CATEGORY OWNER TO expense_tracker_group;

-- Tabela: transaction_subcategory
-- Kolumny:
-- id_trans_subcat, typ całkowity, klucz główny
-- id_trans_cat, typ całkowity, klucz główny
-- subcategory_name, typ tekstowy 50 znaków, not null
-- subcategory_description, typ tekstowy 250 znaków
-- active, typ tekstowy 1 znak  (lub prawda / fałsz (boolean)), dla typu znakowego wartość domyślna 1, dla prawdy fałsz ustaw prawdę, , not null
-- UWAGA: nie ma tego w materiałach wideo. Przeczytaj o atrybucie DEFAULT dla kolumny https://www.postgresql.org/docs/12/ddl-default.html
-- insert_date, typ data i czas, wartość domyślna current_timestamp (spowoduje wstawianie aktualnej daty i czasu w momencie wstawiania wierszy)
-- update_date, typ data i czas, wartość domyślna current_timestamp

DROP TABLE IF EXISTS EXPENSE_TRACKER.TRANSACTION_SUBCATEGORY CASCADE;

CREATE TABLE IF NOT EXISTS EXPENSE_TRACKER.TRANSACTION_SUBCATEGORY (
	ID_TRANS_SUBCAT serial PRIMARY KEY,
	ID_TRANS_CAT integer REFERENCES EXPENSE_TRACKER.TRANSACTION_CATEGORY (ID_TRANS_CAT),
	SUBCATEGORY_NAME varchar (50) NOT NULL,
	SUBCATEGORY_DESCRIPTION varchar (250) NULL,
	ACTIVE char(1) NOT NULL default 1,
	INSERT_DATE timestamp default current_timestamp,
	UPDATE_DATE timestamp default current_timestamp
);

ALTER TABLE EXPENSE_TRACKER.TRANSACTION_SUBCATEGORY OWNER TO expense_tracker_group;

-- Tabela: transaction_bank_accounts
-- Kolumny:
-- id_trans_ba, typ całkowity, klucz główny
-- id_ba_own, typ całkowity,
-- id_ba_typ, typ całkowity,
-- bank_account_name, typ tekstowy 50 znaków, not null
-- bank_account_desc, typ tekstowy 250 znaków
-- active, typ tekstowy 1 znak  (lub prawda / fałsz (boolean)), dla typu znakowego wartość domyślna 1, dla prawdy fałsz ustaw prawdę, , not null
-- UWAGA: nie ma tego w materiałach wideo. Przeczytaj o atrybucie DEFAULT dla kolumny https://www.postgresql.org/docs/12/ddl-default.html
-- insert_date, typ data i czas, wartość domyślna current_timestamp (spowoduje wstawianie aktualnej daty i czasu w momencie wstawiania wierszy)
-- update_date, typ data i czas, wartość domyślna current_timestamp

DROP TABLE IF EXISTS EXPENSE_TRACKER.TRANSACTION_BANK_ACCOUNTS CASCADE;

CREATE TABLE IF NOT EXISTS EXPENSE_TRACKER.TRANSACTION_BANK_ACCOUNTS (
	ID_TRANS_BA serial PRIMARY KEY,
	ID_BA_OWN integer REFERENCES EXPENSE_TRACKER.BANK_ACCOUNT_OWNER (ID_BA_OWN),
	ID_BA_TYP integer REFERENCES EXPENSE_TRACKER.BANK_ACCOUNT_TYPES (ID_BA_TYPE),
	BANK_ACCOUNT_NAME varchar (50) NOT NULL,
	BANK_ACCOUNT_DESC varchar (250) NULL,
	ACTIVE char(1) NOT NULL default 1,
	INSERT_DATE timestamp default current_timestamp,
	UPDATE_DATE timestamp default current_timestamp
);

ALTER TABLE EXPENSE_TRACKER.TRANSACTION_BANK_ACCOUNTS OWNER TO expense_tracker_group;

-- Tabela: transactions
-- Kolumny:
-- id_transaction, typ całkowity, klucz główny
-- id_trans_ba, typ całkowity
-- id_trans_cat, typ całkowity
-- id_trans_subcat, typ całkowity
-- id_trans_type, typ całkowity
-- id_user, typ całkowity
-- transaction_date, typ daty (sama data), wartość domyślna current_date (spowoduje wstawianie aktualnej daty w momencie wstawiania wierszy)
-- UWAGA: nie ma tego w materiałach wideo. Przeczytaj o atrybucie DEFAULT dla kolumny https://www.postgresql.org/docs/12/ddl-default.html
-- Przykład transaction_date DATE DEFAULT current_date
-- transaction_value, typ zmiennoprzecinkowy (numeric, 9 znaków, do 2 znaków po przecinku)
-- transaction_description, typ tekstowy (nieograniczony)
-- insert_date, typ data i czas, wartość domyślna current_timestamp (spowoduje wstawianie aktualnej daty i czasu w momencie wstawiania wierszy)
-- update_date, typ data i czas, wartość domyślna current_timestamp

DROP TABLE IF EXISTS EXPENSE_TRACKER.TRANSACTIONS CASCADE;

CREATE TABLE IF NOT EXISTS EXPENSE_TRACKER.TRANSACTIONS (
	ID_TRANSACTION serial PRIMARY KEY,
    ID_TRANS_BA integer REFERENCES EXPENSE_TRACKER.TRANSACTION_BANK_ACCOUNTS (ID_TRANS_BA),
	ID_TRANS_CAT integer REFERENCES EXPENSE_TRACKER.TRANSACTION_CATEGORY (ID_TRANS_CAT),
	ID_TRANS_SUBCAT integer REFERENCES EXPENSE_TRACKER.TRANSACTION_SUBCATEGORY (ID_TRANS_SUBCAT),
	ID_TRANS_TYPE integer REFERENCES EXPENSE_TRACKER.TRANSACTION_TYPE (ID_TRANS_TYPE),
	ID_USER integer REFERENCES EXPENSE_TRACKER.USERS (ID_USER),
	TRANSACTION_DATE date default current_date,
	TRANSACTION_VALUE numeric(9,2),
	TRANSACTION_DESCRIPTION text,
	INSERT_DATE timestamp default current_timestamp,
	UPDATE_DATE timestamp default current_timestamp
);

ALTER TABLE EXPENSE_TRACKER.TRANSACTIONS OWNER TO expense_tracker_group;

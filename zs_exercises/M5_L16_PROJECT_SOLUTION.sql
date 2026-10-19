-- 1. Dla table posiądających klucz główny (PRIMARY KEY) zmień typ danych z  typu całkowitego na typ SERIAL. Zmieniając definicję struktury i zapytania CREATE TABLE. Klucze obce w tabelach (z ograczeniem REFERENCES) powinny zostać jako typ całkowity.

-- 2. Dla każdej z tabel projektowych wstaw przynajmniej 1 rzeczywisty rekord spełniającyh kryteria tabeli i kluczy obcych.

INSERT INTO expense_tracker.users (user_login, user_name, user_password, password_salt, active)
     VALUES ('et_jkowalski','Jan Kowalski', md5('str4ongP$sswor6'||'123$'), '123$', 1);

INSERT INTO expense_tracker.bank_account_owner (owner_name, owner_desc, user_login, active)
     VALUES ('Jan Kowalski','Konto prywatne Jana', 1, 1);

INSERT INTO expense_tracker.bank_account_types (ba_type, ba_desc, active, is_common_account, id_ba_own)
     VALUES ('ROR','Rachunek oszczędnościowo rozliczeniowy.', 1, 0, 1);

INSERT INTO expense_tracker.transaction_type (transaction_type_name, transaction_type_desc, active)
     VALUES ('PRZYCHÓD', 'Wpływ na konto.', 1),
            ('WYDATEK', 'Wydatek z konta.',1);

INSERT INTO expense_tracker.transaction_category (category_name, category_description, active)
     VALUES ('JEDZENIE', 'Kategoria związan z zakupami spożywczymi i jedzeniem', 1);

INSERT INTO expense_tracker.transaction_subcategory (id_trans_cat, subcategory_name, subcategory_description, active)
     VALUES (1, 'Zakupy spożywcze', 'Zakupy spożywcze',1),
            (1, 'Jedzenie miasto', 'Posiłki na mieście',1),
            (1, 'Jedzenie praca', 'Posiłki spożywane / kupowane w pracy',1);

INSERT INTO expense_tracker.transaction_bank_accounts (id_ba_own, id_ba_typ, bank_account_name, bank_account_desc, active)
     VALUES (1, 1, 'ROR - Jan', 'ROR - konto prywatne Jana', 1);

INSERT INTO expense_tracker.transactions (id_trans_ba, id_trans_cat, id_trans_subcat, id_trans_type, id_user, transaction_date, transaction_value, transaction_description)
     VALUES (1,1,2,2,1,'10/10/2020',56.00,'Obiad na mieście - Sushi.');

-- 3. Wykonaj pełną kopię zapasową bazy danych z opcją --clean (do formatu plain tak żeby widzieć co się zrzuciło) korzystając z narzędzia pg_dump a następnie odtwórz kopię z zapisanego skryptu korzystając z narzedzia DBeaver lub psql.

pg_dump --host localhost ^
        --port 5433 ^
        --username postgres ^
        --format plain ^
        --file "D:\PostgreSQL_dump\expense_tracker_db.sql" ^
        --clean ^
        postgres

psql -U postgres -p 5433 -h localhost -d postgres -f "D:\PostgreSQL_dump\expense_tracker_db.sql"

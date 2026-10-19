-- 1. Korzystając ze składni CREATE ROLE, stwórz nowego użytkownika o nazwie expense_tracker_user z możliwością zalogowania się do bazy danych i hasłem silnym :) (coś wymyśl)

CREATE ROLE expense_tracker_user WITH LOGIN PASSWORD 'expense#trac3r$9';

-- 2. Korzystając ze składni REVOKE, odbierz uprawniena tworzenia obiektów w schemacie public roli PUBLIC

REVOKE CREATE ON SCHEMA public FROM PUBLIC;

-- 2. Jeżeli w Twoim środowisku istnieje już schemat expense_tracker (z obiektami tabel) usuń go korzystając z polecenie DROP CASCADE.

DROP SCHEMA IF EXISTS expense_tracker CASCADE;

-- 3. Utwórz nową rolę expense_tracker_group.

CREATE ROLE expense_tracker_group;

-- 4. Utwórz schemat expense_tracker, korzystając z atrybutu AUTHORIZATION, ustalając własnośćna rolę expense_tracker_group.

CREATE SCHEMA expense_tracker AUTHORIZATION expense_tracker_group;

-- 5. Dla roli expense_tracker_group, dodaj następujące przywileje:
-- > Dodaj przywilej łączenia do bazy danych postgres (lub innej jeżeli korzystasz z innej nazwy)
-- > Dodaj wszystkie przywileje do schematu expense_tracker

GRANT CONNECT ON DATABASE postgres TO expense_tracker_group;
GRANT ALL ON SCHEMA expense_tracker TO expense_tracker_group;

-- 6. Dodaj rolę expense_tracker_group użytkownikowi expense_tracker_user.

GRANT expense_tracker_group TO expense_tracker_user;

-- ###################### ZMIANY DO SKRYPTU MODUŁ 3

-- 7. Otwórz skrypt z zdania projektowymi z Moduły 3. Usuń fragment skryptu związany z tworzeniem schematu expense_tracker, teraz ten fragment będzie w tej części skryptu.

-- 8. Dla definicja tabel w skrypcie z zdaniami do Modułu 3 dodaj relację kluczy obcych pomiędzy tabelami. Zmień definicję CREATE TABLE, nie dodawaj tego za pośrednictwem ALTER TABLE.
-- BANK_ACCOUNT_TYPES: Atrybut ID_BA_OWN ma być referencją do BANK_ACCOUNT_OWNER (ID_BA_OWN)
-- TRANSACTIONS: Atrybut ID_TRANS_BA ma być referencją do TRANSACTION_BANK_ACCOUNTS (ID_TRANS_BA)
-- TRANSACTIONS: Atrybut ID_TRANS_CAT ma być referencją do TRANSACTION_CATEGORY (ID_TRANS_CAT)
-- TRANSACTIONS: Atrybut ID_TRANS_SUBCAT ma być referencją do TRANSACTION_SUBCATEGORY (ID_TRANS_SUBCAT)
-- TRANSACTIONS: Atrybut ID_TRANS_TYPE ma być referencją do TRANSACTION_TYPE (ID_TRANS_TYPE)
-- TRANSACTIONS: Atrybut ID_USER ma być referencją do USERS (ID_USER)
-- TRANSACTION_BANK_ACCOUNTS: Atrybut ID_BA_OWN ma być referencją do BANK_ACCOUNT_OWNER (ID_BA_OWN)
-- TRANSACTION_BANK_ACCOUNTS: Atrybut ID_BA_TYP ma być referencją do BANK_ACCOUNT_TYPES (ID_BA_TYPE)
-- TRANSACTION_SUBCATEGORY: Atrybut ID_TRANS_CAT ma być referencją do TRANSACTION_CATEGORY (ID_TRANS_CAT)

-- 9. Uszereguj tak wykonanie tabel w skrypcie aby w momencie uruchomienia skryptu. Nie był zwracany błąd, że dana relacja nie może zostać utworzona bo tabela jeszcze nie istnieje.

-- 1: Stwórz 3 osobne widoki dla wszystkich transakcji z podziałem na rodzaj właściciela konta.
-- W widokach wyświetl informacje o nazwie kategorii, nazwie podkategorii, typie transakcji, dacie transakcji, roku z daty transakcji, wartości transakcji i type konta.

CREATE VIEW janusz_accounts AS
SELECT tc.category_name,
       ts.subcategory_name,
       tt.transaction_type_name,
       t.transaction_date,
   	   EXTRACT(YEAR FROM t.transaction_date) transaction_year,
       t.transaction_value,
       bat.ba_type
  FROM expense_tracker.transactions t
  JOIN expense_tracker.transaction_type tt ON tt.id_trans_type = t.id_trans_type
  JOIN expense_tracker.transaction_bank_accounts tba ON tba.id_trans_ba = t.id_trans_ba
  JOIN expense_tracker.bank_account_owner bao ON bao.id_ba_own = tba.id_ba_own
  											 AND bao.owner_name = 'Janusz Kowalski'
  JOIN expense_tracker.bank_account_types bat ON bat.id_ba_type = tba.id_ba_typ
                                             AND bat.id_ba_own = bao.id_ba_own
  JOIN expense_tracker.transaction_category tc ON tc.id_trans_cat = t.id_trans_cat
  JOIN expense_tracker.transaction_subcategory ts ON ts.id_trans_subcat = t.id_trans_subcat
                                                 AND ts.id_trans_cat = tc.id_trans_cat;

CREATE VIEW grazyna_accounts AS
SELECT tc.category_name,
       ts.subcategory_name,
       tt.transaction_type_name,
       t.transaction_date,
       EXTRACT(YEAR FROM t.transaction_date) transaction_year,
       t.transaction_value,
       bat.ba_type
  FROM expense_tracker.transactions t
  JOIN expense_tracker.transaction_type tt ON tt.id_trans_type = t.id_trans_type
  JOIN expense_tracker.transaction_bank_accounts tba ON tba.id_trans_ba = t.id_trans_ba
  JOIN expense_tracker.bank_account_owner bao ON bao.id_ba_own = tba.id_ba_own
  											 AND bao.owner_name = 'Grażyna Kowalska'
  JOIN expense_tracker.bank_account_types bat ON bat.id_ba_type = tba.id_ba_typ
                                             AND bat.id_ba_own = bao.id_ba_own
  JOIN expense_tracker.transaction_category tc ON tc.id_trans_cat = t.id_trans_cat
  JOIN expense_tracker.transaction_subcategory ts ON ts.id_trans_subcat = t.id_trans_subcat
                                                 AND ts.id_trans_cat = tc.id_trans_cat;

CREATE VIEW janusz_grazyna_accounts AS
SELECT tc.category_name,
       ts.subcategory_name,
       tt.transaction_type_name,
       t.transaction_date,
       EXTRACT(YEAR FROM t.transaction_date) transaction_year,
       t.transaction_value,
       bat.ba_type
  FROM expense_tracker.transactions t
  JOIN expense_tracker.transaction_type tt ON tt.id_trans_type = t.id_trans_type
  JOIN expense_tracker.transaction_bank_accounts tba ON tba.id_trans_ba = t.id_trans_ba
  JOIN expense_tracker.bank_account_owner bao ON bao.id_ba_own = tba.id_ba_own
  											 AND bao.owner_name = 'Janusz i Grażynka'
  JOIN expense_tracker.bank_account_types bat ON bat.id_ba_type = tba.id_ba_typ
                                             AND bat.id_ba_own = bao.id_ba_own
  JOIN expense_tracker.transaction_category tc ON tc.id_trans_cat = t.id_trans_cat
  JOIN expense_tracker.transaction_subcategory ts ON ts.id_trans_subcat = t.id_trans_subcat
                                                 AND ts.id_trans_cat = tc.id_trans_cat;

-- 2: Korzystając z widoku konta dla Janusza i Grażynki z zadania 1 przygotuj zapytanie w którym wyświetlisz, rok transakcji, typ transakcji, nazwę kategorii, zgrupowaną listę unikatowych (DISTINCT) podkategorii razem z sumą transakcji dla grup rok transakcji, typ transakcji, nazwę kategorii.

  SELECT transaction_year,
	     transaction_type_name,
	     category_name,
	     array_agg(DISTINCT subcategory_name) AS subcategories_list,
	     sum(transaction_value)
    FROM janusz_grazyna_accounts jga
GROUP BY transaction_year,
	     transaction_type_name,
	     category_name;

-- 3: Dodaj do schematu nową tabelę MONTHLY_BUDGET_PLANNED o atrybutach
-- YEAR_MONTH VARCHAR(7) PRIMARY_KEY,
-- BUDGET_PLANNED NUMERIC(10,2)
-- LEFT_BUDGET NUMERIC(10,2)
-- Dodaj do tej tabeli nowy rekord z planowanym budżetem na dany miesiąc obecnego roku (do obu atrybutów BUDGET_PLANNED, LEFT_BUDGET ta sama wartość)

DROP TABLE IF EXISTS expense_tracker.monthly_budget_planned;
CREATE TABLE expense_tracker.monthly_budget_planned (
	year_month VARCHAR(7) PRIMARY KEY,
	budget_planned NUMERIC(10,2),
	left_budget NUMERIC(10,2)
);

INSERT INTO expense_tracker.monthly_budget_planned VALUES ('2020_11', 3000.00, 3000.00);

-- 4: Dodaj nowy Wyzwalacz do tabeli TRANSACTIONS, który przy każdorazowym dodaniu / zaktualizowaniu lub usunięciu wartości zmieni wartość LEFT_BUDGET odpowiednio w tabeli expense_tracker.monthly_budget_planned.

DROP FUNCTION fn_budget_update CASCADE;
CREATE OR REPLACE FUNCTION fn_budget_update()
	RETURNS TRIGGER
	LANGUAGE plpgsql
	AS $$
		BEGIN
			IF (TG_OP = 'UPDATE') THEN
				UPDATE expense_tracker.monthly_budget_planned
				   SET left_budget = left_budget + OLD.transaction_value;
			ELSEIF (TG_OP = 'INSERT') THEN
				UPDATE expense_tracker.monthly_budget_planned
				   SET left_budget = left_budget + NEW.transaction_value;
		    ELSEIF (TG_OP = 'DELETE') THEN
				UPDATE expense_tracker.monthly_budget_planned
				   SET left_budget = left_budget + CASE
				  										WHEN OLD.transaction_value < 0 THEN OLD.transaction_value * -1
				  										ELSE OLD.transaction_value
				  									END;
			END IF;
 		    RETURN NULL; -- rezultat zignoruj
		END
	$$;

CREATE TRIGGER budget_update_trg
	AFTER INSERT OR UPDATE OR DELETE ON expense_tracker.transactions
		FOR EACH ROW EXECUTE PROCEDURE fn_budget_update();

-- 5: Przetestuj działanie wyzwalacza dla kilku przykładowych operacji.

INSERT INTO expense_tracker.transactions (id_trans_ba, id_trans_cat, id_trans_subcat, id_trans_type, id_user, transaction_date, transaction_value, transaction_description)
	VALUES ((SELECT tba.id_trans_ba
			   FROM expense_tracker.transaction_bank_accounts tba
			  WHERE tba.bank_account_name ='ROR - Janusz i Grażynka'
			     OR tba.id_trans_ba = -1
		   ORDER BY tba.id_trans_ba DESC
		      LIMIT 1),
		     (SELECT tc.id_trans_cat
		    	FROM expense_tracker.transaction_category tc
		       WHERE tc.category_name = 'JEDZENIE'
		          OR tc.id_trans_cat = -1
		    ORDER BY tc.id_trans_cat DESC
		        LIMIT 1),
		       (SELECT tsc.id_trans_subcat
		          FROM expense_tracker.transaction_subcategory tsc
		         WHERE tsc.subcategory_name = 'Zakupy spożywcze'
		            OR tsc.id_trans_subcat = -1
		      ORDER BY tsc.id_trans_subcat DESC
		         LIMIT 1),
		        (SELECT tt.id_trans_type
		           FROM expense_tracker.transaction_type tt
		          WHERE tt.transaction_type_name = 'Obciążenie'
		             OR tt.id_trans_type = -1
		       ORDER BY tt.id_trans_type DESC
		          LIMIT 1), NULL, '13/11/2020', -145.23, 'Biedronka');

SELECT * FROM expense_tracker.monthly_budget_planned;
-- 6: Czego brakuje w tym triggerze? Jakie potencjalnie spowoduje problemy w kontekście danych w tabeli MONTHLY_BUDGET_PLANNED.

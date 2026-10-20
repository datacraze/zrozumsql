-- #1 Wyświetl wszystkie informacje o koncie: nazwa właścieciela (owner_name), opis właściciela (owner_desc), typ konta (ba_type) opis konta (ba_desc), flaga czy jest aktywne (active), nazwa konta bankowego (bank_account_name) razem z użytkownikiem (user_login), który jest dO niego przypisany. Dla właściciela jakim jest Janusz Kowalski.

SELECT bao.owner_name, bao.owner_desc,
	   bat.ba_type, bat.ba_desc,
	   tba.bank_account_name,
	   u.user_login
  FROM expense_tracker.bank_account_owner bao
  JOIN expense_tracker.bank_account_types bat ON bat.id_ba_own = bao.id_ba_own
  JOIN expense_tracker.transaction_bank_accounts tba ON tba.id_ba_own = bao.id_ba_own
                                                    AND tba.id_ba_typ = bat.id_ba_type
  JOIN expense_tracker.users u ON u.id_user  = bao.user_login
 WHERE bao.owner_name = 'Janusz Kowalski';

-- #2 Wyświetl wszystkie informacje o dostępnych kategoriach transakcji i ich możliwych podkategoriach.
-- W obu przypadkach powinny to być tylko "aktywne" elementy (active TRUE / 1 / Y / y :)).
-- W wyniku wyświetl 2 atrybuty, nazwa kategorii i nazwa podkategorii, dane posortuj po identyfikatorze kategorii rosnąco.

   SELECT tc.category_name,
		  ts.subcategory_name
     FROM expense_tracker.transaction_category tc
LEFT JOIN expense_tracker.transaction_subcategory ts ON ts.id_trans_cat = tc.id_trans_cat
    WHERE tc.active = '1'
      AND ts.active = '1'
  ORDER BY tc.id_trans_cat
;

-- #3 Wyświetl wszystkie transakcje (TRANSACTIONS) które miały miejsce w 2016 roku związne z kategorią JEDZENIE.

SELECT t.*,
       tc.*
  FROM expense_tracker.transactions t
  JOIN expense_tracker.transaction_category tc ON tc.id_trans_cat = t.id_trans_cat
  											  AND tc.category_name = 'JEDZENIE'
 WHERE EXTRACT(YEAR FROM t.transaction_date) = 2016;

-- #4 Dodaj nową podkategorię DO tabeli TRANSACTION_SUBCATEGORY, która będzie w relacji z kategorią (TRANSACTION_CATEGORY) JEDZENIE.
-- Na podstawie wyników z zadania 3, dla wszystkich wierszy z kategorii jedzenie, które nie mają przypisanej podkategorii (-1) zaktualizuj wartość podkategorii na nową dodaną.
-- Możesz wykorzystać dowolną znaną Ci konstrukcję (UPDATE / UPDATE + WITH / UPDATE + FROM / UPDATE + EXISTS).

INSERT INTO expense_tracker.transaction_subcategory (id_trans_cat, subcategory_name, subcategory_description, active, insert_date, update_date)
     VALUES (1, 'Dobre Jedzenie', 'Nowa kategoria - Dobre Jedzenie', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

WITH transactions_without_subcat AS (
SELECT t.id_transaction
  FROM expense_tracker.transactions t
  JOIN expense_tracker.transaction_category tc ON tc.id_trans_cat = t.id_trans_cat
  											  AND tc.category_name = 'JEDZENIE'
 WHERE EXTRACT(YEAR FROM t.transaction_date) = 2016
   AND t.id_trans_subcat  = -1
) UPDATE expense_tracker.transactions t
     SET id_trans_subcat = (SELECT ts.id_trans_subcat
                              FROM expense_tracker.transaction_subcategory ts
                             WHERE subcategory_name = 'Dobre Jedzenie'
                             LIMIT 1)
   WHERE EXISTS (SELECT 1
                   FROM transactions_without_subcat tws
                  WHERE tws.id_transaction = t.id_transaction);


-- #5 Wyświetl wszystkie transakcje w roku 2020 dla konta oszczędnościowego Janusz i Grażynka.
-- W wynikach wyświetl informacje o nazwie kategorii, nazwie podkategorii, typie transakcji, dacie transakcji i wartości transakcji.

SELECT tc.category_name,
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
  JOIN expense_tracker.transaction_subcategory ts ON ts.id_trans_subcat = t.id_trans_subcat
                                                 AND ts.id_trans_subcat = tc.id_trans_subcat
 WHERE EXTRACT(YEAR FROM t.transaction_date) = 2020;

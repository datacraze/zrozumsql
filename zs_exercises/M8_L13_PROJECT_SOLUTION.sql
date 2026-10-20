-- 1: Oblicz sumę transakcji w podziale na kategorie transakcji. W wyniku wyświetl nazwę kategorii i całkowitą sumę.

   SELECT tc.category_name,
   		  sum(t.transaction_value)
     FROM expense_tracker.transactions t
LEFT JOIN expense_tracker.transaction_category tc ON tc.id_trans_cat = t.id_trans_cat
 GROUP BY tc.category_name ;

-- 2: Oblicz sumę wydatków na Używki dokonana przez Janusza (Janusz Kowalski) z jego konta prywatnego (ROR - Janusz) w obecnym roku 2020.

   SELECT sum(t.transaction_value)
     FROM expense_tracker.transactions t
     JOIN expense_tracker.transaction_category tc ON tc.id_trans_cat = t.id_trans_cat
     											 AND tc.category_name = 'UŻYWKI'
 	 JOIN expense_tracker.transaction_bank_accounts tba ON tba.id_trans_ba = t.id_trans_ba
 	 JOIN expense_tracker.bank_account_owner bao ON bao.id_ba_own = tba.id_ba_own
	 JOIN expense_tracker.bank_account_types bat ON bat.id_ba_type = tba.id_ba_typ
	 										    AND bat.id_ba_own = bao.id_ba_own
	 										    AND bat.ba_type = 'ROR'
 	 JOIN expense_tracker.users u ON u.id_user = bao.user_login
	 						     AND u.user_login = 'jkowalski'
	WHERE EXTRACT(YEAR FROM t.transaction_date) = 2020
;

-- 3: Stwórz zapytanie, które będzie podsumowywać wydatki (typ transakcji: Obciążenie) na wspólnym koncie RoR - Janusza i Grażynki w  taki sposób aby widoczny był podział sumy wydatków, ze względu na rok, rok i kwartał (format: 2019_1), rok i miesiąc (format: 2019_12) w roku 2019. Skorzystaj z funkcji ROLLUP.

   SELECT extract(YEAR FROM t.transaction_date) AS transaction_year,
   		  extract(YEAR FROM t.transaction_date)||'_'||extract(MONTH FROM t.transaction_date) AS transaction_year_month,
   		  extract(YEAR FROM t.transaction_date)||'_'||EXTRACT(quarter FROM t.transaction_date) AS transaction_year_quarter,
   		  sum(t.transaction_value)
     FROM expense_tracker.transactions t
     JOIN expense_tracker.transaction_category tc ON tc.id_trans_cat = t.id_trans_cat
 	 JOIN expense_tracker.transaction_bank_accounts tba ON tba.id_trans_ba = t.id_trans_ba
 	 JOIN expense_tracker.bank_account_owner bao ON bao.id_ba_own = tba.id_ba_own
	 JOIN expense_tracker.bank_account_types bat ON bat.id_ba_type = tba.id_ba_typ
	 										    AND bat.id_ba_own = bao.id_ba_own
	 										    AND bat.ba_type = 'ROR - WSPÓLNY'
	 JOIN expense_tracker.transaction_type tt ON tt.id_trans_type = t.id_trans_type
	 										 AND tt.transaction_type_name = 'Obciążenie'
	WHERE EXTRACT(YEAR FROM t.transaction_date) = 2019
 GROUP BY ROLLUP (transaction_year, transaction_year_month, transaction_year_quarter)
 ORDER BY transaction_year_month
;

-- 4: Stwórz zapytanie podsumowujące sumę wydatków na koncie wspólnym Janusza i Grażynki (ROR- Wspólny), wydatki (typ: Obciążenie), w podziale na poszególne lata od roku 2015 wzwyż. Do wyników (rok, suma wydatków) dodaj korzystając z funkcji okna atrybut który będzie różnicą pomiędzy danym rokiem a poprzednim (balans rok do roku).

WITH common_spendings AS (
   SELECT extract(YEAR FROM t.transaction_date) AS transaction_year,
   		  sum(t.transaction_value) AS spending_sum
     FROM expense_tracker.transactions t
     JOIN expense_tracker.transaction_category tc ON tc.id_trans_cat = t.id_trans_cat
 	 JOIN expense_tracker.transaction_bank_accounts tba ON tba.id_trans_ba = t.id_trans_ba
 	 JOIN expense_tracker.bank_account_owner bao ON bao.id_ba_own = tba.id_ba_own
	 JOIN expense_tracker.bank_account_types bat ON bat.id_ba_type = tba.id_ba_typ
	 										    AND bat.id_ba_own = bao.id_ba_own
	 										    AND bat.ba_type = 'ROR - WSPÓLNY'
	 JOIN expense_tracker.transaction_type tt ON tt.id_trans_type = t.id_trans_type
	 										 AND tt.transaction_type_name = 'Obciążenie'
    WHERE extract(YEAR FROM t.transaction_date) >= 2015
 GROUP BY transaction_year
) SELECT *,
		 (spending_sum - prev_year_spend)*(-1) AS increas_of_spend_yoy
    FROM (
	  SELECT *,
			 lag(spending_sum) OVER (ORDER BY transaction_year) AS prev_year_spend
        FROM common_spendings ) sq;


-- 5. Korzystając z funkcji LAST_VALUE pokaż różnicę w dniach, pomiędzy kolejnymi transakcjami (Obciążenie) na prywatnym koncie Janusza (RoR) dla podkategorii Technologie w 1 kwartale roku 2020.

   SELECT t.id_transaction,
		  t.transaction_date,
		  LAST_VALUE(t.transaction_date) OVER (ORDER BY t.transaction_date GROUPS BETWEEN CURRENT ROW
   																					  AND 1 FOLLOWING) AS next_technology_transaction,
		  LAST_VALUE(t.transaction_date) OVER (ORDER BY t.transaction_date GROUPS BETWEEN CURRENT ROW
   																					  AND 1 FOLLOWING)
			-
			 t.transaction_date AS days_since_previous_tech_purchase,
		  t.transaction_value,
		  t.transaction_description
     FROM expense_tracker.transactions t
     JOIN expense_tracker.transaction_category tc ON tc.id_trans_cat = t.id_trans_cat
     JOIN expense_tracker.transaction_subcategory ts ON ts.id_trans_cat = tc.id_trans_cat
	 												AND ts.id_trans_subcat = t.id_trans_subcat
     												AND ts.subcategory_name = 'Technologie'
 	 JOIN expense_tracker.transaction_bank_accounts tba ON tba.id_trans_ba = t.id_trans_ba
 	 JOIN expense_tracker.bank_account_owner bao ON bao.id_ba_own = tba.id_ba_own
	 JOIN expense_tracker.bank_account_types bat ON bat.id_ba_type = tba.id_ba_typ
	 										    AND bat.id_ba_own = bao.id_ba_own
	 										    AND bat.ba_type = 'ROR'
	 JOIN expense_tracker.transaction_type tt ON tt.id_trans_type = t.id_trans_type
	 										 AND tt.transaction_type_name = 'Obciążenie'
 	 JOIN expense_tracker.users u ON u.id_user = bao.user_login
	 						     AND u.user_login = 'jkowalski'
    WHERE extract(YEAR FROM t.transaction_date) = 2020
      AND extract(quarter FROM t.transaction_date) = 1

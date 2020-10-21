INSERT INTO expense_tracker.users (user_login, user_name, user_password, password_salt, active)
     VALUES ('et_kbury','Krzysztof Bury', md5('str4ongP$sswor6'||'123$'), '123$', 1);

INSERT INTO expense_tracker.bank_account_owner (owner_name, owner_desc, user_login, active)
     VALUES ('Krzysztof Bury','Krzysiek Konto Prywatne Millenium', 1, 1);

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
     VALUES (1, 1, 'ROR - Krzysiek', 'ROR - Krzysiek konto prywatne', 1);

INSERT INTO expense_tracker.transactions (id_trans_ba, id_trans_cat, id_trans_subcat, id_trans_type, id_user, transaction_date, transaction_value, transaction_description)
     VALUES (1,1,2,2,1,'10/10/2020',56.00,'Obiad na mieście - Sushi.');
     
-- OPCJA 1    
SELECT * FROM expense_tracker.transaction_category tc ;
    
INSERT INTO expense_tracker.transaction_subcategory (id_trans_cat, subcategory_name, subcategory_description, active)
     VALUES (2, 'Zakupy spożywcze w Biedrze', 'Zakupy spożywcze',1);           

-- OPCJA 2    
INSERT INTO expense_tracker.transaction_subcategory (id_trans_cat, subcategory_name, subcategory_description, active)
     VALUES ((SELECT id_trans_cat 
    			FROM expense_tracker.transaction_category tc
    		   WHERE tc.category_name = 'JEDZENIE'), 'Zakupy spożywcze', 'Zakupy spożywcze',1);           

INSERT INTO expense_tracker.transaction_subcategory (id_trans_cat, subcategory_name, subcategory_description, active)
     VALUES ((SELECT id_trans_cat 
    			FROM expense_tracker.transaction_category tc
    		   WHERE tc.category_name = 'TEST'), 'Zakupy spożywcze', 'Zakupy spożywcze',1);           

SELECT * FROM expense_tracker.transaction_subcategory;
SELECT * FROM expense_tracker.transaction_category;

-- OPCJA 3
INSERT INTO expense_tracker.transaction_subcategory (id_trans_cat, subcategory_name, subcategory_description, active)
     VALUES (CASE WHEN (SELECT id_trans_cat 
    					 FROM expense_tracker.transaction_category tc
 		     		    WHERE tc.category_name = 'TEST') IS NULL THEN -1 
 		     	  ELSE (SELECT id_trans_cat 
    					  FROM expense_tracker.transaction_category tc
 		    		     WHERE tc.category_name = 'TEST') END, 'Zakupy spożywcze', 'Zakupy spożywcze',1);       		  
    		  
INSERT INTO expense_tracker.transaction_category (id_trans_cat, category_name, category_description, active)
     VALUES (-1, '<unknown>', '<unknown>', 0);

    
INSERT INTO expense_tracker.transaction_subcategory (id_trans_cat, subcategory_name, subcategory_description, active)
     VALUES ((SELECT id_trans_cat 
    			FROM expense_tracker.transaction_category tc
    		   WHERE tc.category_name = 'TEST' 
    		      OR tc.id_trans_cat = -1
    		ORDER BY tc.id_trans_cat DESC 
    		   LIMIT 1), 'Zakupy spożywcze', 'Zakupy spożywcze',1);           

    		  
-- OPCJA 4 		    		    
INSERT INTO expense_tracker.transaction_subcategory (id_trans_cat, subcategory_name, subcategory_description, active)
 SELECT val.id_trans_cat, val.subcategory_name, val.subcategory_description, val.active
   FROM  (
      VALUES (2, 'Zakupy spożywcze', 'Zakupy spożywcze',1)
 	) val (id_trans_cat, subcategory_name, subcategory_description, active)
INNER JOIN expense_tracker.transaction_category USING (id_trans_cat)
ON CONFLICT (id_trans_subcat) DO NOTHING;    

--- OPCJA 5 TRIGGER
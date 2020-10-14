-- MERGE 
CREATE TABLE stock (item_id int UNIQUE, balance int);

INSERT INTO stock VALUES (10, 2200);
INSERT INTO stock VALUES (20, 1900);

CREATE TABLE buy (item_id int, volume int);

INSERT INTO buy values(10, 1000);
INSERT INTO buy values(30, 300);

MERGE INTO stock s
     USING buy b
        ON s.item_id = b.item_id
 WHEN MATCHED THEN UPDATE SET balance = balance + b.volume
 WHEN NOT MATCHED THEN INSERT VALUES (b.item_id, b.volume);

DROP TABLE stock_buy;

CREATE TABLE stock_buy (
	item_id INTEGER UNIQUE,
	balance INTEGER,
	bought_volume INTEGER
);

INSERT INTO stock_buy VALUES (10, 2200, 1000);

INSERT INTO stock_buy 
     VALUES (10, NULL, 2000)
ON CONFLICT (item_id)
  DO UPDATE SET balance = stock_buy.balance + EXCLUDED.bought_volume;

SELECT * FROM stock_buy;
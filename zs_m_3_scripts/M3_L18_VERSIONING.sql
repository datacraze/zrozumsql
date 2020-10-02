CREATE TABLE sales (
	id INTEGER,
	sales NUMERIC
);

ALTER TABLE sales ADD COLUMN description TEXT;

ALTER TABLE sales ADD CONSTRAINT sales_over_1k CHECK (sales > 1000);
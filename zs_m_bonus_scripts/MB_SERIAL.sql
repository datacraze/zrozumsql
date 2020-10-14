DROP TABLE IF EXISTS test_serial;

CREATE TABLE test_serial (
    id SMALLSERIAL,
    description TEXT
);

TRUNCATE TABLE test_serial RESTART IDENTITY;

INSERT INTO test_serial (description)
SELECT left(md5(i::text), 10) FROM generate_series(1,32767) gs(i);

SELECT * FROM test_serial;
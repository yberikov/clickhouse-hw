CREATE TABLE payments (
    id String,
    date Date,
    category String,
    purpose String,
    money Int32,
    payment_index Int32
) ENGINE = ReplacingMergeTree(payment_index)
ORDER BY (date, category, id);


CREATE MATERIALIZED VIEW payments_mv TO payments
AS SELECT
    JSONExtractString(value, 'id') AS id,
    toDate(JSONExtractString(value, 'date')) AS date,
    JSONExtractString(value, 'category') AS category,
    JSONExtractString(value, 'purpose') AS purpose,
    JSONExtractInt(value, 'money') AS money,
    JSONExtractInt(value, 'index') AS payment_index
FROM source
WHERE JSONExtractString(value, 'type') = 'payment';


SELECT category, sum(money) FROM payments FINAL GROUP BY category

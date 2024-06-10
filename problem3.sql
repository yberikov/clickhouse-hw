CREATE TABLE payments_for_parents
(
    `id` String,
    `date` Date,
    `category` String,
    `purpose` String,
    `money` Int32
)
ENGINE = MergeTree
ORDER BY date

INSERT INTO payments_for_parents (id, date, category, purpose, money) SELECT
    id,
    date,
    category,
    purpose,
    money
FROM payments
WHERE category NOT IN ('gaming', 'useless')

SELECT * FROM payments_for_parents;
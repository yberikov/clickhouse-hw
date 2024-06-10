-- Step 1:
CREATE TABLE IF NOT EXISTS source (
    value String
) ENGINE = Memory;

-- Step 2:
CREATE TABLE IF NOT EXISTS counters (
    id String,
    counter AggregateFunction(sum, Int64)
) ENGINE = AggregatingMergeTree()
ORDER BY id;

-- Step 3:
CREATE MATERIALIZED VIEW counters_mv TO counters
AS SELECT
    JSONExtractString(value, 'id') AS id,
    sumState(JSONExtractInt(value, 'value')) AS counter
FROM source
WHERE JSONExtractString(value, 'type') = 'counter'
GROUP BY id;

-- To fill the data: clickhouse-client --multiquery < /docker-entrypoint-initdb.d/dataset.sql

-- Step 4: Create the aggregated view for the counters table
SELECT
    id,
    sumMerge(counter) AS counter
FROM counters
GROUP BY id;

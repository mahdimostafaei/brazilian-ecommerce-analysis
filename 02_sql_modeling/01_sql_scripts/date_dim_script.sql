-- 1. Create the table
CREATE TABLE dim_date (
    date_key DATE PRIMARY KEY,
    year INTEGER,
    month INTEGER,
    month_name VARCHAR(20),
	year + month AS year_month INTEGER
    quarter INTEGER,
    day_of_week VARCHAR(20),
    is_weekend BOOLEAN
);

-- 2. Populate the table with a date range
INSERT INTO dim_date (date_key, year, month, month_name, quarter, day_of_week, is_weekend)
SELECT
    datum AS date_key,
    EXTRACT(YEAR FROM datum) AS year,
    EXTRACT(MONTH FROM datum) AS month,
    TO_CHAR(datum, 'Month') AS month_name,
    EXTRACT(QUARTER FROM datum) AS quarter,
    TO_CHAR(datum, 'Day') AS day_of_week,
    CASE WHEN EXTRACT(ISODOW FROM datum) IN (6, 7) THEN TRUE ELSE FALSE END AS is_weekend
FROM (
    -- Generate series from 2016-01-01 to 2018-12-31
    SELECT '2016-01-01'::DATE + sequence.day AS datum
    FROM generate_series(0, 1095) AS sequence(day)
) AS dq
WHERE datum <= '2018-12-31';

-- 3. Add an index for performance
CREATE INDEX idx_dim_date_year_month ON dim_date(year, month);

-- ALTERING THE TABLE
-- Add the integer year_month column
ALTER TABLE dim_date 
ADD COLUMN year_month INTEGER;

-- Add the formatted label column
ALTER TABLE dim_date 
ADD COLUMN year_month_label VARCHAR(20);

-- Update both columns with data
UPDATE dim_date 
SET 
    year_month = year * 100 + month,
    year_month_label = TO_CHAR(DATE(year || '-' || month || '-01'), 'Mon YYYY');

SELECT * FROM dim_date LIMIT 10;

-- Examining data in Google BigQuery for the first time and performing various checks for duplicates, errors, inconsistencies, ranges, etc.


-- 1) Append all monthly sales tables together

CREATE OR REPLACE TABLE `core.sales.sales_2025` AS
SELECT * FROM `core.sales.sales202501`
UNION ALL SELECT * FROM `core.sales.sales202502`
UNION ALL SELECT * FROM `core.sales.sales202503`
UNION ALL SELECT * FROM `core.sales.sales202504`
UNION ALL SELECT * FROM `core.sales.sales202505`
UNION ALL SELECT * FROM `core.sales.sales202506`
UNION ALL SELECT * FROM `core.sales.sales202507`
UNION ALL SELECT * FROM `core.sales.sales202508`
UNION ALL SELECT * FROM `core.sales.sales202509`
UNION ALL SELECT * FROM `core.sales.sales202510`
UNION ALL SELECT * FROM `core.sales.sales202511`
UNION ALL SELECT * FROM `core.sales.sales202512`
;


-- 2) Duplicate orders check

SELECT
    OrderID,
    COUNT(*) AS duplicate_id_count
FROM `core.sales.sales_2025`
GROUP BY 1
HAVING duplicate_id_count > 1
;


-- 3) Null check

SELECT
    SUM(CASE WHEN OrderID IS NULL THEN 1 ELSE 0 END) AS null_count_order_id,
    SUM(CASE WHEN CustomerID IS NULL THEN 1 ELSE 0 END) AS null_count_customer_id,
    SUM(CASE WHEN OrderDate IS NULL THEN 1 ELSE 0 END) AS null_count_order_date,
    SUM(CASE WHEN ProductType IS NULL THEN 1 ELSE 0 END) AS null_count_product_type,
    SUM(CASE WHEN OrderValue IS NULL THEN 1 ELSE 0 END) AS null_count_order_value
FROM `core.sales.sales_2025`
;


-- 4) Empty check for strings

SELECT
    SUM(CASE WHEN OrderID = '' THEN 1 ELSE 0 END) AS empty_count_order_id,
    SUM(CASE WHEN CustomerID = '' THEN 1 ELSE 0 END) AS empty_count_customer_id,
    SUM(CASE WHEN ProductType = '' THEN 1 ELSE 0 END) AS empty_count_product_type
FROM `core.sales.sales_2025`
;


-- 5) Check distinct product types for inconsistencies and typos

SELECT
    DISTINCT ProductType,
    COUNT(ProductType) AS count
FROM `core.sales.sales_2025`
GROUP BY 1
ORDER BY 1
;


-- 6) Check for length inconsistencies in CustomerID

SELECT
    CustomerID,
    LENGTH(CustomerID) AS length
FROM `core.sales.sales_2025`
WHERE LENGTH(CustomerID) != 8
;


-- 7) Examine order date ranges to verify 2025 date range

SELECT
    MIN(OrderDate) AS earliest_order_date,
    MAX(OrderDate) AS latest_order_date
FROM `core.sales.sales_2025`
;


-- 8) Examine order value ranges for outliers

SELECT
    MIN(OrderValue) AS min_price,
    MAX(OrderValue) AS max_price,
    AVG(OrderValue) AS avg_price,
    STDDEV(OrderValue) AS stddev_price,
    VARIANCE(OrderValue) AS variance_price
FROM `core.sales.sales_2025`
;

WITH price_validation AS (
SELECT 
    CASE 
        WHEN OrderValue IS NULL THEN 'missing_value'
        WHEN OrderValue < 0 THEN 'negative_value'
        WHEN OrderValue = 0 THEN 'zero_value'
        WHEN OrderValue > 1000 THEN 'suspiciously_high'
        ELSE 'valid'
    END AS validation_flag
FROM `core.sales.sales_2025`
)

SELECT
    validation_flag,
    COUNT(validation_flag) AS validation_flag_count
FROM price_validation
GROUP BY 1
ORDER BY 2 DESC
;


-- 9) Check for length inconsistencies in CustomerID

SELECT
    CustomerID,
    LENGTH(CustomerID) AS length
FROM `core.sales.sales_2025`
WHERE LENGTH(CustomerID) != 8
;
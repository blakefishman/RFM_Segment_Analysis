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


-- 2) Calculate recency, frequency, monetary, and r, f, m ranks into a new View

CREATE OR REPLACE VIEW `core.sales.rfm_metrics`
AS

WITH current_date AS (
  SELECT DATE('2026-03-06') AS analysis_date -- Today's (project hypothetical) date for analysis
),

rfm AS (
  SELECT
    CustomerID,
    MAX(OrderDate) AS last_order_date,
    DATE_DIFF((SELECT analysis_date FROM current_date), MAX(OrderDate), DAY) AS recency,
    COUNT(*) AS frequency,
    SUM(OrderValue) AS monetary
  FROM `core.sales.sales_2025`
  GROUP BY CustomerID
)

SELECT 
  rfm.*,
  DENSE_RANK() OVER(ORDER BY recency ASC) AS r_rank,
  DENSE_RANK() OVER(ORDER BY frequency DESC) AS f_rank,
  DENSE_RANK() OVER(ORDER BY monetary DESC) AS m_rank
FROM rfm
ORDER BY r_rank
;


-- 3) Assign decile scoring (10 = best, 1 = worst)

CREATE OR REPLACE VIEW `core.sales.rfm_scores`
AS

SELECT
  *,
  NTILE(10) OVER(order by r_rank DESC) as r_score,
  NTILE(10) OVER(order by f_rank DESC) as f_score,
  NTILE(10) OVER(order by m_rank DESC) as m_score
FROM `core.sales.rfm_metrics`
;


-- 4) Combine scores into total score

CREATE OR REPLACE VIEW `core.sales.rfm_total_scores`
AS

SELECT
  CustomerID,
  recency,
  frequency,
  monetary,
  r_score,
  f_score,
  m_score,
  (r_score + f_score + m_score) AS rfm_total_score
FROM `core.sales.rfm_scores`
ORDER BY rfm_total_score DESC
;


-- 5) Create final rfm segments table for analysis and visualization

CREATE OR REPLACE TABLE `core.sales.rfm_segments_final`
AS

SELECT
  CustomerID,
  recency,
  frequency,
  monetary,
  r_score,
  f_score,
  m_score,
  rfm_total_score,
  CASE
    WHEN rfm_total_score >= 28 THEN 'VIPs' -- 28-30
    WHEN rfm_total_score >= 24 THEN 'Loyalists' -- 24-27
    WHEN rfm_total_score >= 20 THEN 'Potential Loyalists'
    WHEN rfm_total_score >= 16 THEN 'Promising'
    WHEN rfm_total_score >= 12 THEN 'Engaged'
    WHEN rfm_total_score >= 8 THEN 'Requires Attention'
    WHEN rfm_total_score >= 4 THEN 'At Risk'
    ELSE 'Lost/Inactive'
  END AS rfm_segment
FROM `core.sales.rfm_total_scores`
ORDER BY rfm_total_score DESC
;
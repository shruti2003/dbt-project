{{ config(
    materialized='table'
) }}

WITH teams_by_country AS (
  SELECT
    t.noc,
    t.discipline,
    ARRAY_LENGTH(t.athletes_codes) AS num_athletes
  FROM
    {{ ref('Teams') }} t  -- Reference the Teams model
)

SELECT *
FROM (
  SELECT *,
    ROW_NUMBER() OVER (
      PARTITION BY noc, discipline
      ORDER BY num_athletes DESC
    ) AS row_num
  FROM teams_by_country
) t
WHERE row_num = 1

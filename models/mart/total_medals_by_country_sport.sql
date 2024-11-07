{{ config(
    materialized='table'
) }}

-- Total medals by country and sport
SELECT
  sm.sport_id,
  m.noc,
  SUM(CASE WHEN m.medal = 'Gold' THEN 1 ELSE 0 END) AS gold_won,
  SUM(CASE WHEN m.medal = 'Silver' THEN 1 ELSE 0 END) AS silver_won,
  SUM(CASE WHEN m.medal = 'Bronze' THEN 1 ELSE 0 END) AS bronze_won,
  COUNT(m.medal) AS total_medals
FROM
  {{ ref('Medal') }} m
JOIN
  {{ ref('Sport_Medals_Record') }} sm
ON
  m.sport_id = sm.sport_id
GROUP BY
  sm.sport_id, m.noc
ORDER BY
  total_medals DESC

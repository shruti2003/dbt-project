-- models/summer_olympics_medals_by_country.sql

{{ config(
    materialized='table'
) }}

SELECT
  c.country AS country_name,
  SUM(CASE WHEN som.medal = 'Gold' THEN 1 ELSE 0 END) AS gold_medals,
  SUM(CASE WHEN som.medal = 'Silver' THEN 1 ELSE 0 END) AS silver_medals,
  SUM(CASE WHEN som.medal = 'Bronze' THEN 1 ELSE 0 END) AS bronze_medals,
  COUNT(som.medal) AS total_medals
FROM
  {{ ref('Summer_Olympics_Medals') }} som
JOIN
  {{ ref('Country') }} c
ON
  som.noc = c.noc
GROUP BY
  country_name
ORDER BY
  total_medals DESC

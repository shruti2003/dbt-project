{{ config(
    materialized='table'
) }}

SELECT
  c.country AS country_name,
  SUM(CASE WHEN som.medal IS NOT NULL THEN 1 ELSE 0 END) AS summer_medals,
  SUM(CASE WHEN wom.medal IS NOT NULL THEN 1 ELSE 0 END) AS winter_medals,
  SUM(CASE WHEN som.medal IS NOT NULL AND wom.medal IS NOT NULL THEN 1 ELSE 0 END) AS both_seasons_medals,
  SUM(CASE WHEN som.medal IS NOT NULL AND wom.medal IS NULL THEN 1 ELSE 0 END) AS only_summer_medals,
  SUM(CASE WHEN som.medal IS NULL AND wom.medal IS NOT NULL THEN 1 ELSE 0 END) AS only_winter_medals
FROM
  {{ ref('Country') }} c
LEFT JOIN
  {{ ref('Summer_Olympics_Medals') }} som
ON
  c.noc = som.noc
LEFT JOIN
  {{ ref('Winter_Olympics_Medal') }} wom
ON
  c.noc = wom.noc
GROUP BY
  country_name
ORDER BY
  summer_medals DESC, winter_medals DESC

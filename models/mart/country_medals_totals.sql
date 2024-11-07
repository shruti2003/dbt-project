{{ config(
    materialized='table'
) }}

SELECT
  c.noc,
  c.gold,
  c.silver,
  c.bronze,
  c.gold + c.silver + c.bronze AS total_medals
FROM
  {{ ref('Country_Medals') }} c  -- Reference the Country_Medals model
ORDER BY
  total_medals DESC

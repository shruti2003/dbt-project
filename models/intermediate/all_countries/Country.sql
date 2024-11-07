WITH int_Country AS (
  -- Select noc and country from the all_countries table in the staging layer
  SELECT noc, country
  FROM {{ ref('all_countries') }} -- Reference to the staging layer table
)

SELECT *
FROM int_Country

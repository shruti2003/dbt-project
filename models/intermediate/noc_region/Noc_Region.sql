WITH distinct_nocs AS (
  SELECT 
    DISTINCT noc, 
    region
  FROM {{ ref('noc_regions') }} -- Reference the staging table
)

SELECT
    noc,
    region
FROM distinct_nocs

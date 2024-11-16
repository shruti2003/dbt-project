
WITH base_athletes AS (
  SELECT
    id,
    name,
    noc,
    year
  FROM {{ ref('Athlete') }} -- Reference the intermediate Athlete model
),

ranked_athletes AS (
  SELECT 
    *,
    ROW_NUMBER() OVER (
      PARTITION BY id, noc 
      ORDER BY year DESC
    ) AS row_num
  FROM base_athletes
)

SELECT 
  id,
  name,
  noc,
  year
FROM ranked_athletes
WHERE row_num = 1

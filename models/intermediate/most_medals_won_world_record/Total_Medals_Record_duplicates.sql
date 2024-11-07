WITH duplicate_check AS (
  SELECT first_name, last_name, num_medals, COUNT(*) AS count
  FROM {{ ref('Total_Medals_Record') }}  -- Reference to the intermediate layer
  GROUP BY first_name, last_name, num_medals
  HAVING COUNT(*) > 1
)

SELECT *
FROM duplicate_check
ORDER BY count DESC

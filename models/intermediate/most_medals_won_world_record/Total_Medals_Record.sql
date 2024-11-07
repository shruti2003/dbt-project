{{ config(
    post_hook=[
        "delete from {{ this }} where first_name = 'Oksana' and last_name = 'CHUSOVITINA' and num_medals = 8"
    ]
) }}

WITH int_Total_Medals_Record AS (
  SELECT
    num_medals,                   -- Number of medals won
    CONCAT(UPPER(SUBSTR(gender, 1, 1)), LOWER(SUBSTR(gender, 2))) AS gender,  -- Capitalize first letter, rest lowercase
    first_name,                   -- Athlete's first name
    last_name,                    -- Athlete's last name
    noc,                          -- National Olympic Committee code
    CONCAT(UPPER(SUBSTR(sport, 1, 1)), LOWER(SUBSTR(sport, 2))) AS sport,  -- Sport the athlete participated in
    ROW_NUMBER() OVER (
      PARTITION BY first_name, last_name, num_medals 
      ORDER BY first_name, last_name, num_medals
    ) AS row_num
  FROM {{ ref('most_medals_won_world_record') }}  -- Reference to the staging layer table
)

-- Select only the rows where row_num is 1, effectively removing duplicates
SELECT
  num_medals,
  gender,
  first_name,
  last_name,
  noc,
  sport
FROM int_Total_Medals_Record
WHERE row_num = 1

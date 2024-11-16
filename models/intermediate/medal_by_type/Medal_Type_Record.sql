WITH normalized_sports AS (
  SELECT 
    CONCAT(UPPER(SUBSTR(sport, 1, 1)), LOWER(SUBSTR(sport, 2))) AS normalized_sport,
    first_name,
    last_name,
    noc,
    start_year,
    end_year,
    gold_won,
    silver_won,
    bronze_won
  FROM {{ ref('most_medals_by_type_world_record') }}
),

joined_table AS (
  SELECT
    CONCAT(n.first_name, ' ', n.last_name) AS name,  -- Combine first_name and last_name
    e.sport_id AS sport_id,  -- Match sport_id from Event table
    n.noc,
    n.start_year,
    n.end_year,
    n.gold_won,
    n.silver_won,
    n.bronze_won,
    n.normalized_sport AS sport -- Use normalized sport name
  FROM normalized_sports AS n
  LEFT JOIN {{ ref('all_events') }} AS e
    ON n.normalized_sport = e.sport  -- Join with Event table using normalized sport names
)

SELECT *
FROM joined_table

WITH event_mapping AS (
  -- Extract the id for each sport from the all_events staging table
  SELECT 
    sport_id AS sport_id,
    sport
  FROM {{ ref('all_events') }} -- Reference the all_events staging table
),

transformed_athlete AS (
  SELECT
    a.id,
    SPLIT(a.games, ' ')[0] AS year,  -- Extract year from games
    e.sport_id,                     -- Add sport_id by joining with event_mapping
    a.name,
    a.sex,
    a.age,
    a.height,
    a.weight,
    a.team,
    a.noc,
    SPLIT(a.games, ' ')[1] AS season, -- Extract season from games
    a.city,
    a.sport,
    a.event,
    a.medal
  FROM {{ ref('athlete_details_by_event') }} AS a  -- Reference the staging table for athletes
  LEFT JOIN event_mapping AS e                    -- Join with event_mapping to get sport_id
    ON a.sport = e.sport                          -- Match the sport name to fetch sport_id
)

SELECT *
FROM transformed_athlete

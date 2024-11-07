WITH int_Event AS (
  -- Select sport_id and sport from the all_events table in the staging layer
  SELECT sport_id, sport
  FROM {{ ref('all_events') }} -- Reference to the staging layer table
)

SELECT *
FROM int_Event

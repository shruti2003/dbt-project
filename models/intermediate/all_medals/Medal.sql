-- models/intermediate/medal.sql

WITH int_medal AS (
    -- Select distinct rows to remove duplicates based on unique identifiers
    SELECT DISTINCT *
    FROM {{ ref('all_medals') }}  -- Using ref to reference all_medals
)

SELECT
    medalist_id,
    year,
    athlete,
    noc,
    gender,
    event,
    CASE
        WHEN medal_value = 1 THEN 'Gold'
        WHEN medal_value = 2 THEN 'Silver'
        WHEN medal_value = 3 THEN 'Bronze'
        ELSE NULL  -- Handle cases where `medal_value` is not 1, 2, or 3
    END AS medal,
    season,
    medal_value,
    sport_id
FROM int_medal
WHERE
    medalist_id IS NOT NULL
    AND year IS NOT NULL
    AND athlete IS NOT NULL
    AND noc IS NOT NULL
    AND event IS NOT NULL
    AND season IS NOT NULL
    AND medal_value IS NOT NULL
    AND sport_id IS NOT NULL

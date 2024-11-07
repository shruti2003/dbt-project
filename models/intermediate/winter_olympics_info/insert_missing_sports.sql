-- models/incremental/insert_missing_sports.sql

WITH new_sports AS (
    SELECT DISTINCT
        s.sport
    FROM
        {{ ref('winter_olympics_info') }} AS s  -- Source model for Winter Olympics info
    LEFT JOIN
        {{ ref('all_events') }} AS e  -- Existing Event model
    ON
        s.sport = e.sport
    WHERE
        e.sport IS NULL  -- Find sports that don’t exist in the Event table
)

-- Insert new sports into the Event model
SELECT
    ROW_NUMBER() OVER () + (SELECT MAX(sport_id) FROM {{ ref('all_events') }}) AS sport_id,
    sport
FROM
    new_sports

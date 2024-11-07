-- models/intermediate/winter_olympics_medal.sql

WITH winter_olympics_medal AS (
    SELECT
        year,
        discipline,
        event,
        noc,
        event_gender,
        medal,
        city,
        e.sport_id AS sport_id  -- Changing 'sport' to 'sport_id' from the 'Event' model
    FROM
        {{ ref('winter_olympics_info') }} AS s  -- Reference the 'winter_olympics_info' source model
    LEFT JOIN
        {{ ref('Events') }} AS e  -- Reference the 'Event' model to get sport_id
    ON
        s.sport = e.sport  -- Joining to get the sport_id from all_events
)

-- Create the 'Winter_Olympics_Medal' table
SELECT * FROM winter_olympics_medal

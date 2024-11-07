-- models/intermediate/summer_olympics_medal.sql

WITH summer_olympics_medal AS (
    SELECT
        athlete AS name,
        year,
        event,
        medal,
        city,
        e.sport_ID AS sport_id,  -- Changing sport to sport_id from all_events
        discipline,
        noc,
        gender,
        event_gender
    FROM
        {{ ref('summer_olympics_info') }} AS s  -- Reference the summer olympics info model
    LEFT JOIN
        {{ ref('all_events') }} AS e  -- Reference the Event model to get sport_id
    ON
        s.sport = e.sport  -- Joining to get the sport_id from the Event model
)

-- Deduplicate by row number
SELECT * EXCEPT(row_num)
FROM (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY name, year, event, medal
            ORDER BY medal DESC
        ) AS row_num
    FROM summer_olympics_medal
) AS t
WHERE row_num = 1

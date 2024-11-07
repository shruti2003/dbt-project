{{ config(
    materialized='table'
) }}

WITH winter_olympics_medals AS (
    SELECT
        c.country AS country_name,
        SUM(CASE WHEN wom.medal = 'Gold' THEN 1 ELSE 0 END) AS gold_medals,
        SUM(CASE WHEN wom.medal = 'Silver' THEN 1 ELSE 0 END) AS silver_medals,
        SUM(CASE WHEN wom.medal = 'Bronze' THEN 1 ELSE 0 END) AS bronze_medals,
        COUNT(wom.medal) AS total_medals
    FROM
        {{ ref('Winter_Olympics_Medal') }} wom
    JOIN
        {{ ref('Country') }} c
    ON
        wom.noc = c.noc
    GROUP BY
        country_name
)

SELECT *
FROM winter_olympics_medals
ORDER BY total_medals DESC

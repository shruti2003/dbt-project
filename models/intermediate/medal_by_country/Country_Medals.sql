-- country_medals.sql
WITH country_data AS (
    -- Step 1: Create a new table with NOC instead of country
    SELECT
        c.noc AS noc,
        m.bronze,
        m.silver,
        m.gold
    FROM
        {{ ref('medal_by_country') }} AS m  -- Reference to the source table
    JOIN
        {{ ref('all_countries') }} AS c
    ON
        m.country = c.country
),
cleaned_data AS (
    -- Step 2: Remove duplicates based on NOC
    SELECT
        noc,
        bronze,
        silver,
        gold,
        ROW_NUMBER() OVER (PARTITION BY noc ORDER BY bronze DESC) AS row_num
    FROM country_data
),
final_output AS (
    -- Step 3: Filter to get only the first occurrence for each NOC (deduplicated)
    SELECT
        noc,
        bronze,
        silver,
        gold
    FROM cleaned_data
    WHERE row_num = 1
)

-- Step 4: Final table creation
SELECT * FROM final_output

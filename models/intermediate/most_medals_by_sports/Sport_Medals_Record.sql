WITH normalized_medals AS (
    SELECT
        CONCAT(first_name, ' ', last_name) AS name,  -- Consolidating first_name and last_name into name
        e.sport_ID AS sport_id,  -- Changing sport to sport_id from all_events
        noc,
        start_year,  -- Keeping start_year as is
        end_year,      -- Keeping end_year as is
        gold_won,  -- Keeping gold_won as is
        silver_won,  -- Keeping silver_won as is
        bronze_won,   -- Keeping bronze_won as is
        CONCAT(UPPER(SUBSTR(m.sport, 1, 1)), LOWER(SUBSTR(m.sport, 2))) AS sport  -- Capitalizing the first letter of the sport
    FROM
        {{ ref('most_medals_by_type_world_record') }} AS m  -- Reference the source model
    LEFT JOIN
        {{ ref('all_events') }} AS e  -- Reference the Event model to get sport_id
    ON
        CONCAT(UPPER(SUBSTR(m.sport, 1, 1)), LOWER(SUBSTR(m.sport, 2))) = e.sport  -- Normalizing sport names when joining
),

-- Remove records where sport_id is null (Check for missing matches)
cleaned_medals AS (
    SELECT
        *
    FROM normalized_medals
    WHERE sport_id IS NOT NULL  -- Filter out rows with null sport_id
),

-- Remove duplicate rows for the same name and sport_id
final_medals AS (
    SELECT * EXCEPT(row_num)
    FROM (
        SELECT *,
            ROW_NUMBER() OVER (
                PARTITION BY name, sport_id
                ORDER BY name DESC
            ) AS row_num
        FROM cleaned_medals
    ) t
    WHERE row_num = 1  -- Keep only the first instance of duplicate rows
)

-- Final SELECT statement (without CREATE)
SELECT
    sport_id,
    name,
    noc,
    start_year,
    end_year,
    gold_won,
    silver_won,
    bronze_won
FROM final_medals

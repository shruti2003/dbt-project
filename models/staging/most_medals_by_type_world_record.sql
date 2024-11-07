WITH stg_most_medals_by_type_world_record AS (
  SELECT
    first_name,
    last_name,
    country AS noc,  -- Renaming country to noc
    sport,
    SAFE_CAST(start_year AS INTEGER) AS start_year,
    SAFE_CAST(start_year AS INTEGER) AS end_year,  -- Adjusted to use start_year for end_year
    CASE
        WHEN SAFE_CAST(gold_won AS INTEGER) IS NULL THEN NULL
        ELSE SAFE_CAST(gold_won AS INTEGER)
    END AS gold_won,
    CASE
        WHEN SAFE_CAST(silver_won AS INTEGER) IS NULL THEN NULL
        ELSE SAFE_CAST(silver_won AS INTEGER)
    END AS silver_won,
    CASE
        WHEN SAFE_CAST(bronze_won AS INTEGER) IS NULL THEN NULL
        ELSE SAFE_CAST(bronze_won AS INTEGER)
    END AS bronze_won,
    _data_source,
    _load_time
  FROM {{ source('olympics_analysis_cs378_raw', 'most_medals_by_type_world_record') }}
)

SELECT * FROM stg_most_medals_by_type_world_record

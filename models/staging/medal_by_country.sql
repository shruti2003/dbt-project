WITH stg_all_medals AS (
  SELECT
    country,
    CAST(bronze AS INTEGER) AS bronze,  -- Renaming edition to year
    CAST(silver AS INTEGER) AS silver,
    CAST(gold AS INTEGER) AS gold,
    _data_source,
    _load_time
  FROM {{ source('olympics_analysis_cs378_raw', 'medal_by_country') }}
)

SELECT * FROM stg_all_medals

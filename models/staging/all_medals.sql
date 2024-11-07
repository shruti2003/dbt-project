WITH stg_all_medals AS (
  SELECT
    medalist_id,
    CAST(edition AS INTEGER) AS year,  -- Renaming edition to year
    athlete,
    noc,
    gender,
    event,
    medal,
    season,
    medal_value,
    sport_id,
    discipline_id,
    _data_source,
    _load_time
  FROM {{ source('olympics_analysis_cs378_raw', 'all_medals') }}
)

SELECT * FROM stg_all_medals

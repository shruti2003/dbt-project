WITH stg_summer AS (
  SELECT
    city,
    CAST(edition AS INTEGER) AS year,  -- Renaming edition to year
    sport,
    discipline,
    athlete,
    noc,
    gender, 
    event, 
    event_gender, 
    medal,
    _data_source,
    _load_time
  FROM {{ source('olympics_analysis_cs378_raw', 'summer_olympics_info') }}
)

SELECT * FROM stg_summer

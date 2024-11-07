WITH stg_winter AS (
  SELECT
    year,
    city,
    sport,
    discipline,
    noc,
    event,
    event_gender,  
    medal,
    _data_source,
    _load_time
  FROM {{ source('olympics_analysis_cs378_raw', 'winter_olympics_info') }}
)

SELECT * FROM stg_winter

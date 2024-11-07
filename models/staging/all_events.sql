WITH stg_all_events AS (
  SELECT
    sport,
    CAST(sport_id AS INTEGER) AS sport_id,
    _data_source,
    _load_time
  FROM {{ source('olympics_analysis_cs378_raw', 'all_events') }}
)

SELECT * FROM stg_all_events

WITH stg_all_countries AS (
  SELECT
    int_olympic_committee_code AS noc,
    country,
    _data_source,
    _load_time
  FROM {{ source('olympics_analysis_cs378_raw', 'all_countries') }}
)

SELECT * FROM stg_all_countries

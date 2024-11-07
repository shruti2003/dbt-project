WITH stg_noc_regions AS (
  SELECT
    noc,
    region,
    _data_source,
    _load_time
  FROM {{ source('olympics_analysis_cs378_raw', 'noc_regions') }}
)

SELECT * FROM stg_noc_regions

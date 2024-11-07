WITH stg_most_medals_won_world_record AS (
  SELECT
    num_medals,
    gender,
    first_name,
    last_name,
    country AS noc,  -- Renaming country to noc
    sport,
    _data_source,
    _load_time
  FROM {{ source('olympics_analysis_cs378_raw', 'most_medals_won_world_record') }}
)

SELECT * FROM stg_most_medals_won_world_record


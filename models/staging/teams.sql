WITH stg_teams AS (
  SELECT
    code,
    `current`,  -- Escaping the keyword "current"
    team,
    team_gender,
    country_code AS noc,
    country,
    country_long,
    discipline,
    disciplines_code,  -- Keep as STRING
    events,  -- Keep as STRING
    SPLIT(athletes, ',') AS athletes,  -- Split string by comma to create an ARRAY<STRING>
    SPLIT(coaches, ',') AS coaches_codes,  -- Split string by comma to create an ARRAY<STRING>
    SPLIT(athletes_codes, ',') AS athletes_codes,  -- Split string by comma to create an ARRAY<STRING>
    SAFE_CAST(num_athletes AS INTEGER) AS num_athletes,  -- Cast to INTEGER
    coaches_code,  -- Keep as STRING
    SAFE_CAST(num_coaches AS INTEGER) AS num_coaches,  -- Cast to INTEGER
    _data_source,
    _load_time
  FROM {{ source('olympics_analysis_cs378_raw', 'teams') }}
)

SELECT * FROM stg_teams

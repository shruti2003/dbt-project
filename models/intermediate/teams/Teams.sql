-- models/intermediate/teams.sql

SELECT
    code,
    `current`,  -- Escaping the keyword "current"
    team,
    event_gender,
    noc,  -- Alias for country_code
    country,
    country_long,
    discipline,
    disciplines_code,  -- Keep as STRING
    events,  -- Keep as STRING
    athletes,  -- Keep as ARRAY<STRING>
    coaches_codes,  -- Keep as ARRAY<STRING>
    athletes_codes,  -- Keep as ARRAY<STRING>
    num_athletes,  -- Keep as INT64
    coaches_code,  -- Keep as STRING
    num_coaches  -- Keep as INT64
FROM
    {{ ref('tmp_teams') }}

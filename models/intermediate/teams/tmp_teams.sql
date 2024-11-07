-- models/staging/tmp_teams.sql

SELECT
    code,
    `current`,  -- Escaping the keyword "current"
    team,
    team_gender AS event_gender, -- Renamed for consistency
    noc,
    country,
    country_long,
    discipline,
    disciplines_code,  -- Keep as STRING
    events,  -- Keep as STRING
    CAST(athletes AS ARRAY<STRING>) AS athletes,  -- Cast to ARRAY<STRING>
    CAST(coaches_codes AS ARRAY<STRING>) AS coaches_codes,  -- Cast to ARRAY<STRING>
    CAST(athletes_codes AS ARRAY<STRING>) AS athletes_codes,  -- Cast to ARRAY<STRING>
    SAFE_CAST(num_athletes AS INT64) AS num_athletes,  -- Cast to INT64
    coaches_code,  -- Keep as STRING
    SAFE_CAST(num_coaches AS INT64) AS num_coaches  -- Cast to INT64
FROM
    {{ ref('teams') }}  -- Referencing the actual source table or model if different

WITH stg_athletes AS (
  SELECT
    id,
    name,
    sex,
    CASE
      WHEN age = 'NA' THEN NULL
      ELSE CAST(age AS INT64)
      END AS age,
    CASE
      WHEN height = 'NA' THEN NULL
      ELSE CAST(height AS FLOAT64)
      END AS height,
    CASE
      WHEN weight = 'NA' THEN NULL
      ELSE CAST(weight AS FLOAT64)
      END AS weight,
    team,
    noc,
    games,
    year, 
    season,
    city,
    sport,
    event, 
    CASE
      WHEN medal = 'NA' THEN NULL
      ELSE medal
      END AS medal,
    _data_source,
    _load_time
  FROM {{ source('olympics_analysis_cs378_raw', 'athlete_details_by_event') }}
)

SELECT * FROM stg_athletes

-- models/Discipline_Code.sql

WITH distinct_disciplines AS (
  SELECT DISTINCT
    discipline,
    disciplines_code
  FROM {{ ref('teams') }} -- Reference the staging table
),

discipline_with_id AS (
  SELECT
    ROW_NUMBER() OVER () AS id, -- Generate a unique, auto-incrementing ID
    disciplines_code,
    discipline
  FROM distinct_disciplines
)

SELECT *
FROM discipline_with_id

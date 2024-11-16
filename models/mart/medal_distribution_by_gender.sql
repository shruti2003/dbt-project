WITH medal_distribution AS (
  SELECT
    m.gender,
    m.season,
    SUM(CASE WHEN m.medal = 'Gold' THEN 1 ELSE 0 END) AS gold_medals,
    SUM(CASE WHEN m.medal = 'Silver' THEN 1 ELSE 0 END) AS silver_medals,
    SUM(CASE WHEN m.medal = 'Bronze' THEN 1 ELSE 0 END) AS bronze_medals,
    COUNT(m.medal) AS total_medals
  FROM {{ ref('Medal') }} AS m  -- Alias for Medal table
  GROUP BY m.gender, m.season  -- Use alias to refer to columns
)

SELECT
  gender,
  season,
  gold_medals,
  silver_medals,
  bronze_medals,
  total_medals
FROM medal_distribution
ORDER BY total_medals DESC

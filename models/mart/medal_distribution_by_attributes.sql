WITH categorized_athletes AS (
  SELECT
    CASE
      WHEN age < 20 THEN '<20'
      WHEN age BETWEEN 20 AND 29 THEN '20-29'
      WHEN age BETWEEN 30 AND 39 THEN '30-39'
      WHEN age BETWEEN 40 AND 49 THEN '40-49'
      ELSE '50+'
    END AS age_group,

    CASE
      WHEN height < 150 THEN '<150 cm'
      WHEN height BETWEEN 150 AND 159 THEN '150-159 cm'
      WHEN height BETWEEN 160 AND 169 THEN '160-169 cm'
      WHEN height BETWEEN 170 AND 179 THEN '170-179 cm'
      WHEN height BETWEEN 180 AND 189 THEN '180-189 cm'
      ELSE '190+ cm'
    END AS height_group,

    CASE
      WHEN weight < 50 THEN '<50 kg'
      WHEN weight BETWEEN 50 AND 59 THEN '50-59 kg'
      WHEN weight BETWEEN 60 AND 69 THEN '60-69 kg'
      WHEN weight BETWEEN 70 AND 79 THEN '70-79 kg'
      WHEN weight BETWEEN 80 AND 89 THEN '80-89 kg'
      ELSE '90+ kg'
    END AS weight_group,

    id AS athlete_id
  FROM {{ ref('Athlete') }} -- Reference the Athlete table
),

medal_counts AS (
  SELECT
    a.age_group,
    a.height_group,
    a.weight_group,
    COUNT(m.medal) AS total_medals,
    SUM(CASE WHEN m.medal = 'Gold' THEN 1 ELSE 0 END) AS gold_medals,
    SUM(CASE WHEN m.medal = 'Silver' THEN 1 ELSE 0 END) AS silver_medals,
    SUM(CASE WHEN m.medal = 'Bronze' THEN 1 ELSE 0 END) AS bronze_medals
  FROM categorized_athletes AS a
  LEFT JOIN {{ ref('Medal') }} AS m -- Reference the Medal table
    ON a.athlete_id = m.medalist_id
  GROUP BY a.age_group, a.height_group, a.weight_group
)

SELECT
  age_group,
  height_group,
  weight_group,
  total_medals,
  gold_medals,
  silver_medals,
  bronze_medals
FROM medal_counts
ORDER BY total_medals DESC

{{ config(
    materialized='table'
) }}

with summer_medals as (
    -- Summarizing total summer medals by country
    select 
        c.country as country_name,
        count(som.medal) as total_medals
    from 
        {{ ref('Summer_Olympics_Medals') }} som
    join 
        {{ ref('Country') }} c on som.noc = c.noc
    group by c.country
),

winter_medals as (
    -- Summarizing total winter medals by country
    select 
        c.country as country_name,
        count(wom.medal) as total_medals
    from 
        {{ ref('Winter_Olympics_Medal') }} wom
    join 
        {{ ref('Country') }} c on wom.noc = c.noc
    group by c.country
),

summer_winter_correlation as (
    -- Joining summer and winter medals data
    select 
        summer.country_name,
        summer.total_medals as summer_medals,
        winter.total_medals as winter_medals
    from 
        summer_medals summer
    join 
        winter_medals winter on summer.country_name = winter.country_name
),

correlation as (
    -- Calculating the correlation coefficient between summer and winter medals
    select
        corr(summer_medals, winter_medals) as correlation_value
    from 
        summer_winter_correlation
)

select 
    summer_winter_correlation.*, 
    round(correlation.correlation_value, 2) as correlation_coefficient
from 
    summer_winter_correlation
cross join 
    correlation
order by 
    correlation_coefficient desc

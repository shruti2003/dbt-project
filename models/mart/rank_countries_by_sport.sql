{{ config(
    materialized='table'
) }}

with ranked_countries_by_sport as (
    -- Rank countries by sport based on total medals
    select
        sport_id,
        noc,
        total_medals,
        gold_won,
        silver_won,
        bronze_won,
        rank() over (partition by sport_id order by total_medals desc) as rank
    from 
        {{ ref('total_medals_by_country_sport') }}  -- Reference to the total_medals_by_country_sport model
)

select *
from ranked_countries_by_sport

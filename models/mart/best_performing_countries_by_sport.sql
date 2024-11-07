{{ config(
    materialized='table'
) }}

with best_performing_countries as (
    -- Select the best-performing countries by sport based on rank
    select
        r.sport_id,
        e.sport as sport,  -- Get the sport name from the Event table
        r.noc,
        r.total_medals,
        r.gold_won,
        r.silver_won,
        r.bronze_won
    from
        {{ ref('rank_countries_by_sport') }} r  -- Reference to the rank_countries_by_sport model
    join
        {{ ref('Events') }} e  -- Reference to the Event model
    on
        r.sport_id = e.sport_id
    where
        r.rank = 1  -- Only select the best-performing country for each sport
)

select *
from best_performing_countries

{{ config(materialized='table') }}

with date_spine as (

    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="cast('2018-01-01' as date)",
        end_date="cast('2030-12-31' as date)"
    ) }}

)

select
    date_day as date,
    extract(year from date_day) as year,
    extract(month from date_day) as month,
    extract(day from date_day) as day,
    extract(quarter from date_day) as quarter,
    extract(week from date_day) as week,
    case
        when extract(dayofweek from date_day) in (1, 7) then true
        else false
    end as is_weekend
from date_spine
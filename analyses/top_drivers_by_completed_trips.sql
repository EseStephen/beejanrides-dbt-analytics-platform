select
    driver_id,
    count(*) as completed_trips,
    sum(actual_fare) as total_fare
from {{ ref('fact_trips') }}
where status = 'completed'
group by 1
order by completed_trips desc, total_fare desc
limit 10;

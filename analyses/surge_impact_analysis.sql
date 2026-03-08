select
    extreme_surge_multiplier,
    count(*) as trip_count,
    avg(actual_fare) as avg_actual_fare
from {{ ref('fact_trips') }}
group by 1;
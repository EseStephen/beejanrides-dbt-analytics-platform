select
    t.corporate_trip_flag,
    sum(p.net_revenue) as net_revenue,
    sum(p.amount) as gross_revenue
from {{ ref('fact_trips') }} t
join {{ ref('fact_payments') }} p
    on t.trip_id = p.trip_id
group by 1;
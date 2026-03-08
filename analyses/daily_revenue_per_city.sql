select
    c.city_name,
    date(t.created_at) as trip_date,
    sum(p.net_revenue) as daily_net_revenue,
    sum(p.amount) as daily_gross_revenue
from {{ ref('fact_payments') }} p
join {{ ref('fact_trips') }} t
    on p.trip_id = t.trip_id
join {{ ref('dim_city') }} c
    on t.city_id = c.city_id
group by 1, 2
order by 2, 1;
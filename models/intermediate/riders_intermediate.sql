{{
    config(
        materialized = 'incremental',
        meta = {'keys': ['rider_id']}
    )

}}

with rider_payments as (
    select
        t.rider_id,
        sum(p.amount) as rider_lifetime_value
    from {{ ref('trips_staging') }} t
    join {{ ref('payments_staging') }} p
        on t.trip_id = p.trip_id
    where p.payment_status = 'success'
    group by t.rider_id
)

select
    r.rider_id,    
    rp.rider_lifetime_value,
    r.country,
    r.referral_code,
    r.created_at,
    r.signup_date
FROM
{{ ref('riders_staging') }} r
LEFT JOIN
rider_payments rp
ON
r.rider_id = rp.rider_id
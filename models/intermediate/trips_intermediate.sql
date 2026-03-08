{{
    config(
        materialized = 'incremental',
        meta = {'keys': ['trip_id']}
    )

}}

with duplicate_payments as (
    select
        trip_id,
        count(*) as payment_count
    from {{ ref('payments_staging') }}
    where payment_status = 'success'
    group by trip_id
),

latest_payment as (
    select
        trip_id,
        created_at,
        payment_status,
        row_number() over (partition by trip_id order by created_at desc) as row_num
    from {{ ref('payments_staging') }} lp
)

select
    t.trip_id,
    vehicle_id,
    driver_id,
    rider_id,
    city_id,
    actual_fare,
    estimated_fare,
    payment_method,
    is_corporate,
    CASE
    WHEN is_corporate = true 
    THEN "corporate" else "personal" 
    END AS corporate_trip_flag,
    t.created_at,
    updated_at,
    dropoff_at,
    pickup_at,
    requested_at,
    TIMESTAMP_DIFF(dropoff_at, pickup_at, MINUTE) as trip_duration_minutes,
    status,
    surge_multiplier,
    CASE
    WHEN surge_multiplier > 10 
    THEN 1 else 0 
    END AS extreme_surge_multiplier,
    CASE
    WHEN payment_status = 'failed'
    AND status = 'completed'
    THEN 1 else 0 
    END AS failed_payment_flag,
    CASE 
    WHEN t.status = 'cancelled' 
    AND lp.payment_status = 'success' 
    THEN 1 
    ELSE 0 
    END AS fraud_indicator,
    CASE 
    WHEN dp.payment_count > 1 
    THEN 1 
    ELSE 0 
    END AS duplicate_trip_payment_flag
FROM
{{ ref('trips_staging') }} t

LEFT JOIN
latest_payment lp
ON lp.trip_id = t.trip_id and lp.row_num = 1
left join 
duplicate_payments dp
ON 
t.trip_id = dp.trip_id
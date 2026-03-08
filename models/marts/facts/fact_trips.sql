{{
    config(
        materialized = 'incremental',
        meta = {'keys': ['trip_id']}
    )
}}

SELECT
    t.trip_id,
    t.vehicle_id,
    t.driver_id,
    t.rider_id,
    t.city_id,
    t.created_at,
    t.updated_at,
    dropoff_at,
    pickup_at,
    requested_at,
    surge_multiplier,
    payment_method,
    is_corporate,
    corporate_trip_flag,
    status,
    actual_fare,
    estimated_fare,
    trip_duration_minutes,
    d.driver_lifetime_trips,
    r.rider_lifetime_value,
    extreme_surge_multiplier,
    failed_payment_flag,
    fraud_indicator,
    duplicate_trip_payment_flag
FROM 
{{ ref('trips_intermediate') }} t
LEFT JOIN
{{ ref('drivers_intermediate') }} d
ON
t.driver_id = d.driver_id
LEFT JOIN
{{ ref('riders_intermediate') }} r
ON
t.rider_id = r.rider_id
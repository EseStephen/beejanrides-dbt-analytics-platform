{{
    config(
        materialized = 'incremental',
        meta = {'keys': ['trip_id']}
    )

}}

select
    trip_id,
    vehicle_id,
    driver_id,
    rider_id,
    city_id,
    actual_fare,
    estimated_fare,
    payment_method,
    is_corporate,
    CAST(created_at AS TIMESTAMP) AS created_at,
    CAST(updated_at AS TIMESTAMP) AS updated_at,
    CAST(dropoff_at AS TIMESTAMP) AS dropoff_at,
    CAST(pickup_at AS TIMESTAMP) AS pickup_at,
    CAST(requested_at AS TIMESTAMP) AS requested_at,
    status,
    surge_multiplier
FROM
{{ source('raw', 'trips_raw') }}
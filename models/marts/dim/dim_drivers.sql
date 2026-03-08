{{
    config(
        materialized = 'incremental',
        meta = {'keys': ['driver_id']}
    )
}}

select
    city_id,
    driver_id,
    rating,
    vehicle_id,
    driver_status,
    onboarding_date,
    created_at,
    updated_at
FROM {{ ref('drivers_intermediate') }}
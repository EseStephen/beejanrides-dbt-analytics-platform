{{
    config(
        materialized = 'incremental',
        meta = {'keys': ['driver_id']}
    )

}}

select
    city_id,
    driver_id,
    vehicle_id,
    driver_status,
    CAST(onboarding_date AS TIMESTAMP) AS onboarding_date,
    rating,
    CAST(created_at AS TIMESTAMP) AS created_at,
    CAST(updated_at AS TIMESTAMP) AS updated_at
FROM
{{ source('raw', 'drivers_raw') }}
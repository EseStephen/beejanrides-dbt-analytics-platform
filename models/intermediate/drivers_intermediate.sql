{{
    config(
        materialized = 'incremental',
        meta = {'keys': ['driver_id']}
    )

}}

with driver_trips as (
    select
        driver_id,
        count(*) as driver_lifetime_trips
    from {{ ref('trips_staging') }}
    where status = 'completed'
    group by driver_id
)

select
    d.city_id,
    d.driver_id,
    dt.driver_lifetime_trips,
    d.vehicle_id,
    d.driver_status,
    d.onboarding_date,
    rating,
    d.created_at,
    d.updated_at
FROM
{{ ref('drivers_staging') }} d
LEFT JOIN
driver_trips dt
ON d.driver_id = dt.driver_id
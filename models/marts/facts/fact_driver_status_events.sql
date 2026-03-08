{{
    config(
        materialized = 'incremental',
        meta = {'keys': ['event_id']}
    )
}}

select
    driver_id,
    event_id,
    event_timestamp,
    status
FROM {{ ref('driver_status_events_intermediate') }}
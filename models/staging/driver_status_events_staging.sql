{{
    config(
        materialized = 'incremental',
        meta = {'keys': ['event_id']}
    )

}}

select
    driver_id,
    event_id,
    CAST(event_timestamp AS TIMESTAMP) AS event_timestamp,
    status
FROM
{{ source('raw', 'driver_status_events_raw') }}
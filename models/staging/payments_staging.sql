{{
    config(
        materialized = 'incremental',
        meta = {'keys': ['payment_id']}
    )

}}

select
    payment_id,
    trip_id,
    payment_provider,
    payment_status,
    currency,
    fee,
    amount,
    CAST(created_at AS TIMESTAMP) AS created_at
FROM
{{ source('raw', 'payments_raw') }}
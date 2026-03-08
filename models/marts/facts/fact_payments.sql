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
    net_revenue,
    created_at
FROM {{ ref('payments_intermediate') }}
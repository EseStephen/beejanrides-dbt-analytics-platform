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
    {{ subtract('amount', 'fee', 2) }} as net_revenue,
    created_at
FROM
{{ ref('payments_staging') }}
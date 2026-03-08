{{
    config(
        materialized = 'incremental',
        meta = {'keys': ['rider_id']}
    )

}}

select
    rider_id,
    country,
    referral_code,
    CAST(created_at AS TIMESTAMP) AS created_at,
    CAST(signup_date AS TIMESTAMP) AS signup_date
FROM
{{ source('raw', 'riders_raw') }}
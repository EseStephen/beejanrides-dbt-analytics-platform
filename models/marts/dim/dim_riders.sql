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
    created_at,
    signup_date
FROM {{ ref('riders_intermediate') }}
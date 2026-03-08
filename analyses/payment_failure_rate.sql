select
    round(
        sum(case when payment_status = 'failed' then 1 else 0 end)
        / count(*),
        4
    ) as payment_failure_rate
from {{ ref('fact_payments') }};
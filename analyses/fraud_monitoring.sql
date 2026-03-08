select
    trip_id,
    driver_id,
    rider_id,
    status,
    fraud_indicator,
    duplicate_trip_payment_flag,
    failed_payment_flag
from {{ ref('fact_trips') }}
where fraud_indicator = 1
   or duplicate_trip_payment_flag = 1
   or failed_payment_flag = 1;
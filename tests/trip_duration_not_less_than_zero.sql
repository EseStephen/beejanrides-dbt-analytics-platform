SELECT *
FROM 
{{ ref('fact_trips') }}
WHERE trip_duration_minutes < 0
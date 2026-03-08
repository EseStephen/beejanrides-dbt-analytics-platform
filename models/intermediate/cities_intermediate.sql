    {{
        config(
            materialized = 'incremental',
            meta = {'keys': ['city_id']}
        )

    }}

    select
        city_id,
        city_name,
        country,
        launch_date
    FROM
    {{ ref('cities_staging') }}
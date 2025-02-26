{{
    config(
        materialized='view'
    )
}}

with fact_trips_dim as (
    select
        *,
        EXTRACT(YEAR from pickup_datetime) as year,
        EXTRACT(MONTH from pickup_datetime) as month,
        EXTRACT(QUARTER from pickup_datetime) as quarter
    from
        {{ ref('fact_trips') }}
)

select
    *,
    CONCAT(CAST(year as STRING), '-', CAST(quarter as STRING)) as year_quarter
from
    fact_trips_dim
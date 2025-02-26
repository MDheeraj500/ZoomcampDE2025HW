{{
    config(
        materialized="view"
    )
}}

With filtered_data as(
    select
        *
    from
        {{ ref('fact_trips_dim') }}
    where
        fare_amount >0 
        AND trip_distance > 0
        AND payment_type_description in ('Cash', 'Credit Card')
) 

select 
    *
from
    filtered_data
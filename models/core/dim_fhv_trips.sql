{{
    config(
        materialized='table'
    )
}}

with fhv_data as (
    select *
    from {{ ref('stg_fhv_data_table') }}
    where dispatching_base_num is not null
), 
dim_zones as (
    select *
    from {{ ref('dim_zones') }}
)
select 
    fhv_data.dispatching_base_num,
    fhv_data.pickup_datetime,
    fhv_data.dropoff_datetime,
    fhv_data.pulocationid,
    fhv_data.dolocationid,
    fhv_data.sr_flag,
    fhv_data.affiliated_base_number,
    dim_zones.locationid,
    dim_zones.borough,
    dim_zones.zone,
    dim_zones.service_zone,
    EXTRACT(YEAR from fhv_data.pickup_datetime) as year,
    EXTRACT(MONTH from fhv_data.pickup_datetime) as month
from
    fhv_data
JOIN
    dim_zones
ON
    fhv_data.pulocationid = dim_zones.locationid

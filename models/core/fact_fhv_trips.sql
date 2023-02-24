{{ config (materialized='table') }}


with fhv_data as (
    select * from {{ ref('staging_fhv_tripdata') }}
),
dim_zones as (
    select * from {{ ref('dim_zones') }}
    where Borough != 'unknown'
)
select
    fhv_data.pickup_locationid,
    fhv_data.dropoff_locationid,
    pickup_zone.Borough as pickup_borough,
    pickup_zone.Zone as pickup_zone,
    fhv_data.pickup_datetime,
    fhv_data.dropoff_datetime,
    dropoff_zone.Borough as dropoff_borough,
    dropoff_zone.Zone as dropoff_zone,
    fhv_data.dispatching_base_num,
    fhv_data.Affiliated_base_number,
    fhv_data.SR_Flag

from fhv_data
inner join dim_zones as pickup_zone
on fhv_data.pickup_locationid = pickup_zone.LocationID
inner join dim_zones as dropoff_zone
on fhv_data.dropoff_locationid = dropoff_zone.LocationID
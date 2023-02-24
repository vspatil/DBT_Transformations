{{ config(materialized='view') }}


select 
dispatching_base_num as dispatching_base_num,
cast(PUlocationID as integer) as pickup_locationid,
cast(DOlocationID as integer) as dropoff_locationid,

--timestamps
cast(pickup_datetime as timestamp) as pickup_datetime,
cast(dropoff_datetime as timestamp) as dropoff_datetime,
SR_Flag,
Affiliated_base_number as Affiliated_base_number


from {{ source('staging','fhv_tripsdata_2019') }}


{% if var('is_test_run',default=false) %}

limit 100

{% endif %}
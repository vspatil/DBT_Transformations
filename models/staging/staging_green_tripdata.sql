{{ config(materialized='view') }}

select 
--identifiers
{{ dbt_utils.surrogate_key(['VendorID','lpep_pickup_datetime']) }} as tripid,
cast(VendorID as integer) as VendorID,
cast(RatecodeID as integer) as RatecodeID,
cast(PULocationID as integer) as pickup_locationid,
cast(DOLocationID as integer) as dropoff_locationid,

--timestamps
cast(lpep_pickup_datetime as timestamp) as pickup_datetime,
cast(lpep_dropoff_datetime as timestamp) as dropoff_datetime,

--trip info
store_and_fwd_flag,
cast(passenger_count as integer) as passenger_count,
cast(trip_distance as integer) as trip_distance,
cast(trip_type as integer) as trip_type,


--payment info
cast(fare_amount as numeric) as fare_amount,
cast(extra as numeric) as extra,
cast(mta_tax as numeric) as mta_tax,
cast(tip_amount as numeric) as tip_amount,
cast(tolls_amount as numeric) as tolls_amount,
0 as ehail_fee,
cast(improvement_surcharge as numeric) as improvement_surcharge,
cast(total_amount as numeric) as total_amount,
cast(payment_type as integer) as payment_type,
{{get_payment_type_description ('payment_type')}} as payment_type_description,
cast(congestion_surcharge as numeric) as congestion_surcharge,

from {{ source('staging','green_tripsdata_2020') }}
where VendorID is not null

{% if var('is_test_run',default=false) %}

limit 100

{% endif %}
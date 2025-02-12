{{ config(materialized='table', schema=env_var('DBT_STAGE_SCH', 'stage_dev')) }}

with
    source_data as (
        select
            orderid,
            lineno,
            shipperid,
            customerid,
            productid,
            employeeid,
            split_part(shipmentdate,' ', 1)::date as shipmentdate,
            status
        from {{ source('raw_qwt', 'RAW_SHIPMENTS') }}
    )

select *
from source_data

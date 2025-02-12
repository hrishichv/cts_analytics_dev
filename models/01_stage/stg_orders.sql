{{ config(materialized="incremental", schema=env_var('DBT_STAGE_SCH', 'stage_dev'), unique_key=["orderid"]) }}

with
    source_data as (
        select orderid, 
        orderdate, 
        customerid, 
        employeeid, 
        shipperid, 
        freight
        from {{ source("raw_qwt", "RAW_ORDERS") }}
    )

select *
from source_data

{% if is_incremental() %}
    where orderdate > (select max(orderdate) from {{ this }})
{% endif %}

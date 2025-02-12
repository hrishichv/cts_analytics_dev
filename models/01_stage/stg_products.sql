{{ config(materialized="table", schema=env_var('DBT_STAGE_SCH', 'stage_dev')) }}

with
    source_data as (
        select
            productid,
            productname,
            supplierid,
            categoryid,
            quantityperunit,
            unitcost,
            unitprice,
            unitsinstock,
            unitsonorder
        from {{ source("raw_qwt", "RAW_PRODUCTS") }}
    )

select *
from source_data

{{ config(materialized='table', schema=env_var('DBT_TRANSFORM_SCH', 'transform_dev')) }}

select 
    a11.orderid, 
    a11.lineno, 
    a12.companyname, 
    a11.shipmentdate, 
    a11.status
from {{ ref('snp_orders') }} as a11
left join {{ ref('lkp_shippers') }} as a12 on a11.shipperid = a12.shipperid
where a11.dbt_valid_to is null

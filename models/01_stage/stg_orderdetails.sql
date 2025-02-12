{{ 
    config(
        materialized='incremental', 
        schema=env_var('DBT_STAGE_SCH', 'stage_dev'),
        unique_key=['orderid','lineno']
        ) 
}}

with
    source_data as (
        select a11.orderid,
        a11.lineno,
        a11.productid,
        a11.quantity,
        a11.unitprice,
        a11.discount,
        a12.orderdate
        from {{ source("raw_qwt", "RAW_ORDERDETAILS") }} a11
        inner join {{ source("raw_qwt", "RAW_ORDERS") }} a12
        on a11.orderid = a12.orderid
    )

select *
from source_data

{% if is_incremental() %}
    where orderdate > (select max(orderdate) from {{ source("raw_qwt", "RAW_ORDERS") }} )
{% endif %}

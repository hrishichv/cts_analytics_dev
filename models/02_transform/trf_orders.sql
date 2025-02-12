{{ config(materialized="table", schema=env_var('DBT_TRANSFORM_SCH', 'transform_dev')) }}

select
    o.orderid,
    od.lineno,
    o.customerid,
    o.employeeid,
    o.shipperid,
    od.productid,
    od.quantity,
    od.unitprice,
    od.discount,
    od.orderdate,
    to_decimal(
        (od.unitprice * od.quantity) * (1 - od.discount), 9, 2
    ) as linesalesamount,
    to_decimal(p.unitcost * od.quantity, 9, 2) as costofgoodssols,
    to_decimal(
        ((od.unitprice * od.quantity) * (1 - od.discount)) - (p.unitcost * od.quantity),
        9,
        2
    ) as margin

from {{ ref("stg_orders") }} as o
inner join {{ ref("stg_orderdetails") }} as od on o.orderid = od.orderid
inner join {{ ref("stg_products") }} as p on od.productid = p.productid

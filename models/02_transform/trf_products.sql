{{ config(materialized="table", schema=env_var('DBT_TRANSFORM_SCH', 'transform_dev')) }}

select
    p.productid,
    p.productname,
    s.companyname,
    s.contactname,
    s.address,
    s.city,
    s.country,
    c.categoryname,
    p.quantityperunit,
    p.unitcost,
    p.unitprice,
    p.unitsinstock,
    p.unitsonorder,
    to_decimal((p.unitcost - p.unitprice), 9, 2) as profit,
    IFF(p.unitsinstock-p.unitsonorder < 0, 'Not Available','Available') as productavailability
from {{ ref("stg_products") }} as p
left join {{ ref("trf_suppliers") }} as s on s.supplierid = p.supplierid
left join {{ ref("lkp_categories") }} as c on p.categoryid = c.categoryid

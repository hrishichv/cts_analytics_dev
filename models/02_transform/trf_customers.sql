{{ config(materialized="table", schema=env_var('DBT_TRANSFORM_SCH', 'transform_dev')) }}

select
    a11.customer_id,
    a11.companyname,
    a11.contactname,
    a11.city,
    a11.country,
    a12.divisionname,
    a11.address,
    a11.fax,
    a11.phone,
    a11.postalcode,
    a11.stateprovince,
    iff(a11.stateprovince = '', 'NA', a11.stateprovince) as stateprovincename
from {{ ref("stg_customers") }} as a11
inner join {{ ref("lkp_divisions") }} as a12 on a11.divisionid = a12.divisionid

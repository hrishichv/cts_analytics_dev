{{ config(materialized="table", schema=env_var('DBT_TRANSFORM_SCH', 'transform_dev')) }}

select
    get(xmlget(supplierinfo, 'SupplierID'), '$') as supplierid,
    get(xmlget(supplierinfo, 'CompanyName'), '$')::varchar as companyname,
    get(xmlget(supplierinfo, 'ContactName'), '$')::varchar as contactname,
    get(xmlget(supplierinfo, 'Address'), '$')::varchar as address,
    get(xmlget(supplierinfo, 'City'), '$')::varchar as city,
    get(xmlget(supplierinfo, 'PostalCode'), '$')::varchar as postalcode,
    get(xmlget(supplierinfo, 'Country'), '$')::varchar as country,
    get(xmlget(supplierinfo, 'Phone'), '$')::varchar as phone,
    get(xmlget(supplierinfo, 'Fax'), '$')::varchar as fax
from {{ ref("stg_suppliers") }}

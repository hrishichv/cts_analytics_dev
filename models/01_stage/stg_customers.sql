{{ config(materialized='table', schema=env_var('DBT_STAGE_SCH', 'stage_dev')) }}

with
    source_data as (
        select
            customer_id,
            companyname,
            contactname,
            city,
            country,
            divisionid,
            address,
            fax,
            phone,
            postalcode,
            stateprovince
        from {{ source("raw_qwt", "RAW_CUSTOMERS") }}
    )

select *
from source_data

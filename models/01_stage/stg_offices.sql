{{ config(materialized="table", schema=env_var('DBT_STAGE_SCH', 'stage_dev')) }}

with
    source_data as (
        select
            office as office_id,
            officeaddress as address,
            officepostalcode as postalcode,
            officecity as city,
            officestateprovince as stateprovince,
            officephone as phone,
            officefax as fax,
            officecountry as country
        from {{ source('raw_qwt', 'RAW_OFFICES') }}
    )

select *
from source_data

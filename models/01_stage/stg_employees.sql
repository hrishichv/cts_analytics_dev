{{ config(materialized="table", schema=env_var('DBT_STAGE_SCH', 'stage_dev')) }}

with
    source_data as (
        select
            empid,
            last_name,
            first_name,
            title,
            hire_date,
            office,
            extension,
            reports_to,
            year_salary
        from {{ source("raw_qwt", "RAW_EMPLOYEES") }}
    )

select *
from source_data

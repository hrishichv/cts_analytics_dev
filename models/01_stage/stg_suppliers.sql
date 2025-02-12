{{ config(materialized="table", schema=env_var('DBT_STAGE_SCH', 'stage_dev')) }}

select *
from {{ source("raw_qwt", "RAW_SUPPLIERS") }}

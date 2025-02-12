{{ config(materialized="view", schema=env_var('DBT_MART_SCH', 'mart_dev')) }}

select *
from {{ ref("trf_employees") }}

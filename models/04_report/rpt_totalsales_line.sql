{{ config(materialized="view", schema=env_var('DBT_REPORT_SCH', 'report_dev')) }}

{% set i_val = get_linenos() %}
select
    orderid,
    {% for i in i_val %}
        sum(case when lineno = {{i}} then linesalesamount end) as lineno{{i}}_amount,
    {% endfor %}
    sum(linesalesamount) as total_amount
from {{ ref("fct_orders") }}
group by 1

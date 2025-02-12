{{ config(materialized="view", schema=env_var('DBT_REPORT_SCH', 'report_dev')) }}

select
    a12.companyname,
    a12.contactname,
    min(a11.orderdate) as first_order_date,
    min(a13.day_of_week_name) as first_order_day,
    max(a11.orderdate) as recent_order_date,
    max(a13.day_of_week_name) as recent_order_day,
    sum(a11.quantity) total_qty,
    sum(a11.linesalesamount) as total_sales
from {{ ref("fct_orders") }} as a11
inner join {{ ref("dim_customers") }} as a12 on a12.customer_id = a11.customerid
inner join {{ ref("dim_date") }} as a13 on a13.date_day = a11.orderdate
group by a12.companyname, a12.contactname

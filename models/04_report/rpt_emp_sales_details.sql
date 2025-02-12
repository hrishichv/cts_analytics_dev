{{ config(materialized='view', schema=env_var('DBT_REPORT_SCH', 'report_dev'))}}

with source_data as (
select
a12.empname as employe_name,
count(a13.customer_id) as total_customers,
count(a14.productid) as total_products,
count(a11.linesalesamount) as total_sales
from {{ ref('fct_orders')}} as a11
inner join {{ ref("dim_employees")}} as a12 on a11.employeeid = a12.empid 
inner join {{ ref('dim_customers')}} as a13 on a11.customerid = a13.customer_id
inner join {{ ref('dim_products')}} as a14 on a11.productid = a14.productid
group by a12.empname
)

select * 
from source_data
order by total_sales desc
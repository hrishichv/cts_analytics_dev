{{ config(materialized='view', schema=env_var('DBT_REPORT_SCH', 'report_dev')) }}

select
    a13.country,
    a12.companyname,
    a12.contactname,
    count(a11.orderid) as total_orders,
    sum(a11.quantity) as total_qty,
    sum(a11.linesalesamount) as total_sales,
    avg(a11.margin) as margin
from {{ ref("fct_orders") }} as a11
inner join {{ ref("dim_customers") }} as a12 on a11.customerid = a12.customer_id
inner join {{ ref("dim_employees") }} as a13 on a13.empid = a11.employeeid
where a13.country = '{{var('v_country','France')}}'
group by a13.country, a12.companyname, a12.contactname

{{ config(materialized="table", schema=env_var('DBT_TRANSFORM_SCH', 'transform_dev')) }}

with recursive
    managers
    (
        indent,
        office_id,
        empid,
        empname,
        emptitle,
        managerid,
        managername,
        managertitle
    ) as (
        select
            '*' as indent,
            office as office_id,
            empid,
            first_name as empname,
            title as emptitle,
            empid as managerid,
            first_name as managername,
            title as managertitle
        from {{ ref("stg_employees") }}
        where title = 'President'

        union all

        select
            indent || '*',
            emp.office as officeid,
            emp.empid,
            emp.first_name as empname,
            emp.title as emptitle,
            mgr.empid as managerid,
            mgr.empname as managername,
            mgr.emptitle as managertitle
        from {{ ref("stg_employees") }} as emp
        inner join managers as mgr on emp.reports_to = mgr.empid
    ),

    office(office_id, city, country) as (
        select office_id, city, country from {{ ref("stg_offices") }}
    )

select
    indent,
    empid,
    empname,
    emptitle,
    managerid,
    managername,
    managertitle,
    ofc.city,
    ofc.country
from managers as mgr
inner join office as ofc on mgr.office_id = ofc.office_id

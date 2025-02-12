{# Get distinct line numbers from FCT_ORDERS table #}
{% macro get_linenos() -%}

    {% set lineno_query %}
select distinct
lineno
from {{ ref('fct_orders') }}
order by 1
    {% endset %}

    {% set results = run_query(lineno_query) %}

    {% if execute %}
        {# Return the first column #}
        {% set results_list = results.columns[0].values() %}
    {% else %} {% set results_list = [] %}
    {% endif %}

    {{ return(results_list) }}

{% endmacro %}

{# Get Max date from FCT_ORDERS table #}
{% macro get_maxdate() -%}

    {% set lineno_query %}
select max(orderdate) as max_order_date
from {{ ref('fct_orders') }}
order by 1
    {% endset %}

    {% set results = run_query(lineno_query) %}

    {% if execute %}
        {# Return the first column #}
        {% set results_list = results.columns[0][0] %}
    {% else %} {% set results_list = [] %}
    {% endif %}

    {{ return(results_list) }}

{% endmacro %}

{# Get Min date from FCT_ORDERS table #}
{% macro get_mindate() -%}

    {% set lineno_query %}
    select min(orderdate) as min_order_date
    from {{ ref('fct_orders') }}
    order by 1
    {% endset %}

    {% set results = run_query(lineno_query) %}

    {% if execute %}
        {# Return the first column #}
        {% set results_list = results.columns[0][0] %}
    {% else %} {% set results_list = [] %}
    {% endif %}

    {{ return(results_list) }}

{% endmacro %}

{% snapshot snp_orders %}

    {{
        config(
            target_database = env_var('DBT_SOURCE_DB', 'QWT_ANALYTICS_DEV'),
            schema = env_var('DBT_SNAPSHOT_SCH', 'snapshot_dev'),
            unique_key = "orderid||'-'||lineno",
            strategy = 'timestamp',
            updated_at = 'shipmentdate'
        )
    }}

    select *
    from {{ ref('stg_shipments') }}

{% endsnapshot %}

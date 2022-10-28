{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "mailchimp",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('campaigns_report_summary_ecommerce_ab3') }}
select
    _airbyte_report_summary_hashid,
    total_spent,
    total_orders,
    total_revenue,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_ecommerce_hashid
from {{ ref('campaigns_report_summary_ecommerce_ab3') }}
-- ecommerce at campaigns/report_summary/ecommerce from {{ ref('campaigns_report_summary') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


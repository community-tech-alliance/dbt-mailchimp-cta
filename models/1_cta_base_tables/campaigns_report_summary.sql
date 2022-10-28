{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "mailchimp",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('campaigns_report_summary_ab3') }}
select
    _airbyte_campaigns_hashid,
    opens,
    clicks,
    ecommerce,
    open_rate,
    click_rate,
    unique_opens,
    subscriber_clicks,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_report_summary_hashid
from {{ ref('campaigns_report_summary_ab3') }}
-- report_summary at campaigns/report_summary from {{ ref('campaigns') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


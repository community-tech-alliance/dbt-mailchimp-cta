{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "mailchimp",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('campaigns_tracking_ab3') }}
select
    _airbyte_campaigns_hashid,
    opens,
    capsule,
    ecomm360,
    clicktale,
    salesforce,
    html_clicks,
    text_clicks,
    goal_tracking,
    google_analytics,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_tracking_hashid
from {{ ref('campaigns_tracking_ab3') }}
-- tracking at campaigns/tracking from {{ ref('campaigns') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


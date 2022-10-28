{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "mailchimp",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('campaigns_rss_opts_schedule_ab3') }}
select
    _airbyte_rss_opts_hashid,
    hour,
    daily_send,
    weekly_send_day,
    monthly_send_date,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_schedule_hashid
from {{ ref('campaigns_rss_opts_schedule_ab3') }}
-- schedule at campaigns/rss_opts/schedule from {{ ref('campaigns_rss_opts') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


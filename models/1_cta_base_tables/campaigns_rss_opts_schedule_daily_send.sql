{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "mailchimp",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('campaigns_rss_opts_schedule_daily_send_ab3') }}
select
    _airbyte_schedule_hashid,
    friday,
    monday,
    sunday,
    tuesday,
    saturday,
    thursday,
    wednesday,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_daily_send_hashid
from {{ ref('campaigns_rss_opts_schedule_daily_send_ab3') }}
-- daily_send at campaigns/rss_opts/schedule/daily_send from {{ ref('campaigns_rss_opts_schedule') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


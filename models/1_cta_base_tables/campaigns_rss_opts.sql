{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "mailchimp",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('campaigns_rss_opts_ab3') }}
select
    _airbyte_campaigns_hashid,
    feed_url,
    schedule,
    frequency,
    last_sent,
    constrain_rss_img,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_rss_opts_hashid
from {{ ref('campaigns_rss_opts_ab3') }}
-- rss_opts at campaigns/rss_opts from {{ ref('campaigns') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


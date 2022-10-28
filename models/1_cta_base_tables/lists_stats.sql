{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "mailchimp",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('lists_stats_ab3') }}
select
    _airbyte_lists_hashid,
    open_rate,
    click_rate,
    avg_sub_rate,
    member_count,
    cleaned_count,
    last_sub_date,
    avg_unsub_rate,
    campaign_count,
    total_contacts,
    last_unsub_date,
    target_sub_rate,
    merge_field_count,
    unsubscribe_count,
    campaign_last_sent,
    member_count_since_send,
    cleaned_count_since_send,
    unsubscribe_count_since_send,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_stats_hashid
from {{ ref('lists_stats_ab3') }}
-- stats at lists/stats from {{ ref('lists') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


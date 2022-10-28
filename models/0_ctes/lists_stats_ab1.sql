{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('lists') }}
select
    _airbyte_lists_hashid,
    {{ json_extract_scalar('stats', ['open_rate'], ['open_rate']) }} as open_rate,
    {{ json_extract_scalar('stats', ['click_rate'], ['click_rate']) }} as click_rate,
    {{ json_extract_scalar('stats', ['avg_sub_rate'], ['avg_sub_rate']) }} as avg_sub_rate,
    {{ json_extract_scalar('stats', ['member_count'], ['member_count']) }} as member_count,
    {{ json_extract_scalar('stats', ['cleaned_count'], ['cleaned_count']) }} as cleaned_count,
    {{ json_extract_scalar('stats', ['last_sub_date'], ['last_sub_date']) }} as last_sub_date,
    {{ json_extract_scalar('stats', ['avg_unsub_rate'], ['avg_unsub_rate']) }} as avg_unsub_rate,
    {{ json_extract_scalar('stats', ['campaign_count'], ['campaign_count']) }} as campaign_count,
    {{ json_extract_scalar('stats', ['total_contacts'], ['total_contacts']) }} as total_contacts,
    {{ json_extract_scalar('stats', ['last_unsub_date'], ['last_unsub_date']) }} as last_unsub_date,
    {{ json_extract_scalar('stats', ['target_sub_rate'], ['target_sub_rate']) }} as target_sub_rate,
    {{ json_extract_scalar('stats', ['merge_field_count'], ['merge_field_count']) }} as merge_field_count,
    {{ json_extract_scalar('stats', ['unsubscribe_count'], ['unsubscribe_count']) }} as unsubscribe_count,
    {{ json_extract_scalar('stats', ['campaign_last_sent'], ['campaign_last_sent']) }} as campaign_last_sent,
    {{ json_extract_scalar('stats', ['member_count_since_send'], ['member_count_since_send']) }} as member_count_since_send,
    {{ json_extract_scalar('stats', ['cleaned_count_since_send'], ['cleaned_count_since_send']) }} as cleaned_count_since_send,
    {{ json_extract_scalar('stats', ['unsubscribe_count_since_send'], ['unsubscribe_count_since_send']) }} as unsubscribe_count_since_send,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('lists') }} as table_alias
-- stats at lists/stats
where 1 = 1
and stats is not null
{{ incremental_clause('_airbyte_emitted_at', this) }}


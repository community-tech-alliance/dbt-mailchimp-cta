{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('lists_stats_ab1') }}
select
    _airbyte_lists_hashid,
    cast(open_rate as {{ dbt_utils.type_float() }}) as open_rate,
    cast(click_rate as {{ dbt_utils.type_float() }}) as click_rate,
    cast(avg_sub_rate as {{ dbt_utils.type_float() }}) as avg_sub_rate,
    cast(member_count as {{ dbt_utils.type_bigint() }}) as member_count,
    cast(cleaned_count as {{ dbt_utils.type_bigint() }}) as cleaned_count,
    cast(last_sub_date as {{ dbt_utils.type_string() }}) as last_sub_date,
    cast(avg_unsub_rate as {{ dbt_utils.type_float() }}) as avg_unsub_rate,
    cast(campaign_count as {{ dbt_utils.type_bigint() }}) as campaign_count,
    cast(total_contacts as {{ dbt_utils.type_bigint() }}) as total_contacts,
    cast(last_unsub_date as {{ dbt_utils.type_string() }}) as last_unsub_date,
    cast(target_sub_rate as {{ dbt_utils.type_float() }}) as target_sub_rate,
    cast(merge_field_count as {{ dbt_utils.type_bigint() }}) as merge_field_count,
    cast(unsubscribe_count as {{ dbt_utils.type_bigint() }}) as unsubscribe_count,
    cast(campaign_last_sent as {{ dbt_utils.type_string() }}) as campaign_last_sent,
    cast(member_count_since_send as {{ dbt_utils.type_bigint() }}) as member_count_since_send,
    cast(cleaned_count_since_send as {{ dbt_utils.type_bigint() }}) as cleaned_count_since_send,
    cast(unsubscribe_count_since_send as {{ dbt_utils.type_bigint() }}) as unsubscribe_count_since_send,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('lists_stats_ab1') }}
-- stats at lists/stats
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


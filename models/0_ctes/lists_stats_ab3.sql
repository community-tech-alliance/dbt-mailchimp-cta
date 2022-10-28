{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('lists_stats_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_lists_hashid',
        'open_rate',
        'click_rate',
        'avg_sub_rate',
        'member_count',
        'cleaned_count',
        'last_sub_date',
        'avg_unsub_rate',
        'campaign_count',
        'total_contacts',
        'last_unsub_date',
        'target_sub_rate',
        'merge_field_count',
        'unsubscribe_count',
        'campaign_last_sent',
        'member_count_since_send',
        'cleaned_count_since_send',
        'unsubscribe_count_since_send',
    ]) }} as _airbyte_stats_hashid,
    tmp.*
from {{ ref('lists_stats_ab2') }} tmp
-- stats at lists/stats
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


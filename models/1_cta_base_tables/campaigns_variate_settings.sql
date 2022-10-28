{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "mailchimp",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('campaigns_variate_settings_ab3') }}
select
    _airbyte_campaigns_hashid,
    contents,
    test_size,
    wait_time,
    from_names,
    send_times,
    combinations,
    subject_lines,
    winner_criteria,
    reply_to_addresses,
    winning_campaign_id,
    winning_combination_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_variate_settings_hashid
from {{ ref('campaigns_variate_settings_ab3') }}
-- variate_settings at campaigns/variate_settings from {{ ref('campaigns') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


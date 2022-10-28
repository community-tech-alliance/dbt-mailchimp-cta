{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "mailchimp",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('campaigns_variate_settings_combinations_ab3') }}
select
    _airbyte_variate_settings_hashid,
    id,
    reply_to,
    from_name,
    send_time,
    recipients,
    subject_line,
    content_description,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_combinations_hashid
from {{ ref('campaigns_variate_settings_combinations_ab3') }}
-- combinations at campaigns/variate_settings/combinations from {{ ref('campaigns_variate_settings') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


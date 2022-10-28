{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "mailchimp",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('lists_campaign_defaults_ab3') }}
select
    _airbyte_lists_hashid,
    subject,
    language,
    from_name,
    from_email,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_campaign_defaults_hashid
from {{ ref('lists_campaign_defaults_ab3') }}
-- campaign_defaults at lists/campaign_defaults from {{ ref('lists') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


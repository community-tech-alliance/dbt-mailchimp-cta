{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "mailchimp",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('campaigns_recipients_ab3') }}
select
    _airbyte_campaigns_hashid,
    list_id,
    list_name,
    segment_opts,
    segment_text,
    list_is_active,
    recipient_count,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_recipients_hashid
from {{ ref('campaigns_recipients_ab3') }}
-- recipients at campaigns/recipients from {{ ref('campaigns') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


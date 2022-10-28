{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "mailchimp",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('campaigns_recipients_segment_opts_conditions_ab3') }}
select
    _airbyte_segment_opts_hashid,
    op,
    field,
    value,
    condition_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_conditions_hashid
from {{ ref('campaigns_recipients_segment_opts_conditions_ab3') }}
-- conditions at campaigns/recipients/segment_opts/conditions from {{ ref('campaigns_recipients_segment_opts') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


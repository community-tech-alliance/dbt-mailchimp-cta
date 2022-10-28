{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "mailchimp",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('campaigns_recipients_segment_opts_ab3') }}
select
    _airbyte_recipients_hashid,
    match,
    conditions,
    saved_segment_id,
    prebuilt_segment_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_segment_opts_hashid
from {{ ref('campaigns_recipients_segment_opts_ab3') }}
-- segment_opts at campaigns/recipients/segment_opts from {{ ref('campaigns_recipients') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


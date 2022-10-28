{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "mailchimp",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('campaigns_tracking_capsule_ab3') }}
select
    _airbyte_tracking_hashid,
    notes,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_capsule_hashid
from {{ ref('campaigns_tracking_capsule_ab3') }}
-- capsule at campaigns/tracking/capsule from {{ ref('campaigns_tracking') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


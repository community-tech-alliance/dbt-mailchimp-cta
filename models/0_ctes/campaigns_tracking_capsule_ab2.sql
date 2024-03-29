{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('campaigns_tracking_capsule_ab1') }}
select
    _airbyte_tracking_hashid,
    {{ cast_to_boolean('notes') }} as notes,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaigns_tracking_capsule_ab1') }}
-- capsule at campaigns/tracking/capsule
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


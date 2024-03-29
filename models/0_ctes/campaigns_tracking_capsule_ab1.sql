{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('campaigns_tracking') }}
select
    _airbyte_tracking_hashid,
    {{ json_extract_scalar('capsule', ['notes'], ['notes']) }} as notes,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaigns_tracking') }} as table_alias
-- capsule at campaigns/tracking/capsule
where 1 = 1
and capsule is not null
{{ incremental_clause('_airbyte_emitted_at', this) }}


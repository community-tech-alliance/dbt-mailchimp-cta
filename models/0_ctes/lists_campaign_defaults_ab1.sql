{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('lists') }}
select
    _airbyte_lists_hashid,
    {{ json_extract_scalar('campaign_defaults', ['subject'], ['subject']) }} as subject,
    {{ json_extract_scalar('campaign_defaults', ['language'], ['language']) }} as language,
    {{ json_extract_scalar('campaign_defaults', ['from_name'], ['from_name']) }} as from_name,
    {{ json_extract_scalar('campaign_defaults', ['from_email'], ['from_email']) }} as from_email,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('lists') }} as table_alias
-- campaign_defaults at lists/campaign_defaults
where 1 = 1
and campaign_defaults is not null
{{ incremental_clause('_airbyte_emitted_at', this) }}


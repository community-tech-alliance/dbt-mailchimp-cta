{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_mailchimp",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('mailchimp', '_airbyte_raw_email_activity') }}
select
    {{ json_extract_scalar('_airbyte_data', ['ip'], ['ip']) }} as ip,
    {{ json_extract_scalar('_airbyte_data', ['url'], ['url']) }} as url,
    {{ json_extract_scalar('_airbyte_data', ['type'], ['type']) }} as type,
    {{ json_extract_scalar('_airbyte_data', ['action'], ['action']) }} as action,
    {{ json_extract_scalar('_airbyte_data', ['list_id'], ['list_id']) }} as list_id,
    {{ json_extract_scalar('_airbyte_data', ['email_id'], ['email_id']) }} as email_id,
    {{ json_extract_scalar('_airbyte_data', ['timestamp'], ['timestamp']) }} as timestamp,
    {{ json_extract_scalar('_airbyte_data', ['campaign_id'], ['campaign_id']) }} as campaign_id,
    {{ json_extract_scalar('_airbyte_data', ['email_address'], ['email_address']) }} as email_address,
    {{ json_extract_scalar('_airbyte_data', ['list_is_active'], ['list_is_active']) }} as list_is_active,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('mailchimp', '_airbyte_raw_email_activity') }} as table_alias
-- email_activity
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_mailchimp",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('mailchimp', '_airbyte_raw_lists') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract('table_alias', '_airbyte_data', ['stats'], ['stats']) }} as stats,
    {{ json_extract_scalar('_airbyte_data', ['web_id'], ['web_id']) }} as web_id,
    {{ json_extract('table_alias', '_airbyte_data', ['contact'], ['contact']) }} as contact,
    {{ json_extract_string_array('_airbyte_data', ['modules'], ['modules']) }} as modules,
    {{ json_extract_scalar('_airbyte_data', ['visibility'], ['visibility']) }} as visibility,
    {{ json_extract_scalar('_airbyte_data', ['has_welcome'], ['has_welcome']) }} as has_welcome,
    {{ json_extract_scalar('_airbyte_data', ['list_rating'], ['list_rating']) }} as list_rating,
    {{ json_extract_scalar('_airbyte_data', ['date_created'], ['date_created']) }} as date_created,
    {{ json_extract_scalar('_airbyte_data', ['double_optin'], ['double_optin']) }} as double_optin,
    {{ json_extract_scalar('_airbyte_data', ['beamer_address'], ['beamer_address']) }} as beamer_address,
    {{ json_extract_scalar('_airbyte_data', ['use_archive_bar'], ['use_archive_bar']) }} as use_archive_bar,
    {{ json_extract('table_alias', '_airbyte_data', ['campaign_defaults'], ['campaign_defaults']) }} as campaign_defaults,
    {{ json_extract_scalar('_airbyte_data', ['email_type_option'], ['email_type_option']) }} as email_type_option,
    {{ json_extract_scalar('_airbyte_data', ['subscribe_url_long'], ['subscribe_url_long']) }} as subscribe_url_long,
    {{ json_extract_scalar('_airbyte_data', ['notify_on_subscribe'], ['notify_on_subscribe']) }} as notify_on_subscribe,
    {{ json_extract_scalar('_airbyte_data', ['permission_reminder'], ['permission_reminder']) }} as permission_reminder,
    {{ json_extract_scalar('_airbyte_data', ['subscribe_url_short'], ['subscribe_url_short']) }} as subscribe_url_short,
    {{ json_extract_scalar('_airbyte_data', ['marketing_permissions'], ['marketing_permissions']) }} as marketing_permissions,
    {{ json_extract_scalar('_airbyte_data', ['notify_on_unsubscribe'], ['notify_on_unsubscribe']) }} as notify_on_unsubscribe,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('mailchimp', '_airbyte_raw_lists') }} as table_alias
-- lists
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


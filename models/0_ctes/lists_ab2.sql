{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_mailchimp",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('lists_ab1') }}
select
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(stats as {{ type_json() }}) as stats,
    cast(web_id as {{ dbt_utils.type_bigint() }}) as web_id,
    cast(contact as {{ type_json() }}) as contact,
    modules,
    cast(visibility as {{ dbt_utils.type_string() }}) as visibility,
    {{ cast_to_boolean('has_welcome') }} as has_welcome,
    cast(list_rating as {{ dbt_utils.type_bigint() }}) as list_rating,
    cast({{ empty_string_to_null('date_created') }} as {{ type_timestamp_with_timezone() }}) as date_created,
    {{ cast_to_boolean('double_optin') }} as double_optin,
    cast(beamer_address as {{ dbt_utils.type_string() }}) as beamer_address,
    {{ cast_to_boolean('use_archive_bar') }} as use_archive_bar,
    cast(campaign_defaults as {{ type_json() }}) as campaign_defaults,
    {{ cast_to_boolean('email_type_option') }} as email_type_option,
    cast(subscribe_url_long as {{ dbt_utils.type_string() }}) as subscribe_url_long,
    cast(notify_on_subscribe as {{ dbt_utils.type_string() }}) as notify_on_subscribe,
    cast(permission_reminder as {{ dbt_utils.type_string() }}) as permission_reminder,
    cast(subscribe_url_short as {{ dbt_utils.type_string() }}) as subscribe_url_short,
    {{ cast_to_boolean('marketing_permissions') }} as marketing_permissions,
    cast(notify_on_unsubscribe as {{ dbt_utils.type_string() }}) as notify_on_unsubscribe,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('lists_ab1') }}
-- lists
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


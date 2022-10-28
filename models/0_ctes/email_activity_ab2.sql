{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_mailchimp",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('email_activity_ab1') }}
select
    cast(ip as {{ dbt_utils.type_string() }}) as ip,
    cast(url as {{ dbt_utils.type_string() }}) as url,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast(action as {{ dbt_utils.type_string() }}) as action,
    cast(list_id as {{ dbt_utils.type_string() }}) as list_id,
    cast(email_id as {{ dbt_utils.type_string() }}) as email_id,
    cast({{ empty_string_to_null('timestamp') }} as {{ type_timestamp_with_timezone() }}) as timestamp,
    cast(campaign_id as {{ dbt_utils.type_string() }}) as campaign_id,
    cast(email_address as {{ dbt_utils.type_string() }}) as email_address,
    {{ cast_to_boolean('list_is_active') }} as list_is_active,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('email_activity_ab1') }}
-- email_activity
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


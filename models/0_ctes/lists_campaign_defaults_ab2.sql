{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('lists_campaign_defaults_ab1') }}
select
    _airbyte_lists_hashid,
    cast(subject as {{ dbt_utils.type_string() }}) as subject,
    cast(language as {{ dbt_utils.type_string() }}) as language,
    cast(from_name as {{ dbt_utils.type_string() }}) as from_name,
    cast(from_email as {{ dbt_utils.type_string() }}) as from_email,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('lists_campaign_defaults_ab1') }}
-- campaign_defaults at lists/campaign_defaults
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


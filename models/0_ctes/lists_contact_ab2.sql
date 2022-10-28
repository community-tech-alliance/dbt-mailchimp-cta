{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('lists_contact_ab1') }}
select
    _airbyte_lists_hashid,
    cast(zip as {{ dbt_utils.type_string() }}) as zip,
    cast(city as {{ dbt_utils.type_string() }}) as city,
    cast(phone as {{ dbt_utils.type_string() }}) as phone,
    cast(state as {{ dbt_utils.type_string() }}) as state,
    cast(company as {{ dbt_utils.type_string() }}) as company,
    cast(country as {{ dbt_utils.type_string() }}) as country,
    cast(address1 as {{ dbt_utils.type_string() }}) as address1,
    cast(address2 as {{ dbt_utils.type_string() }}) as address2,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('lists_contact_ab1') }}
-- contact at lists/contact
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


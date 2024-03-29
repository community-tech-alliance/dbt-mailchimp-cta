{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('campaigns_delivery_status_ab1') }}
select
    _airbyte_campaigns_hashid,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    {{ cast_to_boolean('enabled') }} as enabled,
    {{ cast_to_boolean('can_cancel') }} as can_cancel,
    cast(emails_sent as {{ dbt_utils.type_bigint() }}) as emails_sent,
    cast(emails_canceled as {{ dbt_utils.type_bigint() }}) as emails_canceled,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaigns_delivery_status_ab1') }}
-- delivery_status at campaigns/delivery_status
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


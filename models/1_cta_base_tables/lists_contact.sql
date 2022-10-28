{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "mailchimp",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('lists_contact_ab3') }}
select
    _airbyte_lists_hashid,
    zip,
    city,
    phone,
    state,
    company,
    country,
    address1,
    address2,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_contact_hashid
from {{ ref('lists_contact_ab3') }}
-- contact at lists/contact from {{ ref('lists') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


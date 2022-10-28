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
    {{ json_extract_scalar('contact', ['zip'], ['zip']) }} as zip,
    {{ json_extract_scalar('contact', ['city'], ['city']) }} as city,
    {{ json_extract_scalar('contact', ['phone'], ['phone']) }} as phone,
    {{ json_extract_scalar('contact', ['state'], ['state']) }} as state,
    {{ json_extract_scalar('contact', ['company'], ['company']) }} as company,
    {{ json_extract_scalar('contact', ['country'], ['country']) }} as country,
    {{ json_extract_scalar('contact', ['address1'], ['address1']) }} as address1,
    {{ json_extract_scalar('contact', ['address2'], ['address2']) }} as address2,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('lists') }} as table_alias
-- contact at lists/contact
where 1 = 1
and contact is not null
{{ incremental_clause('_airbyte_emitted_at', this) }}


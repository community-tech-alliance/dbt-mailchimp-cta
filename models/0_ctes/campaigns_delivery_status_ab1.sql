{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('campaigns') }}
select
    _airbyte_campaigns_hashid,
    {{ json_extract_scalar('delivery_status', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('delivery_status', ['enabled'], ['enabled']) }} as enabled,
    {{ json_extract_scalar('delivery_status', ['can_cancel'], ['can_cancel']) }} as can_cancel,
    {{ json_extract_scalar('delivery_status', ['emails_sent'], ['emails_sent']) }} as emails_sent,
    {{ json_extract_scalar('delivery_status', ['emails_canceled'], ['emails_canceled']) }} as emails_canceled,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaigns') }} as table_alias
-- delivery_status at campaigns/delivery_status
where 1 = 1
and delivery_status is not null
{{ incremental_clause('_airbyte_emitted_at', this) }}


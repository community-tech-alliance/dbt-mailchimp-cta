{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "mailchimp",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('email_activity_ab3') }}
select
    ip,
    url,
    type,
    action,
    list_id,
    email_id,
    timestamp,
    campaign_id,
    email_address,
    list_is_active,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_email_activity_hashid
from {{ ref('email_activity_ab3') }}
-- email_activity from {{ source('mailchimp', '_airbyte_raw_email_activity') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


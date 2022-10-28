{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "mailchimp",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('lists_ab3') }}
select
    id,
    name,
    stats,
    web_id,
    contact,
    modules,
    visibility,
    has_welcome,
    list_rating,
    date_created,
    double_optin,
    beamer_address,
    use_archive_bar,
    campaign_defaults,
    email_type_option,
    subscribe_url_long,
    notify_on_subscribe,
    permission_reminder,
    subscribe_url_short,
    marketing_permissions,
    notify_on_unsubscribe,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_lists_hashid
from {{ ref('lists_ab3') }}
-- lists from {{ source('mailchimp', '_airbyte_raw_lists') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


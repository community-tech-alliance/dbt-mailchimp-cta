{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_mailchimp",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('lists_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'name',
        object_to_string('stats'),
        'web_id',
        object_to_string('contact'),
        array_to_string('modules'),
        'visibility',
        boolean_to_string('has_welcome'),
        'list_rating',
        'date_created',
        boolean_to_string('double_optin'),
        'beamer_address',
        boolean_to_string('use_archive_bar'),
        object_to_string('campaign_defaults'),
        boolean_to_string('email_type_option'),
        'subscribe_url_long',
        'notify_on_subscribe',
        'permission_reminder',
        'subscribe_url_short',
        boolean_to_string('marketing_permissions'),
        'notify_on_unsubscribe',
    ]) }} as _airbyte_lists_hashid,
    tmp.*
from {{ ref('lists_ab2') }} tmp
-- lists
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


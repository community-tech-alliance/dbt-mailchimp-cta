{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_mailchimp",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('email_activity_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'ip',
        'url',
        'type',
        'action',
        'list_id',
        'email_id',
        'timestamp',
        'campaign_id',
        'email_address',
        boolean_to_string('list_is_active'),
    ]) }} as _airbyte_email_activity_hashid,
    tmp.*
from {{ ref('email_activity_ab2') }} tmp
-- email_activity
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


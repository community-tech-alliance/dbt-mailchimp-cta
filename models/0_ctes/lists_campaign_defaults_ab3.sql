{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('lists_campaign_defaults_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_lists_hashid',
        'subject',
        'language',
        'from_name',
        'from_email',
    ]) }} as _airbyte_campaign_defaults_hashid,
    tmp.*
from {{ ref('lists_campaign_defaults_ab2') }} tmp
-- campaign_defaults at lists/campaign_defaults
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


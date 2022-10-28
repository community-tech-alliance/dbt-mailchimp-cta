{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('lists_contact_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_lists_hashid',
        'zip',
        'city',
        'phone',
        'state',
        'company',
        'country',
        'address1',
        'address2',
    ]) }} as _airbyte_contact_hashid,
    tmp.*
from {{ ref('lists_contact_ab2') }} tmp
-- contact at lists/contact
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "mailchimp",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('campaigns_delivery_status_ab3') }}
select
    _airbyte_campaigns_hashid,
    status,
    enabled,
    can_cancel,
    emails_sent,
    emails_canceled,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_delivery_status_hashid
from {{ ref('campaigns_delivery_status_ab3') }}
-- delivery_status at campaigns/delivery_status from {{ ref('campaigns') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


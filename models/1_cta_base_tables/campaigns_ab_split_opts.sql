{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "mailchimp",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('campaigns_ab_split_opts_ab3') }}
select
    _airbyte_campaigns_hashid,
    subject_a,
    subject_b,
    wait_time,
    split_size,
    split_test,
    wait_units,
    from_name_a,
    from_name_b,
    pick_winner,
    send_time_a,
    send_time_b,
    reply_email_a,
    reply_email_b,
    send_time_winner,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_ab_split_opts_hashid
from {{ ref('campaigns_ab_split_opts_ab3') }}
-- ab_split_opts at campaigns/ab_split_opts from {{ ref('campaigns') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


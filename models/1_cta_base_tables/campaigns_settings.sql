{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "mailchimp",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('campaigns_settings_ab3') }}
select
    _airbyte_campaigns_hashid,
    title,
    to_name,
    reply_to,
    timewarp,
    folder_id,
    from_name,
    auto_tweet,
    inline_css,
    auto_footer,
    fb_comments,
    template_id,
    authenticate,
    auto_fb_post,
    preview_text,
    subject_line,
    drag_and_drop,
    use_conversation,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_settings_hashid
from {{ ref('campaigns_settings_ab3') }}
-- settings at campaigns/settings from {{ ref('campaigns') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


-- models/marts/fct_messages.sql

SELECT
    stg.raw_id,
    stg.message_id,
    stg.message_text,
    stg.message_date_time,
    stg.views_count,
    stg.forwards_count,
    stg.replies_count,
    stg.has_media,
    stg.scraped_at,
    dc.channel_name,
    dd.date_day
FROM
    {{ ref('stg_telegram_messages') }} stg
LEFT JOIN
    {{ ref('dim_channels') }} dc ON stg.channel_name = dc.channel_name
LEFT JOIN
    {{ ref('dim_dates') }} dd ON CAST(stg.message_date_time AS DATE) = dd.date_day

-- models/staging/stg_telegram_messages.sql

WITH source_messages AS (
    SELECT
        id AS raw_id,
        channel_name,
        message_id,
        data,
        scraped_at
    FROM
        {{ source('public', 'raw_telegram_messages') }}
)

SELECT
    raw_id,
    channel_name,
    message_id,
    data->>'message' AS message_text,
    data->>'date' AS message_date_time,
    (data->>'views')::INT AS views_count,
    (data->>'forwards')::INT AS forwards_count,
    (data->>'replies')::INT AS replies_count,
    (data->>'media') IS NOT NULL AS has_media,
    scraped_at
FROM
    source_messages

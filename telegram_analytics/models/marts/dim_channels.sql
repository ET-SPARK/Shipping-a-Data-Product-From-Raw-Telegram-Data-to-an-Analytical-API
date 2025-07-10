-- models/marts/dim_channels.sql

SELECT DISTINCT
    channel_name
FROM
    {{ ref('stg_telegram_messages') }}

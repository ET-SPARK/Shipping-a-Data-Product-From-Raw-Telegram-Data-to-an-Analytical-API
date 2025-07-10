-- models/marts/dim_dates.sql

SELECT DISTINCT
    CAST(message_date_time AS DATE) AS date_day,
    EXTRACT(YEAR FROM CAST(message_date_time AS DATE)) AS year,
    EXTRACT(MONTH FROM CAST(message_date_time AS DATE)) AS month,
    EXTRACT(DAY FROM CAST(message_date_time AS DATE)) AS day,
    EXTRACT(DOW FROM CAST(message_date_time AS DATE)) AS day_of_week,
    EXTRACT(WEEK FROM CAST(message_date_time AS DATE)) AS week_of_year
FROM
    {{ ref('stg_telegram_messages') }}

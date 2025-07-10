-- models/marts/fct_image_detections.sql

SELECT
    id AS detection_id,
    message_id,
    channel_name,
    detected_object_class,
    confidence_score,
    image_path,
    detected_at
FROM
    {{ source('public', 'raw_image_detections') }}

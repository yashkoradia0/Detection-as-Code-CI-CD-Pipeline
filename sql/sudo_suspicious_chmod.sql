SELECT
  extract(rawLog, 'USER=([a-zA-Z0-9_-]+)') AS target_user,
  extract(rawLog, 'COMMAND=(.*)') AS executed_command,
  receivedAt
FROM
  logs
WHERE
  rawLog ILIKE '%sudo:%'
  AND rawLog ILIKE '%chmod %'
  AND (
    rawLog ILIKE '%777%' 
    OR (rawLog ILIKE '%+x%' AND rawLog ILIKE '%/tmp/%')
  )
  AND receivedAt >= NOW() - INTERVAL 15 MINUTE

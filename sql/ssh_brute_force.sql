SELECT
  extract(rawLog, 'from ([0-9]+\\.[0-9]+\\.[0-9]+\\.[0-9]+)') AS attacker_ip,
  COUNT(*) as failed_attempts,
  MIN(receivedAt) as first_attempt,
  MAX(receivedAt) as last_attempt
FROM logs
WHERE
  rawLog ILIKE '%Failed password%'
  AND rawLog NOT ILIKE '%SELECT%' 
  AND rawLog ILIKE '%sshd%'       
  AND receivedAt >= NOW() - INTERVAL 5 MINUTE
GROUP BY attacker_ip
HAVING COUNT(*) >= 3

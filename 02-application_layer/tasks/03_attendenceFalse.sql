INSERT INTO PenaltyDots (user_id, session_id)
SELECT u.id, s.id
FROM Users u, Sessions s
WHERE u.email_address = 'johnny@stud.ntnu.no'
  AND s.session_type_name = 'Spin60'
ORDER BY s.start_datetime ASC
LIMIT 1
ON CONFLICT (user_id, session_id) DO NOTHING;

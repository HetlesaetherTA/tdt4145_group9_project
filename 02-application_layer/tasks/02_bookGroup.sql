INSERT INTO SignUps (user_id, session_id)
SELECT u.id, s.id
FROM Users u, Sessions s
JOIN Centers c ON s.hall_id IN (SELECT id FROM Halls WHERE center_id = c.id)
WHERE u.email_address = 'johnny@stud.ntnu.no'
  AND s.session_type_name = 'Spin60'
  AND s.start_datetime = '2026-03-17 18:30:00'
  AND c.name = 'Sit Øya'
LIMIT 1;

SELECT DISTINCT
    s.session_type_name AS training_type,
    c.name AS training_center,
    s.start_datetime
FROM Users u
INNER JOIN SignUps su ON u.id = su.user_id 
INNER JOIN Sessions s ON su.session_id = s.id 
INNER JOIN Halls h ON s.hall_id = h.id 
INNER JOIN Centers c ON h.center_id = c.id 
WHERE u.email_address = 'johnny@stud.ntnu.no' 
  AND s.start_datetime >= '2026-01-01' 
ORDER BY s.start_datetime ASC;

SELECT 
    u1.email_address AS student_a, 
    u2.email_address AS student_b, 
    COUNT(s1.session_id) AS joint_sessions
FROM SignUps s1
JOIN SignUps s2 ON s1.session_id = s2.session_id
JOIN Users u1 ON s1.user_id = u1.id
JOIN Users u2 ON s2.user_id = u2.id
WHERE s1.user_id < s2.user_id
GROUP BY u1.email_address, u2.email_address
HAVING joint_sessions > 0
ORDER BY joint_sessions DESC;

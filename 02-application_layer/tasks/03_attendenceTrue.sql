DELETE FROM PenaltyDots 
WHERE user_id = (SELECT id FROM Users WHERE email_address = 'johnny@stud.ntnu.no')
  AND session_id = (
      SELECT id FROM Sessions 
      WHERE session_type_name = 'Spin60' 
      ORDER BY start_datetime ASC 
      LIMIT 1
  );

INSERT INTO SignUps (user_id, session_id)
SELECT u.id, 2
  FROM Users u
  WHERE u.email_address = 'johnny@stud.ntnu.no'
  AND (
  SELECT COUNT(*) 
  FROM PenaltyDots pd 
  WHERE pd.user_id = u.id 
  AND pd.exp > date('now')
  ) < 3;


WITH Params AS (
  SELECT '2026-03-16' AS start_date,
  7 AS days_to_add
)
SELECT 
    s.start_datetime,
    s.session_type_name,
    c.name AS center_name
FROM Sessions s
INNER JOIN Halls h ON s.hall_id = h.id 
INNER JOIN Centers c ON h.center_id = c.id 
CROSS JOIN Params p
WHERE s.start_datetime >= p.start_date 
  AND s.start_datetime < date(p.start_date, '+' || p.days_to_add || ' days')
ORDER BY s.start_datetime ASC;

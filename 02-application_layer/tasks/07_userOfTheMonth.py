import lib.databaseAPI as db
from lib.renderer import state, history


def solutionPython():
    param = "2026-03"
    query = f"""
    WITH AttendanceCounts AS (
        SELECT 
            u.first_name, 
            u.last_name, 
            u.email_address,
            COUNT(su.session_id) as session_count
        FROM Users u
        JOIN SignUps su ON u.id = su.user_id 
        JOIN Sessions s ON su.session_id = s.id 
        WHERE strftime('%Y-%m', s.start_datetime) = '{param}' 
        GROUP BY u.id
    ),
    MaxAttendance AS (
        SELECT MAX(session_count) as top_score FROM AttendanceCounts
    )
    SELECT first_name, last_name, email_address, session_count
    FROM AttendanceCounts, MaxAttendance
    WHERE session_count = top_score;
    """

    text = db.formattedQuery(query)
    state.setFrame(text)
    history.run()


def joinSession():
    cur = db.conn.cursor()

    try:
        cur.execute("""
                    INSERT INTO SignUps (user_id, session_id) VALUES
                    (14, 10);
                    """)
    except:
        pass

    cur.close()
    solutionPython()


menu = {"Run Python": solutionPython, "Join Session": joinSession}


def goto():
    history.append(menu, "")
    history.run()

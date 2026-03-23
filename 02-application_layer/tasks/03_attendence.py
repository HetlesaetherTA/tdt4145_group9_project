import lib.databaseAPI as db
from lib.renderer import state, history


class Attended:
    def __init__(self):
        self.bool = False

    def toggle(self):
        self.bool = not self.bool

        state.setFrame(read())
        history.run()


attended = Attended()


def solutionPython():
    cur = db.conn.cursor()
    params = ("johnny@stud.ntnu.no", "Spin60")

    getIdsQuery = """
                    SELECT u.id, s.id
                    FROM Users u, Sessions s
                    WHERE u.email_address = ?
                    AND s.session_type_name = ?
                    ORDER BY s.start_datetime ASC
                """

    cur.execute(getIdsQuery, params)
    u_id, s_id = cur.fetchone()

    if attended.bool:
        cur.execute(
            "DELETE FROM PenaltyDots WHERE user_id = ? AND session_id = ?", (u_id, s_id)
        )
    else:
        cur.execute(
            "INSERT OR IGNORE INTO PenaltyDots (user_id, session_id) VALUES (?, ?)",
            (u_id, s_id),
        )

    state.setFrame(read())
    history.run()


def solutionSql():
    # This is necesary becuase the definition of "not attended"
    # in my schema is:
    # 1. User is signed up to session
    # 2. Session is in the past
    # 3. If a penaltyDot was not given to user, attendence is valid
    #
    # I do this because having a attended? attribute breaks
    # normal form as PenaltyDots already infer this property
    if attended.bool:
        db.runScript("./03_attendenceTrue.sql")
    else:
        db.runScript("./03_attendenceFalse.sql")

    state.setFrame(read())
    history.run()


def delete():
    cur = db.conn.cursor()
    cur.execute(
        """
        DELETE FROM PenaltyDots WHERE user_id = 14 AND session_id = 4
        """
    )
    state.setFrame(read())
    history.run()


def read():
    res = db.formattedQuery("""
                             SELECT u.email_address, session_id, exp 
                             FROM PenaltyDots pd
                             INNER JOIN Sessions s ON pd.session_id = s.id
                             INNER JOIN Users u ON pd.user_id = u.id
                             """)
    return f"Johnny attended? {attended.bool}\n\n{res}"


menu = {
    "Toggle Attended": attended.toggle,
    "Run Python": solutionPython,
    "Run SQL": solutionSql,
    "Remove PenaltyDots": delete,
}


def goto():
    history.append(menu, read())
    history.run()

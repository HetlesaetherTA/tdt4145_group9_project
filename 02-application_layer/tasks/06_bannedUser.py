import lib.databaseAPI as db
from lib.renderer import state, history


class Banned:
    def __init__(self):
        self.bool = False

    def toggle(self):
        cur = db.conn.cursor()

        if not self.bool:
            cur.execute("""
            INSERT INTO PenaltyDots (user_id, session_id) VALUES 
            (14, 5),
            (14, 8),
            (14, 7);
            """)
        else:
            cur.execute("""
            DELETE FROM PenaltyDots WHERE user_id = '14'
            """)

        self.bool = not self.bool

        state.setFrame(read())
        history.run()
        cur.close()


banned = Banned()


def read():
    penaltyDots = db.formattedQuery("""
                            SELECT u.email_address, session_id, exp 
                            FROM PenaltyDots pd
                            INNER JOIN Sessions s ON pd.session_id = s.id
                            INNER JOIN Users u ON pd.user_id = u.id
                            """)

    signUps = db.formattedQuery("""
                            SELECT u.email_address, session_id
                            FROM SignUps su
                            INNER JOIN Sessions s ON su.session_id = s.id
                            INNER JOIN Users u ON su.user_id = u.id
                            WHERE u.email_address = 'johnny@stud.ntnu.no'
                                """)
    return f"Johnny banned? {banned.bool}\n\nPenaltyDots:\n{penaltyDots}\n\nSign Ups:\n{signUps}"


def solutionSql():
    try:
        db.runScript("./06_bannedUser.sql")
    except:
        pass

    state.setFrame(read())
    history.run()


def solutionPython():
    cur = db.conn.cursor()

    error = ""
    try:
        cur.execute("""
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
                        """)
    except:
        pass

    cur.close()
    state.setFrame(read())
    history.run()


def deleteSignUp():
    cur = db.conn.cursor()

    cur.execute("""
                DELETE FROM SignUps WHERE session_id = 2
                """)

    cur.close()

    state.setFrame(read())
    history.run()


menu = {
    "Toggle Ban": banned.toggle,
    "Run Python": solutionPython,
    "Run SQL": solutionSql,
    "Delete Sign Up": deleteSignUp,
}


def goto():
    history.append(menu, read())

    state.setFrame(read())
    history.run()

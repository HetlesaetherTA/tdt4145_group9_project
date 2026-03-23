import lib.databaseAPI as db
from lib.renderer import state, history


def solutionPython():
    cur = db.conn.cursor()

    params = ("johnny@stud.ntnu.no", "Spin60", "2026-03-17 18:30:00", "Sit Øya")

    sql = """
    INSERT INTO SignUps (user_id, session_id)
    SELECT u.id, s.id
    FROM Users u
    CROSS JOIN Sessions s
    JOIN Halls h ON s.hall_id = h.id
    JOIN Centers c ON h.center_id = c.id
    WHERE u.email_address = ? 
      AND s.session_type_name = ? 
      AND s.start_datetime = ?
      AND c.name = ?
    """

    error = ""

    try:
        cur.execute(sql, params)
    except:
        error = "Failed: Already added?"
    finally:
        cur.close()

    state.setFrame(f"{read()}\n\n{error}")

    run()


def solutionSql():
    error = ""

    try:
        path = "./02_bookGroup.sql"
        db.runScript(path)
    except:
        error = "Failed: Already added?"

    state.setFrame(f"{read()}\n\n{error}")
    run()


def delete():
    cur = db.conn.cursor()

    try:
        cur.execute("""
            DELETE FROM SignUps WHERE user_id = '14'
        """)
    except:
        pass

    cur.close()

    state.setFrame(read())
    run()


def read():
    return db.formattedQuery("""
        SELECT user_id, session_id, email_address
        FROM Sessions 
        INNER JOIN SignUps ON SignUps.session_id = Sessions.id
        INNER JOIN Users ON SignUps.user_id = Users.id
        WHERE (Users.email_address == 'johnny@stud.ntnu.no')
        """)


menu = {"Run Python": solutionPython, "Run SQL": solutionSql, "Remove SignUp": delete}


def run():
    while state.render(menu):
        pass


def goto():
    history.append(menu, read())
    history.run()

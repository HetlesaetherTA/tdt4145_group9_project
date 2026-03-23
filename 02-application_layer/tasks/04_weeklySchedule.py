import lib.databaseAPI as db
from lib.renderer import state, history

from datetime import datetime, timedelta


def solutionPython():
    param = "2026-03-16"

    start_date_obj = datetime.strptime(param, "%Y-%m-%d")
    end_date_obj = start_date_obj + timedelta(days=7)

    start_str = start_date_obj.strftime("%Y-%m-%d")
    end_str = end_date_obj.strftime("%Y-%m-%d")

    text = db.formattedQuery(f"""
        SELECT start_datetime, session_type_name, c.name 
        FROM Sessions s
        INNER JOIN Halls h ON s.hall_id = h.id
        INNER JOIN Centers c ON h.center_id = c.id
        WHERE start_datetime >= '{start_str}'
          AND start_datetime < '{end_str}'
        ORDER BY start_datetime ASC
    """)

    state.setFrame(text)
    history.run()


def solutionSql():
    sqlFile = db.path / "04_weeklySchedule.sql"
    query = sqlFile.read_text()

    text = db.formattedQuery(query)
    state.setFrame(text)
    history.run()


menu = {"Run Python": solutionPython, "Run SQL": solutionSql}


def goto():
    history.append(menu, "")
    history.run()

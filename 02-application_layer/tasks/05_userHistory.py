import lib.databaseAPI as db
from lib.renderer import state, history


def solutionSql():
    sqlFile = db.path / "05_userHistory.sql"
    query = sqlFile.read_text()

    text = db.formattedQuery(query)
    state.setFrame(text)
    history.run()


menu = {"Run SQL": solutionSql}


def goto():
    history.append(menu, "")
    history.run()

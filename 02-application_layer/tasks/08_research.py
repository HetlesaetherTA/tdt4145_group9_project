import lib.databaseAPI as db
from lib.renderer import state, history


def solutionSql():
    path = db.path / "08_research.sql"
    query = path.read_text()

    text = db.formattedQuery(query)

    state.setFrame(text)
    history.run()


def seedResearchData():
    try:
        db.runScript("08_researchData.sql")
    except Exception as e:
        state.setFrame(e)
        history.run()


menu = {"Run SQL": solutionSql, "Seed Research Data": seedResearchData}


def goto():
    history.append(menu, "")
    history.run()

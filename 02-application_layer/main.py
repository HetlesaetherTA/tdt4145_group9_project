import lib.databaseAPI as db
from lib.renderer import state, history
import importlib

tasks = {
    "02": importlib.import_module("tasks.02_bookGroup"),
    "03": importlib.import_module("tasks.03_attendence"),
    "04": importlib.import_module("tasks.04_weeklySchedule"),
    "05": importlib.import_module("tasks.05_userHistory"),
    "06": importlib.import_module("tasks.06_bannedUser"),
    "07": importlib.import_module("tasks.07_userOfTheMonth"),
    "08": importlib.import_module("tasks.08_research"),
}


def initSchema():
    db.runScript("00_schema.sql")
    sync()


def initSeed():
    error = ""
    try:
        db.runScript("01_seed.sql")
    except Exception as e:
        error = f"Error: {e}"
    state.setFrame(f"{db.peak()}\n\n{error}")
    history.run()


def dropTables():
    db.dropTables()
    sync()


def sync():
    state.setFrame(db.peak())
    history.run()


menu = {
    "Initialize Schema": initSchema,
    "usecase 1) Initialize Seed": initSeed,
    "usecase 2) Book Group": tasks["02"].goto,
    "usecase 3) Register Attendence": tasks["03"].goto,
    "usecase 4) Weekly Schedule": tasks["04"].goto,
    "usecase 5) User History": tasks["05"].goto,
    "usecase 6) Banned Users": tasks["06"].goto,
    "usecase 7) User of The Month": tasks["07"].goto,
    "usecase 8) Co-Traning Research": tasks["08"].goto,
    "Drop Tables": dropTables,
    "Sync (back uses old frames)": sync,
}


def main():
    history.append(menu, db.peak())

    sync()


if __name__ == "__main__":
    main()

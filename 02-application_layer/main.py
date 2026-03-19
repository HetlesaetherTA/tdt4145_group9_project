import lib.databaseAPI as db
from lib.renderer import state


def initSchema():
    db.runScript("00-schema.sql")
    main()


def initSeed():
    db.runScript("01-seed.sql")
    main()


menu = {
    "Initialize Schema": initSchema,
    "usecase 1) Initialize Seed": initSeed,
    "usecase 2) Book Group": initSeed,
    "usecase 3) Register Attendence": initSeed,
    "usecase 4) Weekly Schedule": initSeed,
    "usecase 5) User History": initSeed,
    "usecase 6) Banned Users": initSeed,
    "usecase 7) User of The Month": initSeed,
    "usecase 8) Co-Traning Research": initSeed,
}


def main():
    state.setFrame(db.peak())

    while state.render(menu):
        pass


if __name__ == "__main__":
    main()

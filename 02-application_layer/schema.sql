-- Deletion:
-- I've chosen to not do cascade for deletion as it wasn't made clear
-- what history we wan't to preserve. Best to handle that on application
-- layer for now. Good idea to delay irreversable decitions. 


-- Note:
-- I like to use as few restraints as possible in my schema designs
-- to make it more comfortable to program in, but otherwise I NOT NULL everything
-- I've given my justification for why where I've [omit NOT NULL] 

CREATE TABLE Locations (
    id INTEGER PRIMARY KEY,
    address TEXT NOT NULL,
    building_number TEXT,
  -- [omit NOT NULL] some addresses might not have buildning number, not hard contraint
    city TEXT NOT NULL,
    zip_code TEXT NOT NULL,
    state TEXT NOT NULL,
    country TEXT NOT NULL
);

CREATE TABLE Centers (
    id INTEGER PRIMARY KEY,
    location_id INTEGER NOT NULL,
    name TEXT UNIQUE NOT NULL,
    FOREIGN KEY (location_id) REFERENCES Locations(id)
);

CREATE TABLE Facilities (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE CenterFacilities (
    center_id INTEGER,
    facility_id INTEGER,
    PRIMARY KEY (center_id, facility_id),
    FOREIGN KEY (center_id) REFERENCES Centers(id),
    FOREIGN KEY (facility_id) REFERENCES Facilities(id)
);

CREATE TABLE OpeningHours (
    center_id INTEGER,
    day_of_week INTEGER,
    open_time TIME NOT NULL,
    close_time TIME NOT NULL,
    PRIMARY KEY (center_id, day_of_week),
    FOREIGN KEY (center_id) REFERENCES Centers(id),
  	CHECK (open_time < close_time),
    CHECK (day_of_week BETWEEN 1 AND 7)
);

CREATE TABLE Users (
    id INTEGER PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email_address TEXT NOT NULL,
    phone_number TEXT NOT NULL
  -- we we're not asked to validate email/phone nr, but this could
  -- be done in application layer
);

CREATE TABLE Staff (
    user_id INTEGER PRIMARY KEY,
    FOREIGN KEY (user_id) REFERENCES Users(id)
);

CREATE TABLE StaffHours (
    staff_user_id INTEGER,
    center_id INTEGER,
  -- [omit NOT NULL] could be remote office, not hard constraint
    date DATE,
    shift_start TIME NOT NULL,
    shift_end TIME NOT NULL,
    PRIMARY KEY (staff_user_id, date, shift_start),
    FOREIGN KEY (staff_user_id) REFERENCES Staff(user_id),
    FOREIGN KEY (center_id) REFERENCES Centers(id),
  	CHECK (shift_start < shift_end)
  -- If staff hours roll over midnight a new StaffHours with a new 
  -- date should be created by the application layer.
  -- This should be a very low level function, higher level application
  -- scopes should be able to use one object, but the DB api abstracts this. 
);

CREATE TABLE Halls (
    id INTEGER PRIMARY KEY,
    center_id INTEGER not NULL,
    capacity INTEGER NOT NULL,
    FOREIGN KEY (center_id) REFERENCES Centers(id),
  	CHECK (capacity > 0)
);

CREATE TABLE Manufacturers (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE Bicycles (
    id INTEGER PRIMARY KEY,
    manufacturer_id INTEGER NOT NULL,
    hall_id INTEGER,
  -- [omit NOT NULL] could be in storage, not hard constraint
    sticker_number INTEGER UNIQUE NOT NULL,
    bluetooth_key TEXT,
  -- [omit NOT NULL] NULL indicates no bluetooth
    FOREIGN KEY (manufacturer_id) REFERENCES Manufacturers(id),
    FOREIGN KEY (hall_id) REFERENCES Halls(id)
);

CREATE TABLE Treadmills (
    id INTEGER PRIMARY KEY,
    manufacturer_id INTEGER NOT NULL,
    hall_id INTEGER,
   -- [omit NOT NULL] could be in storage, not hard constraint
    sticker_number INTEGER UNIQUE NOT NULL,
    max_speed INTEGER NOT NULL,
    max_incline INTEGER NOT NULL,
    bluetooth_key TEXT,
  -- [omit NOT NULL] NULL indicates no bluetooth
    FOREIGN KEY (manufacturer_id) REFERENCES Manufacturers(id),
    FOREIGN KEY (hall_id) REFERENCES Halls(id),
  	CHECK (max_speed > 0),
  	CHECK (max_incline >= 0) 
);

CREATE TABLE SessionTypes (
    name TEXT PRIMARY KEY,
    description TEXT NOT NULL
);

CREATE TABLE Sessions (
    id INTEGER PRIMARY KEY,
    staff_user_id INTEGER,
  -- [omit NOT NULL] could be ownerless digital content, not hard constraint
    hall_id INTEGER,
  -- [omit NOT NULL] could be digital, not hard constraint
    session_type_name TEXT NOT NULL,
    start_datetime DATETIME NOT NULL,
    end_datetime DATETIME NOT NULL,
    FOREIGN KEY (staff_user_id) REFERENCES Staff(user_id),
    FOREIGN KEY (hall_id) REFERENCES Halls(id),
    FOREIGN KEY (session_type_name) REFERENCES SessionTypes(name),
  	CHECK (start_datetime < end_datetime)
);

CREATE TABLE SignUps (
    user_id INTEGER,
    session_id INTEGER,
    PRIMARY KEY (user_id, session_id),
    FOREIGN KEY (user_id) REFERENCES Users(id),
    FOREIGN KEY (session_id) REFERENCES Sessions(id)
  -- Here we need a check if session.capacity is less than number of 
  -- people signed up before another user can sign up, 
  -- but as sessoin.hall[id].capacity is not a candidate key it
  -- should be handled on the application layer to maintain clean BCNF
  
  -- There are also contrains about when users can sign up or unregister
  -- from sessions. Timestamps aren't strictly candidate keys + 
  -- working with dates in general can be messy and there might be exceptions
  -- in the future. All these factors contribute to the argument that this shoud
  -- be handled on the application layer to ensure BCNF and better dev experience.
);

CREATE TABLE PenaltyDots (
    user_id INTEGER,
    session_id INTEGER,
    exp DATETIME DEFAULT (datetime('now', '+30 days')),
    PRIMARY KEY (user_id, session_id),
    FOREIGN KEY (user_id) REFERENCES Users(id),
    FOREIGN KEY (session_id) REFERENCES Sessions(id)
);

CREATE TABLE Waitlist (
    user_id INTEGER,
    session_id INTEGER,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, session_id),
    FOREIGN KEY (user_id) REFERENCES Users(id),
    FOREIGN KEY (session_id) REFERENCES Sessions(id)
);

CREATE TABLE Teams (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT
  -- [omit NOT NULL] teams are made by users (I assume), loser constinters for
  -- user input is generally a good idea to improve UX - does not require
  -- description immidietly when making a team for first time.
);

CREATE TABLE TeamMembers (
    user_id INTEGER,
    team_id INTEGER,
    PRIMARY KEY (user_id, team_id),
    FOREIGN KEY (user_id) REFERENCES Users(id),
    FOREIGN KEY (team_id) REFERENCES Teams(id)
);

CREATE TABLE Reservations (
    id INTEGER PRIMARY KEY,
    hall_id INTEGER NOT NULL,
    team_id INTEGER,
  -- [omit NOT NULL] leaving open to prevent bad practice of creating dummy 
  -- teams for out of scope reservations like renovations. 
    start_datetime DATETIME NOT NULL,
    end_datetime DATETIME NOT NULL,
    FOREIGN KEY (hall_id) REFERENCES Halls(id),
    FOREIGN KEY (team_id) REFERENCES Teams(id),
  	CHECK (start_datetime < end_datetime)
);

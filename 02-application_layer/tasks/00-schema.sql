-- Changes from first assignment:
-- 1. CREATE TABLE -> CREATE TABLE IF NOT EXISTS for all tables

CREATE TABLE IF NOT EXISTS Locations (
    id INTEGER PRIMARY KEY,
    address TEXT NOT NULL,
    building_number TEXT,
    city TEXT NOT NULL,
    zip_code TEXT NOT NULL,
    state TEXT NOT NULL,
    country TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS Centers (
    id INTEGER PRIMARY KEY,
    location_id INTEGER NOT NULL,
    name TEXT UNIQUE NOT NULL,
    FOREIGN KEY (location_id) REFERENCES Locations(id)
);
CREATE TABLE IF NOT EXISTS Facilities (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS CenterFacilities (
    center_id INTEGER,
    facility_id INTEGER,
    PRIMARY KEY (center_id, facility_id),
    FOREIGN KEY (center_id) REFERENCES Centers(id),
    FOREIGN KEY (facility_id) REFERENCES Facilities(id)
);
CREATE TABLE IF NOT EXISTS OpeningHours (
    center_id INTEGER,
    day_of_week INTEGER,
    open_time TIME NOT NULL,
    close_time TIME NOT NULL,
    PRIMARY KEY (center_id, day_of_week),
    FOREIGN KEY (center_id) REFERENCES Centers(id),
  	CHECK (open_time < close_time),
    CHECK (day_of_week BETWEEN 1 AND 7)
);
CREATE TABLE IF NOT EXISTS Users (
    id INTEGER PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email_address TEXT NOT NULL,
    phone_number TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS Staff (
    user_id INTEGER PRIMARY KEY,
    FOREIGN KEY (user_id) REFERENCES Users(id)
);
CREATE TABLE IF NOT EXISTS StaffHours (
    staff_user_id INTEGER,
    center_id INTEGER,
    date DATE,
    shift_start TIME NOT NULL,
    shift_end TIME NOT NULL,
    PRIMARY KEY (staff_user_id, date, shift_start),
    FOREIGN KEY (staff_user_id) REFERENCES Staff(user_id),
    FOREIGN KEY (center_id) REFERENCES Centers(id),
  	CHECK (shift_start < shift_end)
);
CREATE TABLE IF NOT EXISTS Halls (
    id INTEGER PRIMARY KEY,
    center_id INTEGER not NULL,
    capacity INTEGER NOT NULL,
    FOREIGN KEY (center_id) REFERENCES Centers(id),
  	CHECK (capacity > 0)
);
CREATE TABLE IF NOT EXISTS Manufacturers (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS Bicycles (
    id INTEGER PRIMARY KEY,
    manufacturer_id INTEGER NOT NULL,
    hall_id INTEGER,
    sticker_number INTEGER UNIQUE NOT NULL,
    bluetooth_key TEXT,
    FOREIGN KEY (manufacturer_id) REFERENCES Manufacturers(id),
    FOREIGN KEY (hall_id) REFERENCES Halls(id)
);
CREATE TABLE IF NOT EXISTS Treadmills (
    id INTEGER PRIMARY KEY,
    manufacturer_id INTEGER NOT NULL,
    hall_id INTEGER,
    sticker_number INTEGER UNIQUE NOT NULL,
    max_speed INTEGER NOT NULL,
    max_incline INTEGER NOT NULL,
    bluetooth_key TEXT,
    FOREIGN KEY (manufacturer_id) REFERENCES Manufacturers(id),
    FOREIGN KEY (hall_id) REFERENCES Halls(id),
  	CHECK (max_speed > 0),
  	CHECK (max_incline >= 0) 
);
CREATE TABLE IF NOT EXISTS SessionTypes (
    name TEXT PRIMARY KEY,
    description TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS Sessions (
    id INTEGER PRIMARY KEY,
    staff_user_id INTEGER,
    hall_id INTEGER,
    session_type_name TEXT NOT NULL,
    start_datetime DATETIME NOT NULL,
    end_datetime DATETIME NOT NULL,
    FOREIGN KEY (staff_user_id) REFERENCES Staff(user_id),
    FOREIGN KEY (hall_id) REFERENCES Halls(id),
    FOREIGN KEY (session_type_name) REFERENCES SessionTypes(name),
  	CHECK (start_datetime < end_datetime)
);
CREATE TABLE IF NOT EXISTS SignUps (
    user_id INTEGER,
    session_id INTEGER,
    PRIMARY KEY (user_id, session_id),
    FOREIGN KEY (user_id) REFERENCES Users(id),
    FOREIGN KEY (session_id) REFERENCES Sessions(id)
  
);
CREATE TABLE IF NOT EXISTS PenaltyDots (
    user_id INTEGER,
    session_id INTEGER,
    exp DATETIME DEFAULT (datetime('now', '+30 days')),
    PRIMARY KEY (user_id, session_id),
    FOREIGN KEY (user_id) REFERENCES Users(id),
    FOREIGN KEY (session_id) REFERENCES Sessions(id)
);
CREATE TABLE IF NOT EXISTS Waitlist (
    user_id INTEGER,
    session_id INTEGER,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, session_id),
    FOREIGN KEY (user_id) REFERENCES Users(id),
    FOREIGN KEY (session_id) REFERENCES Sessions(id)
);
CREATE TABLE IF NOT EXISTS Teams (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT
);
CREATE TABLE IF NOT EXISTS TeamMembers (
    user_id INTEGER,
    team_id INTEGER,
    PRIMARY KEY (user_id, team_id),
    FOREIGN KEY (user_id) REFERENCES Users(id),
    FOREIGN KEY (team_id) REFERENCES Teams(id)
);
CREATE TABLE IF NOT EXISTS Reservations (
    id INTEGER PRIMARY KEY,
    hall_id INTEGER NOT NULL,
    team_id INTEGER,
    start_datetime DATETIME NOT NULL,
    end_datetime DATETIME NOT NULL,
    FOREIGN KEY (hall_id) REFERENCES Halls(id),
    FOREIGN KEY (team_id) REFERENCES Teams(id),
  	CHECK (start_datetime < end_datetime)
);

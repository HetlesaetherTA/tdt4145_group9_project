-- Global


INSERT INTO Facilities (name) VALUES
('Gruppetrening'),
('Egentrening'),
('Utholdenhet'),
('Styrke'),
('Yoga'),
('Klatring'),
('Spinning'),
('Hall'),
('Garderober'),
('Badstue'),
('Dusj'),
('Ubemannet treningssenter'),
('Tilgjenglighet'),
('Squash'),
('Bemannet resepsjon');

INSERT INTO Users (first_name, last_name, email_address, phone_number) VALUES
('Eirin', 'H.', 'EirinH@sit.no', '90000000'),
('Jorunn', 'B. B.', 'JorunnBB@sit.no', '90000001'),
('Trine', 'R.', 'TrineR@sit.no', '90000003'),
('Nora', 'D.', 'NoraD@sit.no', '90000004'),
('Hakon', 'W.', 'HakonW@sit.no', '90000005'),
('Ada', 'J. R.', 'AdaJR@sit.no', '90000006'),
('Sindre', 'K. S.', 'SindreKS@sit.no', '90000007'),
('Kaja', 'S.', 'KajaS@sit.no', '90000008'),
('Amalie', 'M. H.', 'AmalieMH@sit.no', '90000009'),
('Ramona', 'L. S.', 'RamonaLS@sit.no', '90000010'),
('Siri', 'M. L.', 'SiriML@sit.no', '90000011'),
('Ada', 'J. R.', 'AdaJR@sit.no', '90000012');

INSERT INTO Staff (user_id) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10),
(11),
(12);
-- Oya treningsenter

INSERT INTO Locations (address, building_number, city, zip_code, state, country) VALUES
('Vangslunds Gate', '2', 'Trondheim', '7030', 'Trondelag', 'Norway');

INSERT INTO Centers (location_id, name) VALUES
(1, 'Sit Øya');

INSERT INTO CenterFacilities (center_id, facility_id) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(1, 9),
(1, 10),
(1, 11),
(1, 12),
(1, 13);



INSERT INTO OpeningHours (center_id, day_of_week, open_time, close_time) VALUES
(1, 1, '05:00:00', '23:00:00'),
(1, 2, '05:00:00', '23:00:00'),
(1, 3, '05:00:00', '23:00:00'),
(1, 4, '05:00:00', '23:00:00'),
(1, 5, '05:00:00', '23:00:00'),
(1, 6, '05:00:00', '23:00:00'),
(1, 7, '05:00:00', '23:00:00');

INSERT INTO Halls (center_id, capacity) VALUES 
(1, 38),
(1, 10);

INSERT INTO SessionTypes (name, description) VALUES 
('Spin 4x4', 'En forutsigbar intervalltime: 4 stående intervaller på 4 minutter hver, med ca 2 minutter aktiv pause mellom hvert drag. God oppvarming og nedsykling inkludert.'),
('Spin 8x3', 'En forutsigbar intervalltime med 8 intervaller på 3 minutter hver, der du sitter og står annethvert drag. 90-120 sek pause mellom hvert intervall. God oppvarming og nedsykling inkludert.'),
('Spin45', 'En variert spinningtime med 2-3 arbeidsperioder som passer for alle. Perfekt for deg som er ny på spinning! Du styrer intensiteten selv, og vi bruker takta til å tråkke oss gjennom timen.'),
('Spin60', 'En variert spinningtime som er noe mer utfordrende enn Spin45 med lengre varighet og tidvis høyere tempo. Du styrer likevel intensiteten selv, og timen passer alle som liker å tråkke i takt! Timen inneholder 2-4 arbeidsperioder med variert løype.');


INSERT INTO Sessions (staff_user_id, hall_id, session_type_name, start_datetime, end_datetime) VALUES
(1, 1, 'Spin 4x4', '2026-03-16 07:00:00', '2026-03-16 07:45:00'),
(2, 1, 'Spin45', '2026-03-16 16:30:00', '2026-03-16 17:15:00'),
(10, 1, 'Spin 8x3', '2026-03-16 17:40:00', '2026-03-16 18:35:00'),
(3, 1, 'Spin60', '2026-03-16 19:00:00', '2026-03-16 20:00:00'),
(4, 1, 'Spin 8x3', '2026-03-17 07:00:00', '2026-03-17 07:55:00'),
(5, 1, 'Spin60', '2026-03-17 18:30:00', '2026-03-17 19:30:00'),
(6, 1, 'Spin45', '2026-03-17 19:45:00', '2026-03-17 20:30:00'),
(4, 1, 'Spin60', '2026-03-18 16:15:00', '2026-03-18 17:15:00'),
(7, 1, 'Spin 4x4', '2026-03-18 17:30:00', '2026-03-18 18:15:00'),
(8, 1, 'Spin45', '2026-03-18 18:30:00', '2026-03-18 19:15:00'),
(9, 1, 'Spin 8x3', '2026-03-18 19:30:00', '2026-03-18 20:25:00');

INSERT INTO Manufacturers (name) VALUES
('default');

INSERT INTO Treadmills (manufacturer_id, hall_id, sticker_number, max_speed, max_incline, bluetooth_key) VALUES 
(1,2,1, 20, 20, NULL),
(1,2,2, 25, 20, 'aslkfjasldkfjs');

INSERT INTO Bicycles (manufacturer_id, hall_id, sticker_number, bluetooth_key) VALUES
(1, 1, 1, 'asdjlgkajsj3984jfq983j'),
(1, 1, 2, 'asdjlgkajsj3984jfq983j'),
(1, 1, 3, 'asdjlgkajsj3984jfq983j'),
(1, 1, 4, 'asdjlgkajsj3984jfq983j'),
(1, 1, 5, 'asdjlgkajsj3984jfq983j'),
(1, 1, 6, 'asdjlgkajsj3984jfq983j'),
(1, 1, 7, 'asdjlgkajsj3984jfq983j'),
(1, 1, 8, 'asdjlgkajsj3984jfq983j'),
(1, 1, 9, 'asdjlgkajsj3984jfq983j'),
(1, 1, 10, 'asdjlgkajsj3984jfq983j'),
(1, 1, 11, 'asdjlgkajsj3984jfq983j'),
(1, 1, 12, 'asdjlgkajsj3984jfq983j'),
(1, 1, 13, 'asdjlgkajsj3984jfq983j'),
(1, 1, 14, 'asdjlgkajsj3984jfq983j'),
(1, 1, 15, 'asdjlgkajsj3984jfq983j'),
(1, 1, 16, 'asdjlgkajsj3984jfq983j'),
(1, 1, 17, 'asdjlgkajsj3984jfq983j'),
(1, 1, 18, 'asdjlgkajsj3984jfq983j'),
(1, 1, 19, 'asdjlgkajsj3984jfq983j'),
(1, 1, 20, 'asdjlgkajsj3984jfq983j'),
(1, 1, 21, 'asdjlgkajsj3984jfq983j'),
(1, 1, 22, 'asdjlgkajsj3984jfq983j'),
(1, 1, 23, 'asdjlgkajsj3984jfq983j'),
(1, 1, 24, 'asdjlgkajsj3984jfq983j'),
(1, 1, 25, 'asdjlgkajsj3984jfq983j'),
(1, 1, 26, 'asdjlgkajsj3984jfq983j'),
(1, 1, 27, 'asdjlgkajsj3984jfq983j'),
(1, 1, 28, 'asdjlgkajsj3984jfq983j'),
(1, 1, 29, 'asdjlgkajsj3984jfq983j'),
(1, 1, 30, 'asdjlgkajsj3984jfq983j'),
(1, 1, 31, 'asdjlgkajsj3984jfq983j'),
(1, 1, 32, 'asdjlgkajsj3984jfq983j'),
(1, 1, 33, 'asdjlgkajsj3984jfq983j'),
(1, 1, 34, 'asdjlgkajsj3984jfq983j'),
(1, 1, 35, 'asdjlgkajsj3984jfq983j'),
(1, 1, 36, 'asdjlgkajsj3984jfq983j'),
(1, 1, 37, 'asdjlgkajsj3984jfq983j'),
(1, 1, 38, 'asdjlgkajsj3984jfq983j');
-- Dragvol treningssenter
INSERT INTO Locations (address, building_number, city, zip_code, state, country) VALUES
('Loholt alle', '81', 'Trondheim', '7049', 'Trondelag', 'Norway');

INSERT INTO Centers (location_id, name) VALUES
(2, 'Sit Dragvoll');

INSERT INTO Halls (center_id, capacity) VALUES
(2, 38);

INSERT INTO CenterFacilities (center_id, facility_id) VALUES
(2, 2),
(2, 7),
(2, 5),
(2, 8),
(2, 10),
(2,11),
(2,9),
(2,15),
(2,13);

INSERT INTO Sessions(staff_user_id, hall_id, session_type_name, start_datetime, end_datetime) VALUES
(11, 3, 'Spin 4x4', '2026-03-16 16:30:00', '2026-03-16 17:15:00'),
(12, 3, 'Spin45', '2026-03-16 16:30:00', '2026-03-16 17:15:00');

-- Add user ( me :) ) 
INSERT INTO Users (first_name, last_name, email_address, phone_number) VALUES
('Thomas-Andre', 'Hetleasether', 'TA@Hetleasether.com', '40172693'),
('Johnny', 'Something', 'johnny@stud.ntnu.no', '99999999');

INSERT INTO SignUps(user_id, session_id) VALUES
(14, 8),
(14, 5),
(14, 7),
(13, 2),
(13, 3),
(13, 4);

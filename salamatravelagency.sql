CREATE DATABASE salama_agency;
USE salama_agency;

CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    upassword VARCHAR(25), 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Airlines (
    airline_id INT PRIMARY KEY AUTO_INCREMENT,
    airline_code VARCHAR(10) UNIQUE, -- (KQA, SSA, JBJ)
    airline_name VARCHAR(100) -- Kenya Airways, Silver Stone Airlines, Jambo Jet
);

CREATE TABLE Airports (
    airport_id INT PRIMARY KEY AUTO_INCREMENT,
    airport_code VARCHAR(10) UNIQUE, -- (NBO, MBA, KIS, etc.)
    city VARCHAR(50),
    country VARCHAR(50)
);

CREATE TABLE Flights (
    flight_id INT PRIMARY KEY AUTO_INCREMENT,
    airline_id INT, -- FK from Airlines
    flight_number VARCHAR(10), 
    departure_airport_id INT, -- FK from Airports
    destination_airport_id INT, -- FK from Airports
    departure_time DATETIME,
    arrival_time DATETIME,
    price DECIMAL(10,2),
    seats_available INT, -- New column for tracking availability
    FOREIGN KEY (airline_id) REFERENCES Airlines(airline_id),
    FOREIGN KEY (departure_airport_id) REFERENCES Airports(airport_id),
    FOREIGN KEY (destination_airport_id) REFERENCES Airports(airport_id)
);

CREATE TABLE HotelBranches (
    branch_id INT PRIMARY KEY AUTO_INCREMENT,
    hotel_name VARCHAR(100), -- Hilton, Sarova, Masai Mara Lodges
    branch VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE Hotels (
    hotel_id INT PRIMARY KEY AUTO_INCREMENT,
    branch_id INT, -- FK from HotelBranches
    price_per_night DECIMAL(10,2),
    total_rooms INT,
    available_rooms INT,
    FOREIGN KEY (branch_id) REFERENCES HotelBranches(branch_id)
);

CREATE TABLE PickupProviders (
    provider_id INT PRIMARY KEY AUTO_INCREMENT,
    provider_name VARCHAR(100) -- FastTrack Car Rentals, CityExpress, Global Shuttle
);

CREATE TABLE Pickups (
    pickup_id INT PRIMARY KEY AUTO_INCREMENT,
    provider_id INT, -- FK from PickupProviders
    airport VARCHAR(50), -- (NBO, MBA, etc.)
    direction ENUM('To Airport', 'From Airport'),
    taxi_number VARCHAR(20) UNIQUE,
    price DECIMAL(10,2),
    FOREIGN KEY (provider_id) REFERENCES PickupProviders(provider_id)
);

CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    booking_type ENUM('Flight', 'Hotel', 'Pickup'),
    reference_id INT, -- Links to flight_id, hotel_id, or pickup_id
    status ENUM('Booked', 'Cancelled', 'Completed') DEFAULT 'Booked',
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
CREATE TABLE Reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    review_type ENUM('Flight', 'Hotel', 'Pickup'),
    reference_id INT, -- Links to flight_id, hotel_id, or pickup_id
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
--  Users Table
INSERT INTO Users (name, email, phone, upassword) VALUES
('John Doe', 'johndoe@example.com', '+254712345678', '1234'),
('Jane Smith', 'janesmith@example.com', '+254798765432', '12345'),
('Ali Hassan', 'alihassan@example.com', '+254723456789', '123456'),
('Grace Wangari', 'gracewangari@example.com', '+254734567890', '1234567'),
('Brian Oduor', 'brianoduor@example.com', '+254745678901', '12345678'),
('Emily Chebet', 'emilychebet@example.com', '+254756789012', '123456789'),
('Daniel Mwangi', 'danielmwangi@example.com', '+254767890123', '123405'),
('Fatima Yusuf', 'fatimayusuf@example.com', '+254778901234', '123456709'),
('Kevin Kiptoo', 'kevinkiptoo@example.com', '+254789012345', '12345067'),
('Sophia Njeri', 'sophianjeri@example.com', '+254790123456', '123456070');

--  Airlines Table
INSERT INTO Airlines (airline_code, airline_name) VALUES
('KQA', 'Kenya Airways'),
('SSA', 'Silver Stone Airlines'),
('JBJ', 'Jambo Jet');

--  Airports Table
INSERT INTO Airports (airport_code, city, country) VALUES
('NBO', 'Nairobi', 'Kenya'),
('MBA', 'Mombasa', 'Kenya'),
('KIS', 'Kisumu', 'Kenya'),
('EDL', 'Eldoret', 'Kenya'),
('NAK', 'Nakuru', 'Kenya'),
('NYI', 'Nyeri', 'Kenya'),
('KAK', 'Kakamega', 'Kenya'),
('GAR', 'Garissa', 'Kenya'),
('MLD', 'Malindi', 'Kenya'),
('MMR', 'Masai Mara', 'Kenya');

--  Flights Table
INSERT INTO Flights (airline_id, flight_number, departure_airport_id, destination_airport_id, departure_time, arrival_time, price, seats_available) VALUES
(1, 'KQA011', 1, 2, '2025-04-01 08:00:00', '2025-04-01 09:30:00', 12000.00, 100),
(1, 'KQA012', 1, 3, '2025-04-01 10:00:00', '2025-04-01 11:30:00', 13000.00, 100),
(2, 'SSA300', 7, 5, '2025-04-01 12:00:00', '2025-04-01 13:30:00', 8000.00, 80),
(3, 'JBJ500', 2, 3, '2025-04-01 14:00:00', '2025-04-01 15:30:00', 11000.00, 120),
(1, 'KQA016', 1, 10, '2025-04-01 16:00:00', '2025-04-01 17:30:00', 15000.00, 100),
(2, 'SSA400', 5, 9, '2025-04-02 08:00:00', '2025-04-02 09:30:00', 9000.00, 90),
(3, 'JBJ510', 2, 5, '2025-04-02 10:00:00', '2025-04-02 11:30:00', 10000.00, 100),
(1, 'KQA120', 3, 1, '2025-04-02 12:00:00', '2025-04-02 13:30:00', 14000.00, 110),
(2, 'SSA500', 5, 8, '2025-04-02 14:00:00', '2025-04-02 15:30:00', 9500.00, 85),
(3, 'JBJ530', 2, 4, '2025-04-02 16:00:00', '2025-04-02 17:30:00', 12500.00, 90);

--  HotelBranches Table
INSERT INTO HotelBranches (hotel_name, branch, city) VALUES
('Hilton', 'Hilton Nairobi', 'Nairobi'),
('Hilton', 'Hilton Mombasa', 'Mombasa'),
('Hilton', 'Hilton Kisumu', 'Kisumu'),
('Sarova Resorts', 'Sarova Nakuru', 'Nakuru'),
('Sarova Resorts', 'Sarova Eldoret', 'Eldoret'),
('Sarova Resorts', 'Sarova Garissa', 'Garissa'),
('Masai Mara Lodges', 'Mara Lodge 1', 'Masai Mara'),
('Masai Mara Lodges', 'Mara Lodge 2', 'Masai Mara'),
('Sarova Resorts', 'Sarova Malindi', 'Malindi'),
('Hilton', 'Hilton Nyeri', 'Nyeri');

--  Hotels Table
INSERT INTO Hotels (branch_id, price_per_night, total_rooms, available_rooms) VALUES
(1, 15000.00, 100, 80),
(2, 13000.00, 80, 60),
(3, 12000.00, 90, 70),
(4, 11000.00, 60, 50),
(5, 14000.00, 75, 60),
(6, 10000.00, 50, 40),
(7, 16000.00, 120, 100),
(8, 17000.00, 110, 90),
(9, 10500.00, 65, 55),
(10, 11500.00, 70, 65);

--  PickupProviders Table
INSERT INTO PickupProviders (provider_name) VALUES
('FastTrack Car Rentals'),
('CityExpress Taxis'),
('Global Shuttle Services');

--  Pickups Table
INSERT INTO Pickups (provider_id, airport, direction, taxi_number, price) VALUES
(1, 'NBO', 'To Airport', 'FCR-NBO-001', 2000.00),
(2, 'MBA', 'From Airport', 'CET-MBA-002', 2500.00),
(3, 'KIS', 'To Airport', 'GSS-KIS-003', 2200.00),
(1, 'EDL', 'From Airport', 'FCR-EDL-004', 2100.00),
(2, 'NAK', 'To Airport', 'CET-NAK-005', 2300.00),
(3, 'NYI', 'From Airport', 'GSS-NYI-006', 2400.00),
(1, 'KAK', 'To Airport', 'FCR-KAK-007', 2600.00),
(2, 'GAR', 'From Airport', 'CET-GAR-008', 2700.00),
(3, 'MLD', 'To Airport', 'GSS-MLD-009', 2800.00),
(1, 'MMR', 'From Airport', 'FCR-MMR-010', 2900.00);

--  Bookings Table
INSERT INTO Bookings (user_id, booking_type, reference_id, status) VALUES
(1, 'Flight', 1, 'Booked'),
(2, 'Hotel', 3, 'Booked'),
(3, 'Pickup', 5, 'Booked'),
(4, 'Flight', 2, 'Cancelled'),
(5, 'Hotel', 6, 'Completed'),
(6, 'Pickup', 7, 'Booked'),
(7, 'Flight', 3, 'Completed'),
(8, 'Hotel', 9, 'Booked'),
(9, 'Pickup', 8, 'Cancelled'),
(10, 'Flight', 5, 'Booked');

--  Reviews Table
INSERT INTO Reviews (user_id, review_type, reference_id, rating, comment) VALUES
(1, 'Flight', 1, 5, 'Great experience!'),
(2, 'Hotel', 3, 4, 'Comfortable stay.'),
(3, 'Pickup', 5, 5, 'Driver was on time.'),
(4, 'Flight', 2, 3, 'Average service.'),
(5, 'Hotel', 6, 4, 'Clean and tidy.'),
(6, 'Pickup', 7, 2, 'Could be better.'),
(7, 'Flight', 3, 5, 'Loved it!'),
(8, 'Hotel', 9, 4, 'Nice view.'),
(9, 'Pickup', 8, 3, 'Took too long.'),
(10, 'Flight', 5, 5, 'Smooth flight.');


--  Get All Bookings with User Information
SELECT 
    b.booking_id, 
    u.name, 
    u.email, 
    b.booking_type, 
    b.status, 
    b.booking_date 
FROM Bookings b
-- Join Users table to get user details
JOIN Users u ON b.user_id = u.user_id;

--  Get Flight Bookings with Flight & User Details
SELECT 
    b.booking_id, 
    u.name AS user_name, 
    f.flight_number, 
    a1.city AS departure_city, 
    a2.city AS destination_city, 
    f.departure_time, 
    f.arrival_time, 
    b.status
FROM Bookings b
-- Join Users table to get user details
JOIN Users u ON b.user_id = u.user_id
-- Join Flights table to get flight details
JOIN Flights f ON b.reference_id = f.flight_id
-- Join Airports table to get departure airport details
JOIN Airports a1 ON f.departure_airport_id = a1.airport_id
-- Join Airports table to get destination airport details
JOIN Airports a2 ON f.destination_airport_id = a2.airport_id
WHERE b.booking_type = 'Flight';

--  Get Hotel Bookings with Hotel & User Details
SELECT 
    b.booking_id, 
    u.name AS user_name, 
    hb.hotel_name, 
    hb.branch, 
    h.price_per_night, 
    b.status
FROM Bookings b
-- Join Users table to get user details
JOIN Users u ON b.user_id = u.user_id
-- Join Hotels table to get hotel details
JOIN Hotels h ON b.reference_id = h.hotel_id
-- Join HotelBranches table to get branch details
JOIN HotelBranches hb ON h.branch_id = hb.branch_id
WHERE b.booking_type = 'Hotel';

--  Get Pickup Bookings with Provider & User Details
SELECT 
    b.booking_id, 
    u.name AS user_name, 
    pp.provider_name, 
    p.airport, 
    p.direction, 
    b.status
FROM Bookings b
-- Join Users table to get user details
JOIN Users u ON b.user_id = u.user_id
-- Join Pickups table to get pickup details
JOIN Pickups p ON b.reference_id = p.pickup_id
-- Join PickupProviders table to get provider details
JOIN PickupProviders pp ON p.provider_id = pp.provider_id
WHERE b.booking_type = 'Pickup';

--  Get Users Who Have Booked a Flight & a Hotel
SELECT DISTINCT 
    u.user_id, 
    u.name, 
    u.email
FROM Users u
-- Join Bookings table for flight bookings
JOIN Bookings b1 ON u.user_id = b1.user_id AND b1.booking_type = 'Flight'
-- Join Bookings table for hotel bookings (same user must have both)
JOIN Bookings b2 ON u.user_id = b2.user_id AND b2.booking_type = 'Hotel';

--  Get Users with No Bookings
SELECT 
    u.user_id, 
    u.name, 
    u.email 
FROM Users u
-- Left Join Bookings to find users without bookings
LEFT JOIN Bookings b ON u.user_id = b.user_id
WHERE b.user_id IS NULL;

--  Get Number of Bookings by Type
SELECT 
    booking_type, 
    COUNT(*) AS total_bookings 
FROM Bookings 
GROUP BY booking_type;

--  Get Available Hotel Rooms by Branch
SELECT 
    hb.hotel_name, 
    hb.branch, 
    h.total_rooms, 
    h.available_rooms 
FROM Hotels h
-- Join HotelBranches table to get hotel and branch details
JOIN HotelBranches hb ON h.branch_id = hb.branch_id
ORDER BY hb.hotel_name;

--  Get Average Flight Price by Airline
SELECT 
    a.airline_name, 
    AVG(f.price) AS avg_price
FROM Flights f
-- Join Airlines table to get airline details
JOIN Airlines a ON f.airline_id = a.airline_id
GROUP BY a.airline_name;

--  Get Flights with Less Than 10 Seats Available
SELECT 
    f.flight_number, 
    a1.city AS departure_city, 
    a2.city AS destination_city, 
    f.seats_available 
FROM Flights f
-- Join Airports table to get departure city
JOIN Airports a1 ON f.departure_airport_id = a1.airport_id
-- Join Airports table to get destination city
JOIN Airports a2 ON f.destination_airport_id = a2.airport_id
WHERE f.seats_available < 10;


CREATE VIEW User_Flight_History AS
SELECT 
    b.booking_id, 
    u.user_id,
    u.name AS user_name, 
    f.flight_number, 
    a1.city AS departure_city, 
    a2.city AS destination_city, 
    f.departure_time, 
    f.arrival_time, 
    b.status, 
    b.booking_date
FROM Bookings b
JOIN Users u ON b.user_id = u.user_id
JOIN Flights f ON b.reference_id = f.flight_id
JOIN Airports a1 ON f.departure_airport_id = a1.airport_id
JOIN Airports a2 ON f.destination_airport_id = a2.airport_id
WHERE b.booking_type = 'Flight';


CREATE VIEW User_Hotel_History AS
SELECT 
    b.booking_id, 
    u.user_id,
    u.name AS user_name, 
    hb.hotel_name, 
    hb.branch, 
    h.price_per_night, 
    b.status, 
    b.booking_date
FROM Bookings b
JOIN Users u ON b.user_id = u.user_id
JOIN Hotels h ON b.reference_id = h.hotel_id
JOIN HotelBranches hb ON h.branch_id = hb.branch_id
WHERE b.booking_type = 'Hotel';


CREATE VIEW User_Pickup_History AS
SELECT 
    b.booking_id, 
    u.user_id,
    u.name AS user_name, 
    pp.provider_name, 
    p.airport, 
    p.direction, 
    b.status, 
    b.booking_date
FROM Bookings b
JOIN Users u ON b.user_id = u.user_id
JOIN Pickups p ON b.reference_id = p.pickup_id
JOIN PickupProviders pp ON p.provider_id = pp.provider_id
WHERE b.booking_type = 'Pickup';


CREATE VIEW User_Upcoming_Flights AS
SELECT 
    b.booking_id, 
    u.user_id,
    u.name AS user_name, 
    f.flight_number, 
    a1.city AS departure_city, 
    a2.city AS destination_city, 
    f.departure_time, 
    f.arrival_time, 
    b.status, 
    b.booking_date
FROM Bookings b
JOIN Users u ON b.user_id = u.user_id
JOIN Flights f ON b.reference_id = f.flight_id
JOIN Airports a1 ON f.departure_airport_id = a1.airport_id
JOIN Airports a2 ON f.destination_airport_id = a2.airport_id
WHERE b.booking_type = 'Flight' AND f.departure_time > NOW();


CREATE VIEW User_Upcoming_Hotels AS
SELECT 
    b.booking_id, 
    u.user_id,
    u.name AS user_name, 
    hb.hotel_name, 
    hb.branch, 
    h.price_per_night, 
    b.status, 
    b.booking_date
FROM Bookings b
JOIN Users u ON b.user_id = u.user_id
JOIN Hotels h ON b.reference_id = h.hotel_id
JOIN HotelBranches hb ON h.branch_id = hb.branch_id
WHERE b.booking_type = 'Hotel' AND b.status = 'Booked';


CREATE VIEW User_Upcoming_Pickups AS
SELECT 
    b.booking_id, 
    u.user_id,
    u.name AS user_name, 
    pp.provider_name, 
    p.airport, 
    p.direction, 
    b.status, 
    b.booking_date
FROM Bookings b
JOIN Users u ON b.user_id = u.user_id
JOIN Pickups p ON b.reference_id = p.pickup_id
JOIN PickupProviders pp ON p.provider_id = pp.provider_id
WHERE b.booking_type = 'Pickup' AND b.status = 'Booked';


INSERT INTO Users (name, email, phone, upassword) VALUES
('Aarav Patel', 'aarav.patel@example.com', '+254712345678', 'password1'),
('Aanya Sharma', 'aanya.sharma@example.com', '+254798765432', 'password2'),
('Vihaan Gupta', 'vihaan.gupta@example.com', '+254723456789', 'password3'),
('Ananya Singh', 'ananya.singh@example.com', '+254734567890', 'password4'),
('Arjun Kumar', 'arjun.kumar@example.com', '+254745678901', 'password5'),
('Ishani Desai', 'ishani.desai@example.com', '+254756789012', 'password6'),
('Reyansh Joshi', 'reyansh.joshi@example.com', '+254767890123', 'password7'),
('Saanvi Reddy', 'saanvi.reddy@example.com', '+254778901234', 'password8'),
('Advik Choudhury', 'advik.choudhury@example.com', '+254789012345', 'password9'),
('Myra Mishra', 'myra.mishra@example.com', '+254790123456', 'password10');

INSERT INTO Bookings (user_id, booking_type, reference_id, status, booking_date) VALUES
-- Flights
(1, 'Flight', 1, 'Completed', '2024-01-15 08:00:00'),
(2, 'Flight', 2, 'Completed', '2024-02-20 10:00:00'),
(3, 'Flight', 3, 'Completed', '2024-03-25 12:00:00'),
(4, 'Flight', 4, 'Completed', '2024-04-10 14:00:00'),
(5, 'Flight', 5, 'Completed', '2024-05-05 16:00:00'),

-- Pickups
(6, 'Pickup', 1, 'Completed', '2024-01-16 09:00:00'),
(7, 'Pickup', 2, 'Completed', '2024-02-21 11:00:00'),
(8, 'Pickup', 3, 'Completed', '2024-03-26 13:00:00'),
(9, 'Pickup', 4, 'Completed', '2024-04-11 15:00:00'),
(10, 'Pickup', 5, 'Completed', '2024-05-06 17:00:00'),

-- Hotels
(1, 'Hotel', 1, 'Completed', '2024-01-17 10:00:00'),
(2, 'Hotel', 2, 'Completed', '2024-02-22 12:00:00'),
(3, 'Hotel', 3, 'Completed', '2024-03-27 14:00:00'),
(4, 'Hotel', 4, 'Completed', '2024-04-12 16:00:00'),
(5, 'Hotel', 5, 'Completed', '2024-05-07 18:00:00');

INSERT INTO Bookings (user_id, booking_type, reference_id, status, booking_date) VALUES
-- Aarav Patel
(1, 'Flight', 6, 'Booked', '2024-06-01 08:00:00'),
(1, 'Flight', 7, 'Booked', '2024-07-01 10:00:00'),
(1, 'Flight', 8, 'Booked', '2024-08-01 12:00:00'),
(1, 'Flight', 9, 'Booked', '2024-09-01 14:00:00'),
(1, 'Flight', 10, 'Booked', '2024-10-01 16:00:00'),
(1, 'Flight', 11, 'Booked', '2024-11-01 18:00:00'),

-- Aanya Sharma
(2, 'Flight', 6, 'Booked', '2024-06-02 08:00:00'),
(2, 'Flight', 7, 'Booked', '2024-07-02 10:00:00'),
(2, 'Flight', 8, 'Booked', '2024-08-02 12:00:00'),
(2, 'Flight', 9, 'Booked', '2024-09-02 14:00:00'),
(2, 'Flight', 10, 'Booked', '2024-10-02 16:00:00'),
(2, 'Flight', 11, 'Booked', '2024-11-02 18:00:00'),

-- Vihaan Gupta
(3, 'Flight', 6, 'Booked', '2024-06-03 08:00:00'),
(3, 'Flight', 7, 'Booked', '2024-07-03 10:00:00'),
(3, 'Flight', 8, 'Booked', '2024-08-03 12:00:00'),
(3, 'Flight', 9, 'Booked', '2024-09-03 14:00:00'),
(3, 'Flight', 10, 'Booked', '2024-10-03 16:00:00'),
(3, 'Flight', 11, 'Booked', '2024-11-03 18:00:00'),

-- Ananya Singh
(4, 'Flight', 6, 'Booked', '2024-06-04 08:00:00'),
(4, 'Flight', 7, 'Booked', '2024-07-04 10:00:00'),
(4, 'Flight', 8, 'Booked', '2024-08-04 12:00:00'),
(4, 'Flight', 9, 'Booked', '2024-09-04 14:00:00'),
(4, 'Flight', 10, 'Booked', '2024-10-04 16:00:00'),
(4, 'Flight', 11, 'Booked', '2024-11-04 18:00:00'),

-- Arjun Kumar
(5, 'Flight', 6, 'Booked', '2024-06-05 08:00:00'),
(5, 'Flight', 7, 'Booked', '2024-07-05 10:00:00'),
(5, 'Flight', 8, 'Booked', '2024-08-05 12:00:00'),
(5, 'Flight', 9, 'Booked', '2024-09-05 14:00:00'),
(5, 'Flight', 10, 'Booked', '2024-10-05 16:00:00'),
(5, 'Flight', 11, 'Booked', '2024-11-05 18:00:00'),

-- Ishani Desai
(6, 'Flight', 6, 'Booked', '2024-06-06 08:00:00'),
(6, 'Flight', 7, 'Booked', '2024-07-06 10:00:00'),
(6, 'Flight', 8, 'Booked', '2024-08-06 12:00:00'),
(6, 'Flight', 9, 'Booked', '2024-09-06 14:00:00'),
(6, 'Flight', 10, 'Booked', '2024-10-06 16:00:00'),
(6, 'Flight', 11, 'Booked', '2024-11-06 18:00:00'),

-- Reyansh Joshi
(7, 'Flight', 6, 'Booked', '2024-06-07 08:00:00'),
(7, 'Flight', 7, 'Booked', '2024-07-07 10:00:00'),
(7, 'Flight', 8, 'Booked', '2024-08-07 12:00:00'),
(7, 'Flight', 9, 'Booked', '2024-09-07 14:00:00'),
(7, 'Flight', 10, 'Booked', '2024-10-07 16:00:00'),
(7, 'Flight', 11, 'Booked', '2024-11-07 18:00:00'),

-- Saanvi Reddy
(8, 'Flight', 6, 'Booked', '2024-06-08 08:00:00'),
(8, 'Flight', 7, 'Booked', '2024-07-08 10:00:00'),
(8, 'Flight', 8, 'Booked', '2024-08-08 12:00:00'),
(8, 'Flight', 9, 'Booked', '2024-09-08 14:00:00'),
(8, 'Flight', 10, 'Booked', '2024-10-08 16:00:00'),
(8, 'Flight', 11, 'Booked', '2024-11-08 18:00:00'),

-- Advik Choudhury
(9, 'Flight', 6, 'Booked', '2024-06-09 08:00:00'),
(9, 'Flight', 7, 'Booked', '2024-07-09 10:00:00'),
(9, 'Flight', 8, 'Booked', '2024-08-09 12:00:00'),
(9, 'Flight', 9, 'Booked', '2024-09-09 14:00:00'),
(9, 'Flight', 10, 'Booked', '2024-10-09 16:00:00'),
(9, 'Flight', 11, 'Booked', '2024-11-09 18:00:00'),

-- Myra Mishra
(10, 'Flight', 6, 'Booked', '2024-06-10 08:00:00'),
(10, 'Flight', 7, 'Booked', '2024-07-10 10:00:00'),
(10, 'Flight', 8, 'Booked', '2024-08-10 12:00:00'),
(10, 'Flight', 9, 'Booked', '2024-09-10 14:00:00'),
(10, 'Flight', 10, 'Booked', '2024-10-10 16:00:00'),
(10, 'Flight', 11, 'Booked', '2024-11-10 18:00:00');

INSERT INTO Reviews (user_id, review_type, reference_id, rating, comment, review_date) VALUES
-- Reviews for Flights
(1, 'Flight', 1, 5, 'Great flight experience!', '2024-01-16 09:00:00'),
(2, 'Flight', 2, 4, 'Comfortable and on time.', '2024-02-21 11:00:00'),
(3, 'Flight', 3, 5, 'Excellent service!', '2024-03-26 13:00:00'),
(4, 'Flight', 4, 3, 'Average experience.', '2024-04-11 15:00:00'),
(5, 'Flight', 5, 5, 'Loved the flight!', '2024-05-06 17:00:00'),

-- Reviews for Pickups
(6, 'Pickup', 1, 4, 'Driver was on time.', '2024-01-17 10:00:00'),
(7, 'Pickup', 2, 5, 'Very professional service.', '2024-02-22 12:00:00'),
(8, 'Pickup', 3, 3, 'Could be better.', '2024-03-27 14:00:00'),
(9, 'Pickup', 4, 4, 'Good experience overall.', '2024-04-12 16:00:00'),
(10, 'Pickup', 5, 5, 'Highly recommended!', '2024-05-07 18:00:00'),

-- Reviews for Hotels
(1, 'Hotel', 1, 5, 'Amazing stay!', '2024-01-18 11:00:00'),
(2, 'Hotel', 2, 4, 'Comfortable rooms.', '2024-02-23 13:00:00'),
(3, 'Hotel', 3, 5, 'Great hospitality.', '2024-03-28 15:00:00'),
(4, 'Hotel', 4, 3, 'Average service.', '2024-04-13 17:00:00'),
(5, 'Hotel', 5, 5, 'Loved the view!', '2024-05-08 19:00:00'),


(6, 'Flight', 6, 5, 'Smooth flight experience.', '2024-06-01 08:00:00'),
(7, 'Flight', 7, 4, 'Good service.', '2024-07-01 10:00:00'),
(8, 'Flight', 8, 5, 'Excellent crew!', '2024-08-01 12:00:00'),
(9, 'Flight', 9, 3, 'Delayed flight.', '2024-09-01 14:00:00'),
(10, 'Flight', 10, 5, 'Great experience!', '2024-10-01 16:00:00');


create table destination(
    Destination_id int primary key,
    Destination_name varchar(100)
);
insert  into destination (Destination_id, Destination_name) VALUES 
('1','serenghetti'),
('2','vihiga')
('3','Dodoma'),
('4','Kigali'),
('5','Bujumbura'),
('6','Mogadiscio');

select * from destination;


drop table destination;


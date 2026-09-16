CREATE DATABASE stayinsights;

USE stayinsights;

-- CREATE GUESTS TABLE
CREATE TABLE guests (
    guest_id INT PRIMARY KEY,
    guest_name VARCHAR(100) NOT NULL,
    guest_type VARCHAR(20),
    email VARCHAR(100),
    phone VARCHAR(20),
    city VARCHAR(50),
    country VARCHAR(50)
);

-- CREATE HOTELS TABLE
CREATE TABLE hotels (
    hotel_id INT PRIMARY KEY,
    hotel_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50),
    star_rating DECIMAL(2,1)
);

-- CREATE ROOMS TABLE
CREATE TABLE rooms (
    room_id INT PRIMARY KEY,
    hotel_id INT NOT NULL,
    room_number VARCHAR(20) NOT NULL,
    room_type VARCHAR(50),
    capacity INT,
    price_per_night DECIMAL(10,2),
    room_status VARCHAR(30),
    FOREIGN KEY (hotel_id) REFERENCES hotels(hotel_id)
);

-- CREATE STAFF TABLE
CREATE TABLE staff (
    staff_id INT PRIMARY KEY,
    staff_name VARCHAR(100) NOT NULL,
    role VARCHAR(50),
    hotel_id INT,
    phone VARCHAR(20),
    employment_status VARCHAR(30),
    FOREIGN KEY (hotel_id) REFERENCES hotels(hotel_id)
);

-- CREATE BOOKINGS TABLE
CREATE TABLE bookings (
    booking_id VARCHAR(10) PRIMARY KEY,
    guest_id VARCHAR(10) NOT NULL,
    hotel_id VARCHAR(10) NOT NULL,
    booking_date DATE,
    room_type_requested VARCHAR(50),
    booking_channel VARCHAR(50),
    nights_booked INT,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (guest_id) REFERENCES guests(guest_id),
    FOREIGN KEY (hotel_id) REFERENCES hotels(hotel_id)
);

USE stayinsights;

DROP TABLE IF EXISTS stays;
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS staff;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS hotels;
DROP TABLE IF EXISTS guests;

USE stayinsights;

CREATE TABLE guests (
    guest_id VARCHAR(10) PRIMARY KEY,
    guest_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    guest_type VARCHAR(30),
    preferred_room_type VARCHAR(50),
    loyalty_tier VARCHAR(30),
    account_since DATE
);

CREATE TABLE hotels (
    hotel_id VARCHAR(10) PRIMARY KEY,
    hotel_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50),
    star_rating DECIMAL(2,1)
);
DROP TABLE IF EXISTS hotels;
USE stayinsights;

DROP TABLE IF EXISTS staff;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS hotels;

DROP TABLE IF EXISTS staff;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS hotels;

CREATE TABLE hotels (
    hotel_id VARCHAR(10) PRIMARY KEY,
    hotel_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    star_rating INT,
    total_rooms INT,
    opened_date DATE
);

CREATE TABLE rooms (
    room_id VARCHAR(10) PRIMARY KEY,
    hotel_id VARCHAR(10) NOT NULL,
    room_type VARCHAR(50),
    floor_number INT,
    max_occupancy INT,
    price_per_night DECIMAL(10,2),
    is_active BOOLEAN,
    FOREIGN KEY (hotel_id) REFERENCES hotels(hotel_id)
);

CREATE TABLE staff (
    staff_id VARCHAR(10) PRIMARY KEY,
    hotel_id VARCHAR(10) NOT NULL,
    staff_name VARCHAR(100) NOT NULL,
    role VARCHAR(50),
    employment_status VARCHAR(30),
    hire_date DATE,
    FOREIGN KEY (hotel_id) REFERENCES hotels(hotel_id)
);

CREATE TABLE bookings (
    booking_id VARCHAR(10) PRIMARY KEY,
    guest_id VARCHAR(10) NOT NULL,
    hotel_id VARCHAR(10) NOT NULL,
    booking_date DATE,
    room_type_requested VARCHAR(50),
    booking_channel VARCHAR(50),
    nights_booked INT,
    total_amount DECIMAL(10,2),

    FOREIGN KEY (guest_id) REFERENCES guests(guest_id),
    FOREIGN KEY (hotel_id) REFERENCES hotels(hotel_id)
);

CREATE TABLE stays (
    stay_id VARCHAR(10) PRIMARY KEY,
    booking_id VARCHAR(10) NOT NULL,
    room_id VARCHAR(10) NOT NULL,
    staff_id VARCHAR(10),
    check_in_date DATE,
    check_out_date DATE,
    stay_status VARCHAR(30),
    service_requests INT DEFAULT 0,
    guest_rating DECIMAL(3,1),
    notes VARCHAR(255),

    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (room_id) REFERENCES rooms(room_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

SELECT COUNT(*) AS total_guests
FROM guests;

SELECT * FROM guests;

SELECT * FROM guests;

USE stayinsights;

SELECT COUNT(*) AS total
FROM guests;

CREATE TABLE guests_import (
    guest_id VARCHAR(10),
    guest_name VARCHAR(100),
    city VARCHAR(50),
    guest_type VARCHAR(30),
    preferred_room_type VARCHAR(50),
    loyalty_tier VARCHAR(30),
    account_since VARCHAR(20)
);

DESCRIBE guests_import;

SELECT COUNT(*) AS imported_records
FROM guests_import;

SHOW VARIABLES LIKE 'secure_file_priv';

USE stayinsights;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/guests.csv'
INTO TABLE guests_import
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(guest_id, guest_name, city, guest_type, preferred_room_type, loyalty_tier, account_since);
SHOW VARIABLES LIKE 'secure_file_priv';

SELECT COUNT(*) AS total
FROM guests_import;

SHOW WARNINGS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/guests.csv'
INTO TABLE guests_import
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT COUNT(*) AS total_guests
FROM guests_import;

USE stayinsights;

INSERT INTO guests
(
    guest_id,
    guest_name,
    city,
    guest_type,
    preferred_room_type,
    loyalty_tier,
    account_since
)
SELECT
    guest_id,
    guest_name,
    city,
    guest_type,
    preferred_room_type,
    loyalty_tier,
    STR_TO_DATE(account_since, '%d-%m-%Y')
FROM guests_import;

SELECT COUNT(*) AS total_guests
FROM guests;

SELECT * 
FROM guests
LIMIT 10;

USE stayinsights;

SELECT COUNT(*) AS total_hotels
FROM hotels;

USE stayinsights;

CREATE TABLE hotels_import (
    hotel_id VARCHAR(10),
    hotel_name VARCHAR(100),
    city VARCHAR(50),
    star_rating INT,
    total_rooms INT,
    hotel_type VARCHAR(50)
);
DESCRIBE hotels_import;

USE stayinsights;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/hotels.csv'
INTO TABLE hotels_import
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(hotel_id, hotel_name, city, star_rating, total_rooms, hotel_type);

SELECT COUNT(*) AS total_hotels
FROM hotels_import;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/hotels.csv'
INTO TABLE hotels_import
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(hotel_id, hotel_name, city, star_rating, total_rooms, hotel_type);

SELECT COUNT(*) AS total_hotels
FROM hotels_import;

INSERT INTO hotels
(
    hotel_id,
    hotel_name,
    city,
    star_rating,
    total_rooms,
    hotel_type
)
SELECT
    hotel_id,
    hotel_name,
    city,
    star_rating,
    total_rooms,
    hotel_type
FROM hotels_import;

DESCRIBE hotels;

ALTER TABLE hotels_import
DROP COLUMN hotel_type;

ALTER TABLE hotels_import
ADD COLUMN opened_date VARCHAR(20);

DESCRIBE hotels_import;

TRUNCATE TABLE hotels_import;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/hotels.csv'
INTO TABLE hotels_import
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(hotel_id, hotel_name, city, star_rating, total_rooms, opened_date);

SELECT COUNT(*) AS total_hotels
FROM hotels_import;

USE stayinsights;

INSERT INTO hotels
(
    hotel_id,
    hotel_name,
    city,
    star_rating,
    total_rooms,
    opened_date
)
SELECT
    hotel_id,
    hotel_name,
    city,
    star_rating,
    total_rooms,
    STR_TO_DATE(opened_date, '%d-%m-%Y')
FROM hotels_import;

USE stayinsights;

INSERT INTO hotels
(
    hotel_id,
    hotel_name,
    city,
    star_rating,
    total_rooms,
    opened_date
)
SELECT
    hotel_id,
    hotel_name,
    city,
    star_rating,
    total_rooms,
    opened_date
FROM hotels_import;

SELECT COUNT(*) AS total_hotels
FROM hotels;

SELECT * FROM hotels
LIMIT 10;

USE stayinsights;

SELECT COUNT(*) AS total_rooms
FROM rooms;

DESCRIBE rooms;

USE stayinsights;

CREATE TABLE rooms_import (
    room_id VARCHAR(10),
    hotel_id VARCHAR(10),
    room_type VARCHAR(50),
    floor_number INT,
    max_occupancy INT,
    price_per_night DECIMAL(10,2),
    is_active TINYINT(1)
);


USE stayinsights;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/rooms.csv'
INTO TABLE rooms_import
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(room_id, hotel_id, room_type, floor_number, max_occupancy, price_per_night, is_active);


ALTER TABLE rooms_import
MODIFY COLUMN is_active VARCHAR(10);

TRUNCATE TABLE rooms_import;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/rooms.csv'
INTO TABLE rooms_import
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(room_id, hotel_id, room_type, floor_number, max_occupancy, price_per_night, is_active);


INSERT INTO rooms
(
    room_id,
    hotel_id,
    room_type,
    floor_number,
    max_occupancy,
    price_per_night,
    is_active
)
SELECT
    room_id,
    hotel_id,
    room_type,
    floor_number,
    max_occupancy,
    price_per_night,
    CASE
        WHEN LOWER(is_active) = 'yes' THEN 1
        WHEN LOWER(is_active) = 'no' THEN 0
        ELSE NULL
    END
FROM rooms_import;

SELECT COUNT(*) AS total_rooms
FROM rooms;

SELECT * FROM rooms
LIMIT 10;

SELECT COUNT(*) AS total_staff
FROM staff;

DESCRIBE staff;

USE stayinsights;

CREATE TABLE staff_import (
    staff_id VARCHAR(10),
    hotel_id VARCHAR(10),
    staff_name VARCHAR(100),
    role VARCHAR(50),
    employment_status VARCHAR(30),
    hire_date VARCHAR(20)
);

DESCRIBE staff_import;

USE stayinsights;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/staff.csv'
INTO TABLE staff_import
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(staff_id, hotel_id, staff_name, role, employment_status, hire_date);

USE stayinsights;

TRUNCATE TABLE staff_import;

DROP TABLE staff_import;

CREATE TABLE staff_import (
    staff_id VARCHAR(10),
    staff_name VARCHAR(100),
    hire_date VARCHAR(20),
    rating DECIMAL(4,2),
    department VARCHAR(50),
    is_active VARCHAR(10)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/staff.csv'
INTO TABLE staff_import
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(staff_id, staff_name, hire_date, rating, department, is_active);

SELECT COUNT(*) AS total_staff
FROM staff_import;

DESCRIBE stays;

SHOW CREATE TABLE staff;

SELECT COUNT(*) AS total_staff
FROM staff;

USE stayinsights;

ALTER TABLE staff
DROP FOREIGN KEY staff_ibfk_1;

ALTER TABLE staff
DROP COLUMN hotel_id,
DROP COLUMN role,
DROP COLUMN employment_status;

ALTER TABLE staff
ADD COLUMN rating DECIMAL(3,2),
ADD COLUMN department VARCHAR(30),
ADD COLUMN is_active VARCHAR(3);

DESCRIBE staff;

USE stayinsights;

 USE stayinsights;

ALTER TABLE staff
DROP FOREIGN KEY staff_ibfk_1;

ALTER TABLE staff
DROP COLUMN hotel_id,
DROP COLUMN role,
DROP COLUMN employment_status;

DESCRIBE staff;

USE stayinsights;

INSERT INTO staff
(
    staff_id,
    staff_name,
    hire_date,
    rating,
    department,
    is_active
)
SELECT
    staff_id,
    staff_name,
    hire_date,
    rating,
    department,
    is_active
FROM staff_import;

SELECT COUNT(*) AS total_staff
FROM staff;

SELECT * FROM staff
LIMIT 10;

USE stayinsights;

SELECT COUNT(*) AS total_bookings
FROM bookings;

USE stayinsights;

DESCRIBE bookings;

USE stayinsights;

CREATE TABLE bookings_import (
    booking_id VARCHAR(10),
    guest_id VARCHAR(10),
    hotel_id VARCHAR(10),
    booking_date VARCHAR(20),
    room_type_requested VARCHAR(50),
    booking_channel VARCHAR(50),
    nights_booked INT,
    total_amount DECIMAL(10,2)
);

DESCRIBE bookings_import;

USE stayinsights;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/bookings.csv'
INTO TABLE bookings_import
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    booking_id,
    guest_id,
    hotel_id,
    booking_date,
    room_type_requested,
    booking_channel,
    nights_booked,
    total_amount
);

SELECT COUNT(*) AS total_bookings
FROM bookings_import;

SELECT booking_date
FROM bookings_import
LIMIT 5;

USE stayinsights;

INSERT INTO bookings
(
    booking_id,
    guest_id,
    hotel_id,
    booking_date,
    room_type_requested,
    booking_channel,
    nights_booked,
    total_amount
)
SELECT
    booking_id,
    guest_id,
    hotel_id,
    STR_TO_DATE(booking_date, '%d-%m-%Y'),
    room_type_requested,
    booking_channel,
    nights_booked,
    total_amount
FROM bookings_import;

SELECT COUNT(*) AS total_bookings
FROM bookings;

SELECT * FROM bookings
LIMIT 10;

SELECT COUNT(*) AS total_bookings
FROM bookings;

USE stayinsights;

SELECT COUNT(*) AS total_stays
FROM stays;

USE stayinsights;

DESCRIBE stays;

USE stayinsights;

CREATE TABLE stays_import (
    stay_id VARCHAR(10),
    booking_id VARCHAR(10),
    room_id VARCHAR(10),
    staff_id VARCHAR(10),
    check_in_date VARCHAR(20),
    check_out_date VARCHAR(20),
    stay_status VARCHAR(30),
    service_requests INT,
    guest_rating DECIMAL(3,1),
    notes VARCHAR(255)
);

DESCRIBE stays_import;

USE stayinsights;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/stays.csv'
INTO TABLE stays_import
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    stay_id,
    booking_id,
    room_id,
    staff_id,
    check_in_date,
    check_out_date,
    stay_status,
    service_requests,
    guest_rating,
    notes
);

SELECT COUNT(*) AS total_stays
FROM stays_import;

SELECT check_in_date, check_out_date
FROM stays_import
LIMIT 5;

USE stayinsights;

INSERT INTO stays
(
    stay_id,
    booking_id,
    room_id,
    staff_id,
    check_in_date,
    check_out_date,
    stay_status,
    service_requests,
    guest_rating,
    notes
)
SELECT
    stay_id,
    booking_id,
    room_id,
    staff_id,
    check_in_date,
    check_out_date,
    stay_status,
    service_requests,
    guest_rating,
    notes
FROM stays_import;

SELECT COUNT(*) AS total_stays
FROM stays;

SELECT *
FROM stays
LIMIT 10;

SELECT COUNT(*) AS total_stays
FROM stays;

-- Understand Booking Demand
-- 1: Which hotels generate the highest number of bookings?
SELECT
    h.hotel_id,
    h.hotel_name,
    COUNT(b.booking_id) AS total_bookings
FROM hotels h
JOIN bookings b
    ON h.hotel_id = b.hotel_id
GROUP BY
    h.hotel_id,
    h.hotel_name
ORDER BY
    total_bookings DESC;
    
    -- 2 Which booking channels generate the most bookings?
    SELECT
    booking_channel,
    COUNT(booking_id) AS total_bookings
FROM bookings
GROUP BY booking_channel
ORDER BY total_bookings DESC;

-- 3 Which room types are requested most often?
SELECT
    room_type_requested,
    COUNT(booking_id) AS total_bookings
FROM bookings
GROUP BY room_type_requested
ORDER BY total_bookings DESC;

-- 4 How does booking volume change over time?
SELECT
    DATE_FORMAT(booking_date, '%Y-%m') AS booking_month,
    COUNT(booking_id) AS total_bookings
FROM bookings
GROUP BY DATE_FORMAT(booking_date, '%Y-%m')
ORDER BY booking_month;

-- 5 Which booking channels generate the highest booking amount?
SELECT
    booking_channel,
    SUM(total_amount) AS total_booking_amount,
    AVG(total_amount) AS avg_booking_amount
FROM bookings
GROUP BY booking_channel
ORDER BY total_booking_amount DESC;

-- Sprint 4.2 — Understand Guest Booking Behaviour
-- “Which guests have made the highest number of bookings?”
SELECT
    g.guest_id,
    g.guest_name,
    COUNT(b.booking_id) AS total_bookings
FROM guests g
JOIN bookings b
    ON g.guest_id = b.guest_id
GROUP BY
    g.guest_id,
    g.guest_name
ORDER BY
    total_bookings DESC;
    
    -- Which guests generate the highest total booking amount?
    SELECT
    g.guest_id,
    g.guest_name,
    COUNT(b.booking_id) AS total_bookings,
    SUM(b.total_amount) AS total_booking_amount
FROM guests g
JOIN bookings b
    ON g.guest_id = b.guest_id
GROUP BY
    g.guest_id,
    g.guest_name
ORDER BY
    total_booking_amount DESC
LIMIT 10;

-- Which hotels have the highest guest booking activity?
SELECT
    h.hotel_id,
    h.hotel_name,
    COUNT(b.booking_id) AS total_bookings,
    COUNT(DISTINCT b.guest_id) AS unique_guests
FROM hotels h
JOIN bookings b
    ON h.hotel_id = b.hotel_id
GROUP BY
    h.hotel_id,
    h.hotel_name
ORDER BY
    total_bookings DESC;
    
    -- How does booking behaviour differ between Individual and Corporate guests?
    SELECT
    g.guest_type,
    COUNT(DISTINCT g.guest_id) AS total_guests,
    COUNT(b.booking_id) AS total_bookings,
    SUM(b.total_amount) AS total_booking_amount,
    AVG(b.nights_booked) AS avg_nights_booked
FROM guests g
JOIN bookings b
    ON g.guest_id = b.guest_id
GROUP BY g.guest_type
ORDER BY total_bookings DESC;

-- How does guest booking activity change over time?
SELECT
    DATE_FORMAT(b.booking_date, '%Y-%m') AS booking_month,
    COUNT(b.booking_id) AS total_bookings,
    COUNT(DISTINCT b.guest_id) AS unique_guests,
    SUM(b.total_amount) AS total_booking_amount
FROM bookings b
GROUP BY DATE_FORMAT(b.booking_date, '%Y-%m')
ORDER BY booking_month;

-- Sprint 4.3 — Evaluate Stay Performance
-- 1 Which hotels have the highest number of stays?
SELECT
    h.hotel_id,
    h.hotel_name,
    COUNT(s.stay_id) AS total_stays
FROM hotels h
JOIN bookings b
    ON h.hotel_id = b.hotel_id
JOIN stays s
    ON b.booking_id = s.booking_id
GROUP BY
    h.hotel_id,
    h.hotel_name
ORDER BY
    total_stays DESC;
    
    -- 2 What is the average stay duration for each hotel?
    SELECT
    h.hotel_id,
    h.hotel_name,
    ROUND(AVG(DATEDIFF(s.check_out_date, s.check_in_date)), 2) AS avg_stay_duration
FROM hotels h
JOIN bookings b
    ON h.hotel_id = b.hotel_id
JOIN stays s
    ON b.booking_id = s.booking_id
WHERE s.check_in_date IS NOT NULL
  AND s.check_out_date IS NOT NULL
GROUP BY
    h.hotel_id,
    h.hotel_name
ORDER BY
    avg_stay_duration DESC;
    
    -- 3 How do stay outcomes compare?
    SELECT
    stay_status,
    COUNT(stay_id) AS total_stays
FROM stays
GROUP BY stay_status
ORDER BY total_stays DESC;

-- 4 Which hotels have the highest number of No-shows and Cancellations?
SELECT
    h.hotel_id,
    h.hotel_name,
    SUM(CASE WHEN s.stay_status = 'No-show' THEN 1 ELSE 0 END) AS no_shows,
    SUM(CASE WHEN s.stay_status = 'Cancelled' THEN 1 ELSE 0 END) AS cancellations,
    COUNT(s.stay_id) AS total_stays
FROM hotels h
JOIN bookings b
    ON h.hotel_id = b.hotel_id
JOIN stays s
    ON b.booking_id = s.booking_id
GROUP BY
    h.hotel_id,
    h.hotel_name
ORDER BY
    (no_shows + cancellations) DESC;
    
    -- 5 Which hotels receive the highest number of service requests during stays?
    SELECT
    h.hotel_id,
    h.hotel_name,
    SUM(s.service_requests) AS total_service_requests,
    AVG(s.service_requests) AS avg_service_requests_per_stay
FROM hotels h
JOIN bookings b
    ON h.hotel_id = b.hotel_id
JOIN stays s
    ON b.booking_id = s.booking_id
GROUP BY
    h.hotel_id,
    h.hotel_name
ORDER BY
    total_service_requests DESC;
    
    -- Sprint 4.4 — Staff & Room Performance
    -- 1Which staff members have handled the most stays?
    SELECT
    st.staff_id,
    st.staff_name,
    COUNT(s.stay_id) AS total_stays_handled,
    AVG(s.guest_rating) AS avg_guest_rating
FROM staff st
JOIN stays s
    ON st.staff_id = s.staff_id
GROUP BY
    st.staff_id,
    st.staff_name
ORDER BY
    total_stays_handled DESC;
    
    -- 2 Which rooms are used most frequently?
    SELECT
    r.room_id,
    r.room_type,
    COUNT(s.stay_id) AS total_stays,
    SUM(s.service_requests) AS total_service_requests
FROM rooms r
JOIN stays s
    ON r.room_id = s.room_id
GROUP BY
    r.room_id,
    r.room_type
ORDER BY
    total_stays DESC
LIMIT 10;

-- 3 Which room types have the highest average price and usage?
SELECT
    r.room_type,
    COUNT(r.room_id) AS total_rooms,
    ROUND(AVG(r.price_per_night), 2) AS avg_price_per_night,
    COUNT(s.stay_id) AS total_stays
FROM rooms r
LEFT JOIN stays s
    ON r.room_id = s.room_id
GROUP BY r.room_type
ORDER BY total_stays DESC;

-- 4
SELECT
    st.staff_id,
    st.staff_name,
    COUNT(s.stay_id) AS total_stays_handled,
    ROUND(AVG(s.guest_rating), 2) AS avg_guest_rating
FROM staff st
JOIN stays s
    ON st.staff_id = s.staff_id
WHERE s.guest_rating IS NOT NULL
GROUP BY
    st.staff_id,
    st.staff_name
ORDER BY
    avg_guest_rating DESC
LIMIT 10;

-- 5 Which rooms receive the highest guest ratings?
SELECT
    r.room_id,
    r.room_type,
    COUNT(s.stay_id) AS total_stays,
    ROUND(AVG(s.guest_rating), 2) AS avg_guest_rating
FROM rooms r
JOIN stays s
    ON r.room_id = s.room_id
WHERE s.guest_rating IS NOT NULL
GROUP BY
    r.room_id,
    r.room_type
ORDER BY
    avg_guest_rating DESC
LIMIT 10;

-- Sprint 4.5 — Identify Booking & Stay Problems
-- 1Which hotels have the highest cancellation and no-show rates?
SELECT
    h.hotel_id,
    h.hotel_name,
    COUNT(s.stay_id) AS total_stays,
    SUM(CASE WHEN s.stay_status = 'Cancelled' THEN 1 ELSE 0 END) AS cancellations,
    SUM(CASE WHEN s.stay_status = 'No-show' THEN 1 ELSE 0 END) AS no_shows,
    ROUND(
        100.0 * SUM(CASE WHEN s.stay_status IN ('Cancelled', 'No-show') THEN 1 ELSE 0 END)
        / COUNT(s.stay_id),
        2
    ) AS problem_rate_percent
FROM hotels h
JOIN bookings b
    ON h.hotel_id = b.hotel_id
JOIN stays s
    ON b.booking_id = s.booking_id
GROUP BY
    h.hotel_id,
    h.hotel_name
ORDER BY
    problem_rate_percent DESC;
    
    -- 2 Which hotels have the highest number of service requests?
    SELECT
    h.hotel_id,
    h.hotel_name,
    COUNT(s.stay_id) AS total_stays,
    SUM(s.service_requests) AS total_service_requests,
    ROUND(AVG(s.service_requests), 2) AS avg_requests_per_stay
FROM hotels h
JOIN bookings b
    ON h.hotel_id = b.hotel_id
JOIN stays s
    ON b.booking_id = s.booking_id
GROUP BY
    h.hotel_id,
    h.hotel_name
ORDER BY
    total_service_requests DESC;
    -- 3 Which booking channels have the highest cancellation and no-show rates?
    SELECT
    b.booking_channel,
    COUNT(s.stay_id) AS total_stays,
    SUM(CASE WHEN s.stay_status = 'Cancelled' THEN 1 ELSE 0 END) AS cancellations,
    SUM(CASE WHEN s.stay_status = 'No-show' THEN 1 ELSE 0 END) AS no_shows,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN s.stay_status IN ('Cancelled', 'No-show') THEN 1
                ELSE 0
            END
        ) / COUNT(s.stay_id),
        2
    ) AS problem_rate_percent
FROM bookings b
JOIN stays s
    ON b.booking_id = s.booking_id
GROUP BY b.booking_channel
ORDER BY problem_rate_percent DESC;

-- 4 Which room types have the highest cancellation and no-show rates?
SELECT
    b.room_type_requested,
    COUNT(s.stay_id) AS total_stays,
    SUM(CASE WHEN s.stay_status = 'Cancelled' THEN 1 ELSE 0 END) AS cancellations,
    SUM(CASE WHEN s.stay_status = 'No-show' THEN 1 ELSE 0 END) AS no_shows,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN s.stay_status IN ('Cancelled', 'No-show') THEN 1
                ELSE 0
            END
        ) / COUNT(s.stay_id),
        2
    ) AS problem_rate_percent
FROM bookings b
JOIN stays s
    ON b.booking_id = s.booking_id
GROUP BY b.room_type_requested
ORDER BY problem_rate_percent DESC;
-- 5 Which hotels have the highest number of service requests and problem stays?
SELECT
    h.hotel_id,
    h.hotel_name,
    SUM(
        CASE
            WHEN s.stay_status IN ('Cancelled', 'No-show') THEN 1
            ELSE 0
        END
    ) AS problem_stays,
    SUM(s.service_requests) AS total_service_requests
FROM hotels h
JOIN bookings b
    ON h.hotel_id = b.hotel_id
JOIN stays s
    ON b.booking_id = s.booking_id
GROUP BY
    h.hotel_id,
    h.hotel_name
ORDER BY
    problem_stays DESC,
    total_service_requests DESC;
    
    


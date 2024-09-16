CREATE DATABASE BOOK_MY_SHOW;
USE BOOK_MY_SHOW;

CREATE TABLE MOVIES(
    movie_id INT PRIMARY KEY,
    movie_name VARCHAR(100) NOT NULL,
    movie_releasedate DATE,
    movie_genre VARCHAR(100),
    movie_language VARCHAR(250),
    movie_duration INT,
    movie_cast VARCHAR(250)
);

CREATE TABLE theatre(
    theatre_id INT PRIMARY KEY,
    theatre_name VARCHAR(100),
    theatre_address VARCHAR(100),
    theatre_city VARCHAR(100),
    theatre_state VARCHAR(100),
    theatre_pincode INT,
    has_MTicket BOOLEAN DEFAULT TRUE,
    has_fnb BOOLEAN DEFAULT TRUE,
    has_parking BOOLEAN DEFAULT FALSE,
    has_foodcourt BOOLEAN DEFAULT FALSE
);

CREATE TABLE screens(
    screen_id INT PRIMARY KEY,
    theatre_id INT,
    screen_number INT,
    total_seats INT,
    FOREIGN KEY (theatre_id) REFERENCES theatre(theatre_id)
);

CREATE TABLE Shows (
    show_id INT PRIMARY KEY AUTO_INCREMENT,
    movie_id INT,
    screen_id INT,
    show_time DATETIME,
    price DECIMAL(10, 2),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
    FOREIGN KEY (screen_id) REFERENCES screens(screen_id)
);

CREATE TABLE seats(
    screen_id INT,
    seat_number INT,
    seat_row CHAR(10),
    seat_section VARCHAR(50),
    seat_price INT,
    seat_is_available BOOLEAN DEFAULT TRUE,
    FOREIGN KEY(screen_id) REFERENCES screens(screen_id)
);

DROP TABLE seats;
CREATE TABLE seats(
    seat_id INT PRIMARY KEY,
    screen_id INT,
    seat_number INT,
    seat_row CHAR(10),
    seat_section VARCHAR(50),
    seat_price INT,
    seat_is_available BOOLEAN DEFAULT TRUE,
    FOREIGN KEY(screen_id) REFERENCES screens(screen_id)
);


CREATE TABLE users (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(100),
    user_email VARCHAR(100) UNIQUE,
    phone_number INT(15)
);

DROP TABLE bookings;

CREATE TABLE bookings (
    booking_id INT PRIMARY KEY,
    user_id INT,
    show_id INT,
    seats_booked INT,
    booking_time DATETIME,
    booking_date DATE,
    total_amount DECIMAL(10, 2),
    theatre_id INT, 
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (show_id) REFERENCES Shows(show_id),
    FOREIGN KEY (theatre_id) REFERENCES theatre(theatre_id)  
);


CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    booking_id INT,
    payment_method VARCHAR(50),
    payment_status VARCHAR(50),
    payment_time DATETIME,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);


ALTER TABLE Payments 
ADD COLUMN returned_amount DECIMAL(10, 2) DEFAULT 0;

INSERT INTO Movies (movie_id, movie_name, movie_releasedate, movie_genre, movie_language, movie_duration)
VALUES 
(200, 'Stree 2', '2024-08-15', 'Horror, Comedy', 'Hindi', 167),
(367, 'Ardaas Sarbat Da Bhala', '2024-09-13', 'Drama', 'Punjabi', 150);
UPDATE Movies
SET movie_cast = 'Shraddha Kapoor, Rajkummar Rao, Pankaj Tripathi, Aparshakti Khurana, Abhishek Banerjee, Tamannaah Bhatia'
WHERE movie_id = 200;

UPDATE Movies
SET movie_cast = 'Gippy Grewal, Gurpreet Ghuggi, Jasmin Bhasin'
WHERE movie_id = 367;


INSERT INTO theatre (theatre_id, theatre_name, theatre_address, theatre_city, theatre_state, theatre_pincode, has_MTicket, has_fnb, has_parking, has_foodcourt)
VALUES 
(3098, 'DLF Avenue Saket', 'Saket', 'Delhi', 'Delhi', 110017, TRUE, TRUE, TRUE, TRUE),
(4087, 'Select City Walk', 'Saket', 'Delhi', 'Delhi', 110017, TRUE, TRUE, TRUE, TRUE);


INSERT INTO screens (screen_id, theatre_id, screen_number, total_seats)
VALUES 
(50, 3098, 1, 520),  
(51, 3098, 2, 480),  
(60, 4087, 1, 680),  
(61, 4087, 2, 600);  


INSERT INTO Shows (show_id, movie_id, screen_id, show_time, price)
VALUES 
(9, 200, 50, '2024-09-12 12:00:00', 400.00),  
(10, 367, 50, '2024-09-12 15:00:00', 350.00),
(11, 200, 51, '2024-09-12 18:00:00', 450.00), 
(12, 367, 51, '2024-09-12 21:00:00', 400.00);


INSERT INTO Shows (show_id, movie_id, screen_id, show_time, price)
VALUES 
(13, 200, 60, '2024-09-12 14:00:00', 450.00),  
(14, 367, 60, '2024-09-12 17:00:00', 400.00),  
(15, 200, 61, '2024-09-12 20:00:00', 500.00), 
(16, 367, 61, '2024-09-12 23:00:00', 450.00); 
 

INSERT INTO bookings (booking_id, user_id, show_id, seats_booked,  booking_time, booking_date, total_amount, theatre_id)
VALUES 
(4, 1, 11, 2, '2024-09-11 12:00:00', '2024-09-12', 900.00, 3098),  
(5, 1, 13, 3,  '2024-09-11 13:00:00', '2024-09-12', 1350.00, 4087), 
(6, 2, 10, 2,  '2024-09-11 14:00:00', '2024-09-12', 700.00, 3098), 
(7, 2, 16, 3,  '2024-09-11 15:00:00', '2024-09-12', 1200.00, 4087); 


INSERT INTO users (user_id)
VALUES
(1),(2);

UPDATE users
SET user_name = 'Yash'
WHERE user_id = 1;

UPDATE users
SET user_name = 'Khush deep'
WHERE user_id = 2;


INSERT INTO Payments (payment_id, booking_id, payment_method, payment_status, payment_time)
VALUES 
(10101, 4, 'Credit Card', 'Success', '2024-09-11 12:15:00'),
(10202, 5, 'Debit Card', 'Failed', '2024-09-11 13:30:00'),
(10303, 6, 'Net Banking', 'Success', '2024-09-11 14:10:00'),
(10404, 7, 'UPI', 'Failed', '2024-09-11 15:20:00');


SELECT 
    m.movie_name,
    m.movie_genre,
    m.movie_language,
    t.theatre_name,
    t.theatre_address,
    scr.screen_number,
    s.show_time,
    s.price
FROM 
    Movies m
JOIN 
    Shows s ON m.movie_id = s.movie_id
JOIN 
    screens scr ON s.screen_id = scr.screen_id
JOIN 
    theatre t ON scr.theatre_id = t.theatre_id
ORDER BY 
    m.movie_name, t.theatre_name, s.show_time;



SELECT 
    m.movie_name, 
    s.show_time,
    t.theatre_name
FROM 
    Shows s
JOIN 
    Movies m ON s.movie_id = m.movie_id
JOIN 
    screens scr ON s.screen_id = scr.screen_id
JOIN 
    theatre t ON scr.theatre_id = t.theatre_id
WHERE 
    t.theatre_name IN ('DLF Avenue Saket', 'Select City Walk')
ORDER BY 
    m.movie_name, t.theatre_name, s.show_time;


SELECT 
    m.movie_name, 
    s.show_time, 
    t.theatre_name, 
    COALESCE(SUM(b.seats_booked), 0) AS seats_booked,
    (scr.total_seats - COALESCE(SUM(b.seats_booked), 0)) AS seats_available
FROM 
    Shows s
JOIN 
    Movies m ON s.movie_id = m.movie_id
JOIN 
    screens scr ON s.screen_id = scr.screen_id
JOIN 
    theatre t ON scr.theatre_id = t.theatre_id
LEFT JOIN 
    bookings b ON s.show_id = b.show_id
WHERE 
    t.theatre_name IN ('DLF Avenue Saket', 'Select City Walk')
GROUP BY 
    m.movie_name, s.show_time, t.theatre_name, scr.total_seats
ORDER BY 
    m.movie_name, t.theatre_name, s.show_time;



SELECT 
    S.show_time, 
    T.theatre_name AS theater_name, 
    M.movie_name
FROM 
    Shows S
JOIN 
    Movies M ON S.movie_id = M.movie_id
JOIN 
    screens Sc ON S.screen_id = Sc.screen_id
JOIN 
    theatre T ON Sc.theatre_id = T.theatre_id
WHERE 
    M.movie_name IN ('Stree 2', 'Ardaas Sarbat Da Bhala')
    AND S.show_time > NOW();

ALTER TABLE bookings
ADD COLUMN seat_id VARCHAR(5),
ADD CONSTRAINT fk_seat_id FOREIGN KEY (seat_id) REFERENCES seat(seat_id);
ALTER TABLE bookings
DROP FOREIGN KEY fk_bookings_seat_id;
ALTER TABLE bookings
DROP COLUMN seat_id;
CREATE INDEX idx_seat_id ON seat(seat_id);

ALTER TABLE bookings
ADD FOREIGN KEY(seat_id) REFERENCES seat(seat_id);

SELECT seat_id 
FROM seat 
WHERE seat_is_normal = TRUE 
LIMIT 1;
SELECT seat_id 
FROM seat 
WHERE seat_is_recliner = TRUE 
LIMIT 1;

DESCRIBE bookings;

SELECT 
    b.booking_id,
    b.user_id,              
    u.user_name,           
    m.movie_name,
    t.theatre_name,
    sc.screen_number,
    s.show_time,
    b.seats_booked,
    b.total_amount,
    p.payment_id,
    p.payment_method,
    p.payment_status,
    CASE 
        WHEN p.payment_status = 'Failed' THEN b.total_amount
        ELSE 0
    END AS returned_amount,
    CASE 
        WHEN p.payment_status = 'Failed' THEN 'Refund Initiated'
        ELSE 'No Refund'
    END AS refund_status
FROM 
    bookings b
JOIN 
    users u ON b.user_id = u.user_id         
JOIN 
    shows s ON b.show_id = s.show_id
JOIN 
    movies m ON s.movie_id = m.movie_id
JOIN 
    screens sc ON s.screen_id = sc.screen_id
JOIN 
    theatre t ON sc.theatre_id = t.theatre_id
LEFT JOIN 
    payments p ON b.booking_id = p.booking_id
WHERE
    b.user_id = 1                      
ORDER BY 
    m.movie_name, s.show_time, b.booking_id;


DROP TABLE seats;
CREATE TABLE seat (
    seat_id VARCHAR(5) PRIMARY KEY,
    screen_id INT,
    seat_row CHAR(1),
    seat_number INT,
    seat_section VARCHAR(10),
    seat_price DECIMAL(10, 2),
    seat_is_normal BOOLEAN,
    seat_is_premium BOOLEAN,
    seat_is_recliner BOOLEAN,
    is_booked BOOLEAN
);
DROP TABLE IF EXISTS seat;
CREATE TABLE seat (
    seat_id VARCHAR(5) PRIMARY KEY,
    screen_id INT,
    seat_row CHAR(1),
    seat_number INT,
    seat_section VARCHAR(10),
    seat_price DECIMAL(10, 2),
    seat_is_normal BOOLEAN,
    seat_is_premium BOOLEAN,
    seat_is_recliner BOOLEAN,
    is_booked BOOLEAN
);
DROP TABLE IF EXISTS seat;
WITH SeatCounts AS (
    SELECT 
        s.screen_id,
        s.total_seats * 0.60 AS number_of_normal_seats,
        s.total_seats * 0.30 AS number_of_premium_seats,
        s.total_seats * 0.10 AS number_of_recliner_seats
    FROM 
        screens s
    WHERE 
        s.screen_id IN (50, 51, 60, 61)
),
SeatPrices AS (
    SELECT 
        s.screen_id,
        300 AS normal_seat_price,
        500 AS premium_seat_price,
        1300 AS recliner_seat_price
    FROM 
        screens s
    WHERE 
        s.screen_id IN (50, 51, 60, 61)
)

SELECT 
    sc.screen_id,
    sc.number_of_normal_seats,
    sc.number_of_premium_seats,
    sc.number_of_recliner_seats,
    sp.normal_seat_price,
    sp.premium_seat_price,
    sp.recliner_seat_price
FROM 
    SeatCounts sc
JOIN 
    SeatPrices sp
ON 
    sc.screen_id = sp.screen_id;
SET SQL_SAFE_UPDATES = 0;
  UPDATE seat
SET
    seat_is_normal = CASE
        WHEN seat_row BETWEEN 'A' AND 'F' THEN TRUE
        ELSE FALSE
    END,
    seat_is_premium = CASE
        WHEN seat_row BETWEEN 'G' AND 'J' THEN TRUE
        ELSE FALSE
    END,
    seat_is_recliner = CASE
        WHEN seat_row BETWEEN 'K' AND 'M' THEN TRUE
        ELSE FALSE
    END;

   
SELECT 
    seat_id,
    seat_row,
    seat_is_normal,
    seat_is_premium,
    seat_is_recliner
FROM seat
WHERE screen_id IN (50, 51, 60, 61);

  INSERT INTO seat (seat_id, screen_id, seat_row, seat_number, seat_section, seat_price, seat_is_normal, seat_is_premium, seat_is_recliner, is_booked) VALUES
('A1', 51, 'A', 1, 'Normal', 300, TRUE, FALSE, FALSE, FALSE),
('A2', 51, 'A', 2, 'Normal', 300, TRUE, FALSE, FALSE, FALSE),
('A3', 51, 'A', 3, 'Normal', 300, TRUE, FALSE, FALSE, FALSE),
('A4', 51, 'A', 4, 'Normal', 300, TRUE, FALSE, FALSE, FALSE),
('B1', 51, 'B', 1, 'Normal', 300, TRUE, FALSE, FALSE, FALSE),
('B2', 51, 'B', 2, 'Normal', 300, TRUE, FALSE, FALSE, FALSE),
('B3', 51, 'B', 3, 'Normal', 300, TRUE, FALSE, FALSE, FALSE),
('B4', 51, 'B', 4, 'Normal', 300, TRUE, FALSE, FALSE, FALSE),
('C1', 51, 'C', 1, 'Normal', 300, TRUE, FALSE, FALSE, FALSE),
('C2', 51, 'C', 2, 'Normal', 300, TRUE, FALSE, FALSE, FALSE),
('C3', 51, 'C', 3, 'Normal', 300, TRUE, FALSE, FALSE, FALSE),
('C4', 51, 'C', 4, 'Normal', 300, TRUE, FALSE, FALSE, FALSE),

('A1', 50, 'A', 1, 'Normal', 300, TRUE, FALSE, FALSE, FALSE),
('A2', 50, 'A', 2, 'Normal', 300, TRUE, FALSE, FALSE, FALSE),
('A3', 50, 'A', 3, 'Normal', 300, TRUE, FALSE, FALSE, FALSE),
('A4', 50, 'A', 4, 'Normal', 300, TRUE, FALSE, FALSE, FALSE),
('B1', 50, 'B', 1, 'Normal', 300, TRUE, FALSE, FALSE, FALSE),
('B2', 50, 'B', 2, 'Normal', 300, TRUE, FALSE, FALSE, FALSE),
('B3', 50, 'B', 3, 'Normal', 300, TRUE, FALSE, FALSE, FALSE),
('B4', 50, 'B', 4, 'Normal', 300, TRUE, FALSE, FALSE, FALSE),
('C1', 50, 'C', 1, 'Normal', 300, TRUE, FALSE, FALSE, FALSE),
('C2', 50, 'C', 2, 'Normal', 300, TRUE, FALSE, FALSE, FALSE),
('C3', 50, 'C', 3, 'Normal', 300, TRUE, FALSE, FALSE, FALSE),
('C4', 50, 'C', 4, 'Normal', 300, TRUE, FALSE, FALSE, FALSE);
INSERT INTO seat (seat_id, screen_id, seat_row, seat_number, seat_section, seat_price, seat_is_normal, seat_is_premium, seat_is_recliner, is_booked) VALUES
('A1', 61, 'A', 1, 'Normal', 300, TRUE, FALSE, FALSE, FALSE),
('A2', 61, 'A', 2, 'Normal', 300, TRUE, FALSE, FALSE, FALSE),
('A3', 61, 'A', 3, 'Normal', 300, TRUE, FALSE, FALSE, FALSE),
('A4', 61, 'A', 4, 'Normal', 300, TRUE, FALSE, FALSE, FALSE),
('B1', 61, 'B', 1, 'Normal', 300, TRUE, FALSE, FALSE, FALSE),
('B2', 61, 'B', 2, 'Normal', 300, TRUE, FALSE, FALSE, FALSE),
('B3', 61, 'B', 3, 'Normal', 300, TRUE, FALSE, FALSE, FALSE),
('B4', 61, 'B', 4, 'Normal', 300, TRUE, FALSE, FALSE, FALSE),
('C1', 61, 'C', 1, 'Normal', 300, TRUE, FALSE, FALSE, FALSE),
('C2', 61, 'C', 2, 'Normal', 300, TRUE, FALSE, FALSE, FALSE),
('C3', 61, 'C', 3, 'Normal', 300, TRUE, FALSE, FALSE, FALSE),
('C4', 61, 'C', 4, 'Normal', 300, TRUE, FALSE, FALSE, FALSE);

INSERT INTO seat (seat_id, screen_id, seat_row, seat_number, seat_section, seat_price, seat_is_normal, seat_is_premium, seat_is_recliner, is_booked) VALUES
('A1', 60, 'A', 1, 'Normal', 300, TRUE, FALSE, FALSE, FALSE),
('A2', 60, 'A', 2, 'Normal', 300, TRUE, FALSE, FALSE, FALSE),
('A3', 60, 'A', 3, 'Normal', 300, TRUE, FALSE, FALSE, FALSE),
('A4', 60, 'A', 4, 'Normal', 300, TRUE, FALSE, FALSE, FALSE),
('B1', 60, 'B', 1, 'Normal', 300, TRUE, FALSE, FALSE, FALSE),
('B2', 60, 'B', 2, 'Normal', 300, TRUE, FALSE, FALSE, FALSE),
('B3', 60, 'B', 3, 'Normal', 300, TRUE, FALSE, FALSE, FALSE),
('B4', 60, 'B', 4, 'Normal', 300, TRUE, FALSE, FALSE, FALSE),
('C1', 60, 'C', 1, 'Normal', 300, TRUE, FALSE, FALSE, FALSE),
('C2', 60, 'C', 2, 'Normal', 300, TRUE, FALSE, FALSE, FALSE),
('C3', 60, 'C', 3, 'Normal', 300, TRUE, FALSE, FALSE, FALSE),
('C4', 60, 'C', 4, 'Normal', 300, TRUE, FALSE, FALSE, FALSE);

INSERT INTO seat (seat_id, screen_id, seat_row, seat_number, seat_section, seat_price, seat_is_normal, seat_is_premium, seat_is_recliner, is_booked) VALUES
('G1', 50, 'G', 1, 'Premium', 500, FALSE, TRUE, FALSE, FALSE),
('G2', 50, 'G', 2, 'Premium', 500, FALSE, TRUE, FALSE, FALSE),
('G3', 50, 'G', 3, 'Premium', 500, FALSE, TRUE, FALSE, FALSE),
('G4', 50, 'G', 4, 'Premium', 500, FALSE, TRUE, FALSE, FALSE),
('H1', 50, 'H', 1, 'Premium', 500, FALSE, TRUE, FALSE, FALSE),
('H2', 50, 'H', 2, 'Premium', 500, FALSE, TRUE, FALSE, FALSE),
('H3', 50, 'H', 3, 'Premium', 500, FALSE, TRUE, FALSE, FALSE),
('H4', 50, 'H', 4, 'Premium', 500, FALSE, TRUE, FALSE, FALSE),
('I1', 50, 'I', 1, 'Premium', 500, FALSE, TRUE, FALSE, FALSE),
('I2', 50, 'I', 2, 'Premium', 500, FALSE, TRUE, FALSE, FALSE),
('I3', 50, 'I', 3, 'Premium', 500, FALSE, TRUE, FALSE, FALSE),
('I4', 50, 'I', 4, 'Premium', 500, FALSE, TRUE, FALSE, FALSE);
INSERT INTO seat (seat_id, screen_id, seat_row, seat_number, seat_section, seat_price, seat_is_normal, seat_is_premium, seat_is_recliner, is_booked) VALUES
('G1', 51, 'G', 1, 'Premium', 500, FALSE, TRUE, FALSE, FALSE),
('G2', 51, 'G', 2, 'Premium', 500, FALSE, TRUE, FALSE, FALSE),
('G3', 51, 'G', 3, 'Premium', 500, FALSE, TRUE, FALSE, FALSE),
('G4', 51, 'G', 4, 'Premium', 500, FALSE, TRUE, FALSE, FALSE),
('H1', 51, 'H', 1, 'Premium', 500, FALSE, TRUE, FALSE, FALSE),
('H2', 51, 'H', 2, 'Premium', 500, FALSE, TRUE, FALSE, FALSE),
('H3', 51, 'H', 3, 'Premium', 500, FALSE, TRUE, FALSE, FALSE),
('H4', 51, 'H', 4, 'Premium', 500, FALSE, TRUE, FALSE, FALSE),
('I1', 51, 'I', 1, 'Premium', 500, FALSE, TRUE, FALSE, FALSE),
('I2', 51, 'I', 2, 'Premium', 500, FALSE, TRUE, FALSE, FALSE),
('I3', 51, 'I', 3, 'Premium', 500, FALSE, TRUE, FALSE, FALSE),
('I4', 51, 'I', 4, 'Premium', 500, FALSE, TRUE, FALSE, FALSE);

INSERT INTO seat (seat_id, screen_id, seat_row, seat_number, seat_section, seat_price, seat_is_normal, seat_is_premium, seat_is_recliner, is_booked) VALUES
('G1', 60, 'G', 1, 'Premium', 500, FALSE, TRUE, FALSE, FALSE),
('G2', 60, 'G', 2, 'Premium', 500, FALSE, TRUE, FALSE, FALSE),
('G3', 60, 'G', 3, 'Premium', 500, FALSE, TRUE, FALSE, FALSE),
('G4', 60, 'G', 4, 'Premium', 500, FALSE, TRUE, FALSE, FALSE),
('H1', 60, 'H', 1, 'Premium', 500, FALSE, TRUE, FALSE, FALSE),
('H2', 60, 'H', 2, 'Premium', 500, FALSE, TRUE, FALSE, FALSE),
('H3', 60, 'H', 3, 'Premium', 500, FALSE, TRUE, FALSE, FALSE),
('H4', 60, 'H', 4, 'Premium', 500, FALSE, TRUE, FALSE, FALSE),
('I1', 60, 'I', 1, 'Premium', 500, FALSE, TRUE, FALSE, FALSE),
('I2', 60, 'I', 2, 'Premium', 500, FALSE, TRUE, FALSE, FALSE),
('I3', 60, 'I', 3, 'Premium', 500, FALSE, TRUE, FALSE, FALSE),
('I4', 60, 'I', 4, 'Premium', 500, FALSE, TRUE, FALSE, FALSE);

INSERT INTO seat (seat_id, screen_id, seat_row, seat_number, seat_section, seat_price, seat_is_normal, seat_is_premium, seat_is_recliner, is_booked) VALUES
('G1', 61, 'G', 1, 'Premium', 500, FALSE, TRUE, FALSE, FALSE),
('G2', 61, 'G', 2, 'Premium', 500, FALSE, TRUE, FALSE, FALSE),
('G3', 61, 'G', 3, 'Premium', 500, FALSE, TRUE, FALSE, FALSE),
('G4', 61, 'G', 4, 'Premium', 500, FALSE, TRUE, FALSE, FALSE),
('H1', 61, 'H', 1, 'Premium', 500, FALSE, TRUE, FALSE, FALSE),
('H2', 61, 'H', 2, 'Premium', 500, FALSE, TRUE, FALSE, FALSE),
('H3', 61, 'H', 3, 'Premium', 500, FALSE, TRUE, FALSE, FALSE),
('H4', 61, 'H', 4, 'Premium', 500, FALSE, TRUE, FALSE, FALSE),
('I1', 61, 'I', 1, 'Premium', 500, FALSE, TRUE, FALSE, FALSE),
('I2', 61, 'I', 2, 'Premium', 500, FALSE, TRUE, FALSE, FALSE),
('I3', 61, 'I', 3, 'Premium', 500, FALSE, TRUE, FALSE, FALSE),
('I4', 61, 'I', 4, 'Premium', 500, FALSE, TRUE, FALSE, FALSE);


INSERT INTO seat (seat_id, screen_id, seat_row, seat_number, seat_section, seat_price, seat_is_normal, seat_is_premium, seat_is_recliner, is_booked) VALUES
('K1', 50, 'K', 1, 'Recliner', 1300, FALSE, FALSE, TRUE, FALSE),
('K2', 50, 'K', 2, 'Recliner', 1300, FALSE, FALSE, TRUE, FALSE),
('K3', 50, 'K', 3, 'Recliner', 1300, FALSE, FALSE, TRUE, FALSE),
('K4', 50, 'K', 4, 'Recliner', 1300, FALSE, FALSE, TRUE, FALSE),
('M1', 50, 'M', 1, 'Recliner', 1300, FALSE, FALSE, TRUE, FALSE),
('M2', 50, 'M', 2, 'Recliner', 1300, FALSE, FALSE, TRUE, FALSE),
('M3', 50, 'M', 3, 'Recliner', 1300, FALSE, FALSE, TRUE, FALSE),
('M4', 50, 'M', 4, 'Recliner', 1300, FALSE, FALSE, TRUE, FALSE);

INSERT INTO seat (seat_id, screen_id, seat_row, seat_number, seat_section, seat_price, seat_is_normal, seat_is_premium, seat_is_recliner, is_booked) VALUES
('K1', 51, 'K', 1, 'Recliner', 1300, FALSE, FALSE, TRUE, FALSE),
('K2', 51, 'K', 2, 'Recliner', 1300, FALSE, FALSE, TRUE, FALSE),
('K3', 51, 'K', 3, 'Recliner', 1300, FALSE, FALSE, TRUE, FALSE),
('K4', 51, 'K', 4, 'Recliner', 1300, FALSE, FALSE, TRUE, FALSE),
('M1', 51, 'M', 1, 'Recliner', 1300, FALSE, FALSE, TRUE, FALSE),
('M2', 51, 'M', 2, 'Recliner', 1300, FALSE, FALSE, TRUE, FALSE),
('M3', 51, 'M', 3, 'Recliner', 1300, FALSE, FALSE, TRUE, FALSE),
('M4', 51, 'M', 4, 'Recliner', 1300, FALSE, FALSE, TRUE, FALSE);

INSERT INTO seat (seat_id, screen_id, seat_row, seat_number, seat_section, seat_price, seat_is_normal, seat_is_premium, seat_is_recliner, is_booked) VALUES
('K1', 60, 'K', 1, 'Recliner', 1300, FALSE, FALSE, TRUE, FALSE),
('K2', 60, 'K', 2, 'Recliner', 1300, FALSE, FALSE, TRUE, FALSE),
('K3', 60, 'K', 3, 'Recliner', 1300, FALSE, FALSE, TRUE, FALSE),
('K4', 60, 'K', 4, 'Recliner', 1300, FALSE, FALSE, TRUE, FALSE),
('M1', 60, 'M', 1, 'Recliner', 1300, FALSE, FALSE, TRUE, FALSE),
('M2', 60, 'M', 2, 'Recliner', 1300, FALSE, FALSE, TRUE, FALSE),
('M3', 60, 'M', 3, 'Recliner', 1300, FALSE, FALSE, TRUE, FALSE),
('M4', 60, 'M', 4, 'Recliner', 1300, FALSE, FALSE, TRUE, FALSE);

INSERT INTO seat (seat_id, screen_id, seat_row, seat_number, seat_section, seat_price, seat_is_normal, seat_is_premium, seat_is_recliner, is_booked) VALUES
('K1', 61, 'K', 1, 'Recliner', 1300, FALSE, FALSE, TRUE, FALSE),
('K2', 61, 'K', 2, 'Recliner', 1300, FALSE, FALSE, TRUE, FALSE),
('K3', 61, 'K', 3, 'Recliner', 1300, FALSE, FALSE, TRUE, FALSE),
('K4', 61, 'K', 4, 'Recliner', 1300, FALSE, FALSE, TRUE, FALSE),
('M1', 61, 'M', 1, 'Recliner', 1300, FALSE, FALSE, TRUE, FALSE),
('M2', 61, 'M', 2, 'Recliner', 1300, FALSE, FALSE, TRUE, FALSE),
('M3', 61, 'M', 3, 'Recliner', 1300, FALSE, FALSE, TRUE, FALSE),
('M4', 61, 'M', 4, 'Recliner', 1300, FALSE, FALSE, TRUE, FALSE);
DROP TABLE IF EXISTS seat;

CREATE TABLE seat (
    seat_id VARCHAR(5),
    screen_id INT,
    seat_row CHAR(1),
    seat_number INT,
    seat_section VARCHAR(10),
    seat_price DECIMAL(10, 2),
    seat_is_normal BOOLEAN,
    seat_is_premium BOOLEAN,
    seat_is_recliner BOOLEAN,
    is_booked BOOLEAN,
    PRIMARY KEY (screen_id, seat_id),
    FOREIGN KEY (screen_id) REFERENCES screens(screen_id)
);

SELECT
    S.seat_id AS seat_id,
    S.seat_section AS seat_section,
    CASE
        WHEN B.booking_id IS NULL THEN 'Vacant'
        ELSE 'Booked'
    END AS seat_status
FROM
    seat S
LEFT JOIN
    bookings B ON S.seat_id = B.seat_id AND S.screen_id = S.screen_id
WHERE
    S.screen_id = 50;


SELECT * FROM bookings;

CREATE TABLE booking_seats (
    booking_id INT,
    seat_id VARCHAR(10),
    seat_section VARCHAR(20),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (seat_id) REFERENCES seat(seat_id)
);
INSERT INTO booking_seats (booking_id, seat_id, seat_section) 
VALUES 
    (4, 'A1', 'Regular'),
    (4, 'K1', 'Recliner');
    INSERT INTO booking_seats (booking_id, seat_id, seat_section) 
VALUES 
    (5, 'I1', 'Premium'),
    (5, 'K1', 'Recliner'),
    (5, 'b1', 'Regular');
    INSERT INTO booking_seats (booking_id, seat_id, seat_section) 
VALUES 
    (6, 'M1', 'Recliner'),
    (6, 'C1', 'Regular');
INSERT INTO booking_seats (booking_id, seat_id, seat_section) 
VALUES 
    (7, 'I2', 'Premium'),
    (7, 'K2', 'Recliner'),
    (7, 'C1', 'Regular');

SELECT seat_id, seat_section 
FROM booking_seats 
WHERE booking_id = 7;

ALTER TABLE bookings
ADD COLUMN movie_id INT;
ALTER TABLE bookings
ADD CONSTRAINT fk_movie_id
FOREIGN KEY (movie_id) REFERENCES movies(movie_id);

UPDATE bookings
SET movie_id = 200 
WHERE booking_id IN (4, 5);

UPDATE bookings
SET movie_id = 367 
WHERE booking_id IN (6, 7);


SELECT 
    B.booking_id, 
    M.movie_name AS title, 
    show_table.show_time, 
    COUNT(BS.seat_id) AS total_seats_booked, 
    SUM(B.total_amount) AS total_price,
    T.theatre_name AS theater_name,
    GROUP_CONCAT(DISTINCT BS.seat_id ORDER BY BS.seat_id) AS seat_ids, -- List of seat IDs
    SC.screen_id,
    GROUP_CONCAT(DISTINCT BS.seat_section ORDER BY BS.seat_section) AS seat_sections -- List of seat sections
FROM 
    bookings B
JOIN 
    Shows show_table ON B.show_id = show_table.show_id
JOIN 
    Movies M ON show_table.movie_id = M.movie_id
JOIN 
    screens SC ON show_table.screen_id = SC.screen_id
JOIN
    theatre T ON SC.theatre_id = T.theatre_id
JOIN
    booking_seats BS ON B.booking_id = BS.booking_id
WHERE 
    B.user_id = 1
GROUP BY 
    B.booking_id, M.movie_name, show_table.show_time, T.theatre_name, SC.screen_id;

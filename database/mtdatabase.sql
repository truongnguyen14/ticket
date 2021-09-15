SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS cineplex;
DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS seats;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS screentime;
DROP TABLE IF EXISTS cinemas;
DROP TABLE IF EXISTS reservations;
DROP TABLE IF EXISTS foodbeverage;
DROP TABLE IF EXISTS fborder;
DROP TABLE IF EXISTS admininfo;

CREATE TABLE admininfo(
    adminID INT UNSIGNED,
    adminName VARCHAR(90) NOT NULL,
    aUsername VARCHAR(90) NOT NULL,
    aPassword VARCHAR(90) NOT NULL,
    CONSTRAINT pk_admininfo PRIMARY KEY (adminID)
);

CREATE TABLE cineplex(
    cineplexID INT UNSIGNED,
    address VARCHAR(90) NOT NULL,
    cinemaCount INT UNSIGNED,
    CONSTRAINT pk_cinemas PRIMARY KEY (cineplexID)
);
CREATE TABLE cinemas(
    cineplexID INT UNSIGNED,
    cinemaID INT UNSIGNED,
    maxseat INT UNSIGNED,
    CONSTRAINT pk_cinemas PRIMARY KEY (cinemaID,cineplexID),
    CONSTRAINT fk_cinemas_cineplex FOREIGN KEY (cineplexID) REFERENCES cineplex(cineplexID)
        ON DELETE CASCADE
);
CREATE TABLE seats(
    cineplexID INT UNSIGNED,
    cinemaID INT UNSIGNED,
    seatNumb INT UNSIGNED,
    CONSTRAINT pk_seats PRIMARY KEY (cineplexID,cinemaID,seatNumb),
    CONSTRAINT fk_seats_cinemas FOREIGN KEY (cinemaID,cineplexID) REFERENCES cinemas(cineplexID,cinemaID)
        ON DELETE CASCADE
);

CREATE TABLE movies(
    mID INT(30) UNSIGNED,
    name VARCHAR(90) NOT NULL,
    moviedescription VARCHAR(255) NOT NULL,
    genre VARCHAR(90) NOT NULL,
	cover_image VARCHAR(255) NOT NULL,
    rated VARCHAR(30) NOT NULL,
    rating NUMERIC(3,1) UNSIGNED NOT NULL,
    CONSTRAINT pk_movies PRIMARY KEY (mID)
);


INSERT INTO movies(mID, name, moviedescription, genre, cover_image, rated, rating) VALUES
(1, 'Spider-man', 'web', 'action', 'spiderman.jpg', 'good', '3'),
(2, 'Thor', 'web', 'action', 'thor.jpg', 'good', '3'),
(3, 'Spider-man', 'web', 'action', 'spiderman.jpg', 'good', '3');


CREATE TABLE screentime(
    screentimeID INT UNSIGNED,
    cineplexID INT UNSIGNED,
    cinemaID INT UNSIGNED,
    mID INT UNSIGNED,
    date DATE NOT NULL,
    starttime TIME NOT NULL,
    endtime TIME NOT NULL,
    CONSTRAINT pk_screentime PRIMARY KEY (screentimeID),
    CONSTRAINT fk_screentime_movies FOREIGN KEY (mID) REFERENCES movies(mID)
        ON DELETE CASCADE,
    CONSTRAINT fk_screentime_cinema FOREIGN KEY (cineplexID,cinemaID) REFERENCES cinemas(cineplexID,cinemaID)
        ON DELETE CASCADE
);

CREATE TABLE customers(
    cID INT NOT NULL AUTO_INCREMENT,
    cUsername VARCHAR(90) NOT NULL,
    cPassword VARCHAR(90) NOT NULL,
    fname VARCHAR(30) NOT NULL,
    lname VARCHAR(30) NOT NULL,
    dob DATE NOT NULL,
    gender VARCHAR(30) NOT NULL,
    phone INTEGER UNSIGNED NOT NULL,
    CONSTRAINT pk_customers PRIMARY KEY (cID)
);

CREATE TABLE foodbeverage(
    cineplexID INT UNSIGNED,
	image VARCHAR(255) NOT NULL,
    itemID    INT UNSIGNED,
    itemName  VARCHAR(30),
    itemPrice INTEGER UNSIGNED,
    CONSTRAINT pk_foodbeverage PRIMARY KEY (itemID,cineplexID),
    CONSTRAINT fk_foodbeverage FOREIGN KEY (cineplexID) REFERENCES cineplex(cineplexID)
        ON DELETE CASCADE
);

CREATE TABLE fborder(
    cID INT UNSIGNED,
    itemID INT UNSIGNED,
    date DATE NOT NULL,
    CONSTRAINT pk_fbsell PRIMARY KEY (itemID, cID),
    CONSTRAINT fk_fbsell_customer FOREIGN KEY (cID) REFERENCES customers(cID)
        ON DELETE CASCADE,
    CONSTRAINT fk_fbsell_foodbeverage FOREIGN KEY (itemID) REFERENCES foodbeverage(itemID)
        ON DELETE CASCADE
);

CREATE TABLE reservations(
    reserveID INT UNSIGNED,
    cID INT UNSIGNED,
    cineplexID INT UNSIGNED,
    cinemaID INT UNSIGNED,
    screentimeID INT UNSIGNED,
    seatNumb INT UNSIGNED,
    CONSTRAINT pk_reservations PRIMARY KEY (reserveID),
    CONSTRAINT fk_reservations_customers FOREIGN KEY (cID) REFERENCES customers(cID)
        ON DELETE CASCADE,
    CONSTRAINT fk_reservations_seats FOREIGN KEY (cineplexID,cinemaID,seatNumb) REFERENCES seats(cineplexID, cinemaID, seatNumb)
        ON DELETE CASCADE,
    CONSTRAINT fk_reservations_screentime FOREIGN KEY (screentimeID) REFERENCES screentime(screentimeID)
        ON DELETE CASCADE
);


INSERT INTO cineplex VALUES (01,'72 nguyen trai',6),
(02,'LY THUONG KIET',8);

COMMIT;
SET FOREIGN_KEY_CHECKS = 1;
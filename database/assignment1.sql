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

CREATE TABLE admininfo
(
    adminID   INT UNSIGNED AUTO_INCREMENT,
    adminName VARCHAR(90) NOT NULL,
    aUsername VARCHAR(90) NOT NULL,
    aPassword VARCHAR(90) NOT NULL,
    CONSTRAINT pk_admininfo PRIMARY KEY (adminID)
);

CREATE TABLE cineplex(
    cineplexID INT UNSIGNED AUTO_INCREMENT,
    cineplexname VARCHAR(255),
    address VARCHAR(255) NOT NULL,
    cineplexhotline INT UNSIGNED,
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
    mID INT UNSIGNED AUTO_INCREMENT,
    name VARCHAR(90) NOT NULL,
    image VARCHAR(255) NOT NULL,
    moviedescription VARCHAR(3000) NOT NULL,
    genre VARCHAR(90) NOT NULL,
    rated VARCHAR(30) NOT NULL,
    rating NUMERIC(3,1) UNSIGNED NOT NULL,
    ticketprice INT UNSIGNED,
    CONSTRAINT pk_movies PRIMARY KEY (mID)
);

CREATE TABLE screentime(
    screentimeID INT UNSIGNED AUTO_INCREMENT,
    cineplexID INT UNSIGNED,
    cinemaID INT UNSIGNED,
    mID INT UNSIGNED,
    day VARCHAR(90),
    date DATE NOT NULL,
    starttime TIME NOT NULL,
    CONSTRAINT pk_screentime PRIMARY KEY (screentimeID),
    CONSTRAINT fk_screentime_movies FOREIGN KEY (mID) REFERENCES movies(mID)
        ON DELETE CASCADE,
    CONSTRAINT fk_screentime_cinema FOREIGN KEY (cineplexID,cinemaID) REFERENCES cinemas(cineplexID,cinemaID)
        ON DELETE CASCADE
);

CREATE TABLE customers(
    cID INT UNSIGNED AUTO_INCREMENT,
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
    itemID    INT UNSIGNED AUTO_INCREMENT,
    itemName  VARCHAR(30),
    itemImage VARCHAR(255),
    itemPrice INT UNSIGNED,
    CONSTRAINT pk_foodbeverage PRIMARY KEY (itemID)
);

CREATE TABLE fbsell(
    cineplexID INT UNSIGNED,
    itemID    INT UNSIGNED ,
    itemName  VARCHAR(30),
    itemPrice INT UNSIGNED,
    CONSTRAINT pk_fbsell PRIMARY KEY (cineplexID,itemID),
    CONSTRAINT pk_fbsell_foodbererage FOREIGN KEY (itemID) REFERENCES foodbeverage(itemID)
        ON DELETE CASCADE,
    CONSTRAINT pk_fbsell_cineplex FOREIGN KEY (cineplexID) REFERENCES cineplex(cineplexID)
        ON DELETE CASCADE
);

CREATE TABLE fborder(
    orderID INT UNSIGNED AUTO_INCREMENT,
    cID INT UNSIGNED,
    cineplexID INT UNSIGNED,
    itemID INT UNSIGNED,
    date DATE NOT NULL,
    CONSTRAINT pk_fborder PRIMARY KEY (orderID),
    CONSTRAINT fk_fborder_customer FOREIGN KEY (cID) REFERENCES customers(cID)
        ON DELETE CASCADE,
    CONSTRAINT fk_fborder_fbsell FOREIGN KEY (cineplexID,itemID) REFERENCES fbsell(cineplexID,itemID)
        ON DELETE CASCADE
);

CREATE TABLE reservations(
    reserveID INT UNSIGNED AUTO_INCREMENT,
    cID INT UNSIGNED,
    screentimeID INT UNSIGNED,
    cineplexID INT UNSIGNED,
    cinemaID INT UNSIGNED,
    seatNumb INT UNSIGNED,
    totalprice INT UNSIGNED,
    CONSTRAINT pk_reservations PRIMARY KEY (reserveID),
    CONSTRAINT fk_reservations_customers FOREIGN KEY (cID) REFERENCES customers(cID)
        ON DELETE CASCADE,
    CONSTRAINT fk_reservations_seats FOREIGN KEY (cineplexID,cinemaID,seatNumb) REFERENCES seats(cineplexID, cinemaID, seatNumb)
        ON DELETE CASCADE,
    CONSTRAINT fk_reservations_screentime FOREIGN KEY (screentimeID) REFERENCES screentime(screentimeID)
        ON DELETE CASCADE
);



INSERT INTO movies (name,image,moviedescription,genre,rated,rating,ticketprice)
VALUES ('The Dark Knight Rises','batmanrise.png','Following the death of District Attorney Harvey Dent, Batman assumes responsibility for Dent''s crimes to protect the late attorney''s reputation and is subsequently hunted by the Gotham City Police Department. Eight years later, Batman encounters the mysterious Selina Kyle and the villainous Bane, a new terrorist leader who overwhelms Gotham''s finest. The Dark Knight resurfaces to protect a city that has branded him an enemy','Action','PG-13','7.6','70000');
INSERT INTO movies (name,image,moviedescription,genre,rated,rating,ticketprice)
VALUES ('Superman Returns','supermanreturn.jpg','Superman returns to discover his 5-year absence has allowed Lex Luthor to walk free, and that those he was closest too felt abandoned and have moved on. Luthor plots his ultimate revenge that could see millions killed and change the face of the planet forever, as well as ridding himself of the Man of Steel','Adventure','PG-13','5.4','70000' );
INSERT INTO movies (name,image,moviedescription,genre,rated,rating,ticketprice)
VALUES ('Pearl Harbor','pearlhabor.jpg', 'The lifelong friendship between Rafe McCawley and Danny Walker is put to the ultimate test when the two ace fighter pilots become entangled in a love triangle with beautiful Naval nurse Evelyn Johnson. But the rivalry between the friends-turned-foes is immediately put on hold when they find themselves at the center of Japan''s devastating attack on Pearl Harbor on Dec. 7, 1941','History','R','6.6','70000');
INSERT INTO movies (name,image,moviedescription,genre,rated,rating,ticketprice)
VALUES ('The Lord of the Rings: The Return of the King','lordofthering.jpg', 'Aragorn is revealed as the heir to the ancient kings as he, Gandalf and the other members of the broken fellowship struggle to save Gondor from Sauron''s forces. Meanwhile, Frodo and Sam bring the ring closer to the heart of Mordor, the dark lord''s realm','Adventure','PG-13','8.1','70000');
INSERT INTO movies (name,image,moviedescription,genre,rated,rating,ticketprice)
VALUES ('Howl''s Moving Castle','movingcastle.jpg','A love story between an 18-year-old girl named Sophie, cursed by a witch into an old woman''s body, and a magician named Howl. Under the curse, Sophie sets out to seek her fortune, which takes her to Howl''s strange moving castle. In the castle, Sophie meets Howl''s fire demon, named Karishifâ. Seeing that she is under a curse, the demon makes a deal with Sophie--if she breaks the contract he is under with Howl, then Karushifâ will lift the curse that Sophie is under, and she will return to her 18-year-old shape','Adventure','PG','8.2','70000');
INSERT INTO movies (name,image,moviedescription,genre,rated,rating,ticketprice)
VALUES ('Spirited Away','spiritedaway.jpg','Chihiro and her parents are moving to a small Japanese town in the countryside, much to Chihiro''s dismay. On the way to their new home, Chihiro''s father makes a wrong turn and drives down a lonely one-lane road which dead-ends in front of a tunnel. Her parents decide to stop the car and explore the area. They go through the tunnel and find an abandoned amusement park on the other side, with its own little town. When her parents see a restaurant with great-smelling food but no staff, they decide to eat and pay later. However, Chihiro refuses to eat and decides to explore the theme park a bit more. She meets a boy named Haku who tells her that Chihiro and her parents are in danger, and they must leave immediately. She runs to the restaurant and finds that her parents have turned into pigs. In addition, the theme park turns out to be a town inhabited by demons, spirits, and evil gods. At the center of the town is a bathhouse where these creatures go to relax. The owner of the bathhouse is the evil witch Yubaba, who is intent on keeping all trespassers as captive workers, including Chihiro. Chihiro must rely on Haku to save her parents in hopes of returning to their world','Adventure','PG','8.6','70000');
INSERT INTO movies (name,image,moviedescription,genre,rated,rating,ticketprice)
VALUES ('The Lion King','lionking.jpg','A young lion prince is cast out of his pride by his cruel uncle, who claims he killed his father. While the uncle rules with an iron paw, the prince grows up beyond the Savannah, living by a philosophy: No worries for the rest of your days. But when his past comes to haunt him, the young prince must decide his fate: Will he remain an outcast or face his demons and become what he needs to be?','Drama','PG','8.5','70000');
INSERT INTO movies (name,image,moviedescription,genre,rated,rating,ticketprice)
VALUES ('Avatar','avatar.jpg','When his brother is killed in a robbery, paraplegic Marine Jake Sully decides to take his place in a mission on the distant world of Pandora. There he learns of greedy corporate figurehead Parker Selfridge''s intentions of driving off the native humanoid "Na''vi" in order to mine for the precious material scattered throughout their rich woodland. In exchange for the spinal surgery that will fix his legs, Jake gathers knowledge, of the Indigenous Race and their Culture, for the cooperating military unit spearheaded by gung-ho Colonel Quaritch, while simultaneously attempting to infiltrate the Na''vi people with the use of an "avatar" identity. While Jake begins to bond with the native tribe and quickly falls in love with the beautiful alien Neytiri, the restless Colonel moves forward with his ruthless extermination tactics, forcing the soldier to take a stand - and fight back in an epic battle for the fate of Pandora','Action','PG-13','7.8','70000');
INSERT INTO movies (name,image,moviedescription,genre,rated,rating,ticketprice)
VALUES ('Tron Legacy','tronlegacy.jpg','Sam Flynn, the tech-savvy and daring son of Kevin Flynn, investigates his father''s disappearance and is pulled into The Grid. With the help of a mysterious program named Quorra, Sam quests to stop evil dictator Clu from crossing into the real world','Adventure','PG','6.8','70000');
INSERT INTO movies (name,image,moviedescription,genre,rated,rating,ticketprice)
VALUES ('The Maze Runner','themazerunner.jpg','Set in a post-apocalyptic world, young Thomas is deposited in a community of boys after his memory is erased, soon learning they''re all trapped in a maze that will require him to join forces with fellow "runners" for a shot at escape','Action','PG-13','6.8','70000');



INSERT INTO cineplex (cineplexname,address, cineplexhotline, cinemaCount)
VALUES ('CGV','Mezzanine and 1st Floor, Liberty Central Saigon Citypoint Hotel, 59 Pasteur Street, District 1, HCMC','19006017','3');
INSERT INTO cineplex (cineplexname,address, cineplexhotline, cinemaCount)
VALUES ('CGV','B1, Vincom Center Landmark 81, 772 Dien Bien Phu Street, Ward 22, Binh Thanh District, HCMC','19006017','5');
INSERT INTO cineplex (cineplexname,address, cineplexhotline, cinemaCount)
VALUES ('CGV','Level 5, SC VivoCity – 1058 Nguyen Van Linh, District 7, HCMC','19006017','4');



INSERT INTO cinemas (cineplexID, cinemaID, maxseat)
VALUES
       ('1','1','10'), ('1','2','15'),('1','3','10');
INSERT INTO cinemas (cineplexID, cinemaID, maxseat)
VALUES
       ('2','1','12'),('2','2','10'),('2','3','12'),('2','4','15'),('2','5','8');
INSERT INTO cinemas (cineplexID, cinemaID, maxseat)
VALUES
       ('3','1','12'),('3','2','10'),('3','3','8'),('3','4','10');


INSERT INTO seats (cineplexID, cinemaID, seatNumb)
VALUES ('1','1','1'),('1','1','2'),('1','1','3'),('1','1','4'),('1','1','5'),
       ('1','1','6'),('1','1','7'),('1','1','8'),('1','1','9'),('1','1','10');
INSERT INTO seats (cineplexID, cinemaID, seatNumb)
VALUES ('1','2','1'),('1','2','2'),('1','2','3'),('1','2','4'),('1','2','5'),
       ('1','2','6'),('1','2','7'),('1','2','8'),('1','2','9'),('1','2','10'),
       ('1','2','11'),('1','2','12'),('1','2','13'),('1','2','14'),('1','2','15');
INSERT INTO seats (cineplexID, cinemaID, seatNumb)
VALUES ('1','3','1'),('1','3','2'),('1','3','3'),('1','3','4'),('1','3','5'),
       ('1','3','6'),('1','3','7'),('1','3','8'),('1','3','9'),('1','3','10');
INSERT INTO seats (cineplexID, cinemaID, seatNumb)
VALUES ('2','1','1'),('2','1','2'),('2','1','3'),('2','1','4'),('2','1','5'),
       ('2','1','6'),('2','1','7'),('2','1','8'),('2','1','9'),('2','1','10'),
       ('2','1','11'),('2','1','12');
INSERT INTO seats (cineplexID, cinemaID, seatNumb)
VALUES ('2','2','1'),('2','2','2'),('2','2','3'),('2','2','4'),('2','2','5'),
       ('2','2','6'),('2','2','7'),('2','2','8'),('2','2','9'),('2','2','10');
INSERT INTO seats (cineplexID, cinemaID, seatNumb)
VALUES ('2','3','1'),('2','3','2'),('2','3','3'),('2','3','4'),('2','3','5'),
       ('2','3','6'),('2','3','7'),('2','3','8'),('2','3','9'),('2','3','10'),
       ('2','3','11'),('2','3','12');
INSERT INTO seats (cineplexID, cinemaID, seatNumb)
VALUES ('2','4','1'),('2','4','2'),('2','4','3'),('2','4','4'),('2','4','5'),
       ('2','4','6'),('2','4','7'),('2','4','8'),('2','4','9'),('2','4','10'),
       ('2','4','11'),('2','4','12'),('2','4','13'),('2','4','14'),('2','4','15');
INSERT INTO seats (cineplexID, cinemaID, seatNumb)
VALUES ('2','5','1'),('2','5','2'),('2','5','3'),('2','5','4'),('2','5','5'),
       ('2','5','6'),('2','5','7'),('2','5','8');
INSERT INTO seats (cineplexID, cinemaID, seatNumb)
VALUES ('3','1','1'),('3','1','2'),('3','1','3'),('3','1','4'),('3','1','5'),
       ('3','1','6'),('3','1','7'),('3','1','8'),('3','1','9'),('3','1','10'),
       ('3','1','11'),('3','1','12');
INSERT INTO seats (cineplexID, cinemaID, seatNumb)
VALUES ('3','2','1'),('3','2','2'),('3','2','3'),('3','2','4'),('3','2','5'),
       ('3','2','6'),('3','2','7'),('3','2','8'),('3','2','9'),('3','2','10');
INSERT INTO seats (cineplexID, cinemaID, seatNumb)
VALUES ('3','3','1'),('3','3','2'),('3','3','3'),('3','3','4'),('3','3','5'),
       ('3','3','6'),('3','3','7'),('3','3','8');
INSERT INTO seats (cineplexID, cinemaID, seatNumb)
VALUES ('3','4','1'),('3','4','2'),('3','4','3'),('3','4','4'),('3','4','5'),
       ('3','4','6'),('3','4','7'),('3','4','8'),('3','4','9'),('3','4','10');

INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('1','1','1','Wednesday','2021-09-01','10:30'),
       ('1','1','4','Wednesday','2021-09-01','13:25'),
       ('1','1','9','Wednesday','2021-09-01','17:40'),
       ('1','1','2','Wednesday','2021-09-01','20:00'),
       ('1','1','8','Wednesday','2021-09-01','23:00');
INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('1','2','2','Wednesday','2021-09-01','10:30'),
       ('1','2','5','Wednesday','2021-09-01','13:30'),
       ('1','2','8','Wednesday','2021-09-01','15:45'),
       ('1','2','10','Wednesday','2021-09-01','18:40'),
       ('1','2','6','Wednesday','2021-09-01','20:50');
INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('1','3','3','Wednesday','2021-09-01','10:30'),
       ('1','3','6','Wednesday','2021-09-01','13:45'),
       ('1','3','7','Wednesday','2021-09-01','16:00'),
       ('1','3','1','Wednesday','2021-09-01','18:10'),
       ('1','3','3','Wednesday','2021-09-01','21:25');

INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('1','1','1','Thursday','2021-09-02','10:30'),
       ('1','1','4','Thursday','2021-09-02','13:25'),
       ('1','1','9','Thursday','2021-09-02','17:40'),
       ('1','1','2','Thursday','2021-09-02','20:00'),
       ('1','1','8','Thursday','2021-09-02','23:00');
INSERT INTO screentime (cineplexID, cinemaID, mID, day ,date, starttime)
VALUES ('1','2','2','Thursday','2021-09-02','10:30'),
       ('1','2','5','Thursday','2021-09-02','13:30'),
       ('1','2','8','Thursday','2021-09-02','15:45'),
       ('1','2','10','Thursday','2021-09-02','18:40'),
       ('1','2','6','Thursday','2021-09-02','20:50');
INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('1','3','3','Thursday','2021-09-02','10:30'),
       ('1','3','6','Thursday','2021-09-02','13:45'),
       ('1','3','7','Thursday','2021-09-02','16:00'),
       ('1','3','1','Thursday','2021-09-02','18:10'),
       ('1','3','3','Thursday','2021-09-02','21:25');

INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('1','1','1','Friday','2021-09-03','10:30'),
       ('1','1','4','Friday','2021-09-03','13:25'),
       ('1','1','9','Friday','2021-09-03','17:40'),
       ('1','1','2','Friday','2021-09-03','20:00'),
       ('1','1','8','Friday','2021-09-03','23:00');
INSERT INTO screentime (cineplexID, cinemaID, mID, day ,date, starttime)
VALUES ('1','2','2','Friday','2021-09-03','10:30'),
       ('1','2','5','Friday','2021-09-03','13:30'),
       ('1','2','8','Friday','2021-09-03','15:45'),
       ('1','2','10','Friday','2021-09-03','18:40'),
       ('1','2','6','Friday','2021-09-03','20:50');
INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('1','3','3','Friday','2021-09-03','10:30'),
       ('1','3','6','Friday','2021-09-03','13:45'),
       ('1','3','7','Friday','2021-09-03','16:00'),
       ('1','3','1','Friday','2021-09-03','18:10'),
       ('1','3','3','Friday','2021-09-03','21:25');

INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('1','1','1','Saturday','2021-09-04','10:30'),
       ('1','1','4','Saturday','2021-09-04','13:25'),
       ('1','1','9','Saturday','2021-09-04','17:40'),
       ('1','1','2','Saturday','2021-09-04','20:00'),
       ('1','1','8','Saturday','2021-09-04','23:00');
INSERT INTO screentime (cineplexID, cinemaID, mID, day ,date, starttime)
VALUES ('1','2','2','Saturday','2021-09-04','10:30'),
       ('1','2','5','Saturday','2021-09-04','13:30'),
       ('1','2','8','Saturday','2021-09-04','15:45'),
       ('1','2','10','Saturday','2021-09-04','18:40'),
       ('1','2','6','Saturday','2021-09-04','20:50');
INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('1','3','3','Saturday','2021-09-04','10:30'),
       ('1','3','6','Saturday','2021-09-04','13:45'),
       ('1','3','7','Saturday','2021-09-04','16:00'),
       ('1','3','1','Saturday','2021-09-04','18:10'),
       ('1','3','3','Saturday','2021-09-04','21:25');

INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('1','1','1','Sunday','2021-09-05','10:30'),
       ('1','1','4','Sunday','2021-09-05','13:25'),
       ('1','1','9','Sunday','2021-09-05','17:40'),
       ('1','1','2','Sunday','2021-09-05','20:00'),
       ('1','1','8','Sunday','2021-09-05','23:00');
INSERT INTO screentime (cineplexID, cinemaID, mID, day ,date, starttime)
VALUES ('1','2','2','Sunday','2021-09-05','10:30'),
       ('1','2','5','Sunday','2021-09-05','13:30'),
       ('1','2','8','Sunday','2021-09-05','15:45'),
       ('1','2','10','Sunday','2021-09-05','18:40'),
       ('1','2','6','Sunday','2021-09-05','20:50');
INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('1','3','3','Sunday','2021-09-05','10:30'),
       ('1','3','6','Sunday','2021-09-05','13:45'),
       ('1','3','7','Sunday','2021-09-05','16:00'),
       ('1','3','1','Sunday','2021-09-05','18:10'),
       ('1','3','3','Sunday','2021-09-05','21:25');

INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('1','1','1','Monday','2021-09-06','10:30'),
       ('1','1','4','Monday','2021-09-06','13:25'),
       ('1','1','9','Monday','2021-09-06','17:40'),
       ('1','1','2','Monday','2021-09-06','20:00'),
       ('1','1','8','Monday','2021-09-06','23:00');
INSERT INTO screentime (cineplexID, cinemaID, mID, day ,date, starttime)
VALUES ('1','2','2','Monday','2021-09-06','10:30'),
       ('1','2','5','Monday','2021-09-06','13:30'),
       ('1','2','8','Monday','2021-09-06','15:45'),
       ('1','2','10','Monday','2021-09-06','18:40'),
       ('1','2','6','Monday','2021-09-06','20:50');
INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('1','3','3','Monday','2021-09-06','10:30'),
       ('1','3','6','Monday','2021-09-06','13:45'),
       ('1','3','7','Monday','2021-09-06','16:00'),
       ('1','3','1','Monday','2021-09-06','18:10'),
       ('1','3','3','Monday','2021-09-06','21:25');

INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('1','1','1','Tuesday','2021-09-07','10:30'),
       ('1','1','4','Tuesday','2021-09-07','13:25'),
       ('1','1','9','Tuesday','2021-09-07','17:40'),
       ('1','1','2','Tuesday','2021-09-07','20:00'),
       ('1','1','8','Tuesday','2021-09-07','23:00');
INSERT INTO screentime (cineplexID, cinemaID, mID, day ,date, starttime)
VALUES ('1','2','2','Tuesday','2021-09-07','10:30'),
       ('1','2','5','Tuesday','2021-09-07','13:30'),
       ('1','2','8','Tuesday','2021-09-07','15:45'),
       ('1','2','10','Tuesday','2021-09-07','18:40'),
       ('1','2','6','Tuesday','2021-09-07','20:50');
INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('1','3','3','Tuesday','2021-09-07','10:30'),
       ('1','3','6','Tuesday','2021-09-07','13:45'),
       ('1','3','7','Tuesday','2021-09-07','16:00'),
       ('1','3','1','Tuesday','2021-09-07','18:10'),
       ('1','3','3','Tuesday','2021-09-07','21:25');

INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('2','1','1','Wednesday','2021-09-01','10:00'),
       ('2','1','7','Wednesday','2021-09-01','12:55'),
       ('2','1','2','Wednesday','2021-09-01','15:10'),
       ('2','1','6','Wednesday','2021-09-01','18:10'),
       ('2','1','7','Wednesday','2021-09-01','20:25'),
       ('2','1','1','Wednesday','2021-09-01','22:40');
INSERT INTO screentime (cineplexID, cinemaID, mID, day,date, starttime)
VALUES ('2','2','2','Wednesday','2021-09-01','10:00'),
       ('2','2','8','Wednesday','2021-09-01','13:05'),
       ('2','2','4','Wednesday','2021-09-01','16:00'),
       ('2','2','9','Wednesday','2021-09-01','20:20'),
       ('2','2','5','Wednesday','2021-09-01','22:40');
INSERT INTO screentime (cineplexID, cinemaID, mID, day,date, starttime)
VALUES ('2','3','3','Wednesday','2021-09-01','10:00'),
       ('2','3','9','Wednesday','2021-09-01','13:20'),
       ('2','3','3','Wednesday','2021-09-01','15:40'),
       ('2','3','8','Wednesday','2021-09-01','19:00'),
       ('2','3','6','Wednesday','2021-09-01','21:55');
INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('2','4','4','Wednesday','2021-09-01','10:00'),
       ('2','4','10','Wednesday','2021-09-01','14:25'),
       ('2','4','5','Wednesday','2021-09-01','16:30'),
       ('2','4','7','Wednesday','2021-09-01','18:40'),
       ('2','4','2','Wednesday','2021-09-01','20:50');
INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('2','5','5','Wednesday','2021-09-01','10:00'),
       ('2','5','6','Wednesday','2021-09-01','12:10'),
       ('2','5','1','Wednesday','2021-09-01','14:25'),
       ('2','5','6','Wednesday','2021-09-01','17:20'),
       ('2','5','10','Wednesday','2021-09-01','19:35'),
       ('2','5','9','Wednesday','2021-09-01','21:55');

INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('2','1','1','Thursday','2021-09-02','10:00'),
       ('2','1','7','Thursday','2021-09-02','12:55'),
       ('2','1','2','Thursday','2021-09-02','15:10'),
       ('2','1','6','Thursday','2021-09-02','18:10'),
       ('2','1','7','Thursday','2021-09-02','20:25'),
       ('2','1','1','Thursday','2021-09-02','22:40');
INSERT INTO screentime (cineplexID, cinemaID, mID, day,date, starttime)
VALUES ('2','2','2','Thursday','2021-09-02','10:00'),
       ('2','2','8','Thursday','2021-09-02','13:05'),
       ('2','2','4','Thursday','2021-09-02','16:00'),
       ('2','2','9','Thursday','2021-09-02','20:20'),
       ('2','2','5','Thursday','2021-09-02','22:40');
INSERT INTO screentime (cineplexID, cinemaID, mID, day,date, starttime)
VALUES ('2','3','3','Thursday','2021-09-02','10:00'),
       ('2','3','9','Thursday','2021-09-02','13:20'),
       ('2','3','3','Thursday','2021-09-02','15:40'),
       ('2','3','8','Thursday','2021-09-02','19:00'),
       ('2','3','6','Thursday','2021-09-02','21:55');
INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('2','4','4','Thursday','2021-09-02','10:00'),
       ('2','4','10','Thursday','2021-09-02','14:25'),
       ('2','4','5','Thursday','2021-09-02','16:30'),
       ('2','4','7','Thursday','2021-09-02','18:40'),
       ('2','4','2','Thursday','2021-09-02','20:50');
INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('2','5','5','Thursday','2021-09-02','10:00'),
       ('2','5','6','Thursday','2021-09-02','12:10'),
       ('2','5','1','Thursday','2021-09-02','14:25'),
       ('2','5','6','Thursday','2021-09-02','17:20'),
       ('2','5','10','Thursday','2021-09-02','19:35'),
       ('2','5','9','Thursday','2021-09-02','21:55');

INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('2','1','1','Friday','2021-09-03','10:00'),
       ('2','1','7','Friday','2021-09-03','12:55'),
       ('2','1','2','Friday','2021-09-03','15:10'),
       ('2','1','6','Friday','2021-09-03','18:10'),
       ('2','1','7','Friday','2021-09-03','20:25'),
       ('2','1','1','Friday','2021-09-03','22:40');
INSERT INTO screentime (cineplexID, cinemaID, mID, day,date, starttime)
VALUES ('2','2','2','Friday','2021-09-03','10:00'),
       ('2','2','8','Friday','2021-09-03','13:05'),
       ('2','2','4','Friday','2021-09-03','16:00'),
       ('2','2','9','Friday','2021-09-03','20:20'),
       ('2','2','5','Friday','2021-09-03','22:40');
INSERT INTO screentime (cineplexID, cinemaID, mID, day,date, starttime)
VALUES ('2','3','3','Friday','2021-09-03','10:00'),
       ('2','3','9','Friday','2021-09-03','13:20'),
       ('2','3','3','Friday','2021-09-03','15:40'),
       ('2','3','8','Friday','2021-09-03','19:00'),
       ('2','3','6','Friday','2021-09-03','21:55');
INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('2','4','4','Friday','2021-09-03','10:00'),
       ('2','4','10','Friday','2021-09-03','14:25'),
       ('2','4','5','Friday','2021-09-03','16:30'),
       ('2','4','7','Friday','2021-09-03','18:40'),
       ('2','4','2','Friday','2021-09-03','20:50');
INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('2','5','5','Friday','2021-09-03','10:00'),
       ('2','5','6','Friday','2021-09-03','12:10'),
       ('2','5','1','Friday','2021-09-03','14:25'),
       ('2','5','6','Friday','2021-09-03','17:20'),
       ('2','5','10','Friday','2021-09-03','19:35'),
       ('2','5','9','Friday','2021-09-03','21:55');

INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('2','1','1','Saturday','2021-09-04','10:00'),
       ('2','1','7','Saturday','2021-09-04','12:55'),
       ('2','1','2','Saturday','2021-09-04','15:10'),
       ('2','1','6','Saturday','2021-09-04','18:10'),
       ('2','1','7','Saturday','2021-09-04','20:25'),
       ('2','1','1','Saturday','2021-09-04','22:40');
INSERT INTO screentime (cineplexID, cinemaID, mID, day,date, starttime)
VALUES ('2','2','2','Saturday','2021-09-04','10:00'),
       ('2','2','8','Saturday','2021-09-04','13:05'),
       ('2','2','4','Saturday','2021-09-04','16:00'),
       ('2','2','9','Saturday','2021-09-04','20:20'),
       ('2','2','5','Saturday','2021-09-04','22:40');
INSERT INTO screentime (cineplexID, cinemaID, mID, day,date, starttime)
VALUES ('2','3','3','Saturday','2021-09-04','10:00'),
       ('2','3','9','Saturday','2021-09-04','13:20'),
       ('2','3','3','Saturday','2021-09-04','15:40'),
       ('2','3','8','Saturday','2021-09-04','19:00'),
       ('2','3','6','Saturday','2021-09-04','21:55');
INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('2','4','4','Saturday','2021-09-04','10:00'),
       ('2','4','10','Saturday','2021-09-04','14:25'),
       ('2','4','5','Saturday','2021-09-04','16:30'),
       ('2','4','7','Saturday','2021-09-04','18:40'),
       ('2','4','2','Saturday','2021-09-04','20:50');
INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('2','5','5','Saturday','2021-09-04','10:00'),
       ('2','5','6','Saturday','2021-09-04','12:10'),
       ('2','5','1','Saturday','2021-09-04','14:25'),
       ('2','5','6','Saturday','2021-09-04','17:20'),
       ('2','5','10','Saturday','2021-09-04','19:35'),
       ('2','5','9','Saturday','2021-09-04','21:55');

INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('2','1','1','Sunday','2021-09-05','10:00'),
       ('2','1','7','Sunday','2021-09-05','12:55'),
       ('2','1','2','Sunday','2021-09-05','15:10'),
       ('2','1','6','Sunday','2021-09-05','18:10'),
       ('2','1','7','Sunday','2021-09-05','20:25'),
       ('2','1','1','Sunday','2021-09-05','22:40');
INSERT INTO screentime (cineplexID, cinemaID, mID, day,date, starttime)
VALUES ('2','2','2','Sunday','2021-09-05','10:00'),
       ('2','2','8','Sunday','2021-09-05','13:05'),
       ('2','2','4','Sunday','2021-09-05','16:00'),
       ('2','2','9','Sunday','2021-09-05','20:20'),
       ('2','2','5','Sunday','2021-09-05','22:40');
INSERT INTO screentime (cineplexID, cinemaID, mID, day,date, starttime)
VALUES ('2','3','3','Sunday','2021-09-05','10:00'),
       ('2','3','9','Sunday','2021-09-05','13:20'),
       ('2','3','3','Sunday','2021-09-05','15:40'),
       ('2','3','8','Sunday','2021-09-05','19:00'),
       ('2','3','6','Sunday','2021-09-05','21:55');
INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('2','4','4','Sunday','2021-09-05','10:00'),
       ('2','4','10','Sunday','2021-09-05','14:25'),
       ('2','4','5','Sunday','2021-09-05','16:30'),
       ('2','4','7','Sunday','2021-09-05','18:40'),
       ('2','4','2','Sunday','2021-09-05','20:50');
INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('2','5','5','Sunday','2021-09-05','10:00'),
       ('2','5','6','Sunday','2021-09-05','12:10'),
       ('2','5','1','Sunday','2021-09-05','14:25'),
       ('2','5','6','Sunday','2021-09-05','17:20'),
       ('2','5','10','Sunday','2021-09-05','19:35'),
       ('2','5','9','Sunday','2021-09-05','21:55');

INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('2','1','1','Monday','2021-09-06','10:00'),
       ('2','1','7','Monday','2021-09-06','12:55'),
       ('2','1','2','Monday','2021-09-06','15:10'),
       ('2','1','6','Monday','2021-09-06','18:10'),
       ('2','1','7','Monday','2021-09-06','20:25'),
       ('2','1','1','Monday','2021-09-06','22:40');
INSERT INTO screentime (cineplexID, cinemaID, mID, day,date, starttime)
VALUES ('2','2','2','Monday','2021-09-06','10:00'),
       ('2','2','8','Monday','2021-09-06','13:05'),
       ('2','2','4','Monday','2021-09-06','16:00'),
       ('2','2','9','Monday','2021-09-06','20:20'),
       ('2','2','5','Monday','2021-09-06','22:40');
INSERT INTO screentime (cineplexID, cinemaID, mID, day,date, starttime)
VALUES ('2','3','3','Monday','2021-09-06','10:00'),
       ('2','3','9','Monday','2021-09-06','13:20'),
       ('2','3','3','Monday','2021-09-06','15:40'),
       ('2','3','8','Monday','2021-09-06','19:00'),
       ('2','3','6','Monday','2021-09-06','21:55');
INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('2','4','4','Monday','2021-09-06','10:00'),
       ('2','4','10','Monday','2021-09-06','14:25'),
       ('2','4','5','Monday','2021-09-06','16:30'),
       ('2','4','7','Monday','2021-09-06','18:40'),
       ('2','4','2','Monday','2021-09-06','20:50');
INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('2','5','5','Monday','2021-09-06','10:00'),
       ('2','5','6','Monday','2021-09-06','12:10'),
       ('2','5','1','Monday','2021-09-06','14:25'),
       ('2','5','6','Monday','2021-09-06','17:20'),
       ('2','5','10','Monday','2021-09-06','19:35'),
       ('2','5','9','Monday','2021-09-06','21:55');

INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('2','1','1','Tuesday','2021-09-07','10:00'),
       ('2','1','7','Tuesday','2021-09-07','12:55'),
       ('2','1','2','Tuesday','2021-09-07','15:10'),
       ('2','1','6','Tuesday','2021-09-07','18:10'),
       ('2','1','7','Tuesday','2021-09-07','20:25'),
       ('2','1','1','Tuesday','2021-09-07','22:40');
INSERT INTO screentime (cineplexID, cinemaID, mID, day,date, starttime)
VALUES ('2','2','2','Tuesday','2021-09-07','10:00'),
       ('2','2','8','Tuesday','2021-09-07','13:05'),
       ('2','2','4','Tuesday','2021-09-07','16:00'),
       ('2','2','9','Tuesday','2021-09-07','20:20'),
       ('2','2','5','Tuesday','2021-09-07','22:40');
INSERT INTO screentime (cineplexID, cinemaID, mID, day,date, starttime)
VALUES ('2','3','3','Tuesday','2021-09-07','10:00'),
       ('2','3','9','Tuesday','2021-09-07','13:20'),
       ('2','3','3','Tuesday','2021-09-07','15:40'),
       ('2','3','8','Tuesday','2021-09-07','19:00'),
       ('2','3','6','Tuesday','2021-09-07','21:55');
INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('2','4','4','Tuesday','2021-09-07','10:00'),
       ('2','4','10','Tuesday','2021-09-07','14:25'),
       ('2','4','5','Tuesday','2021-09-07','16:30'),
       ('2','4','7','Tuesday','2021-09-07','18:40'),
       ('2','4','2','Tuesday','2021-09-07','20:50');
INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('2','5','5','Tuesday','2021-09-07','10:00'),
       ('2','5','6','Tuesday','2021-09-07','12:10'),
       ('2','5','1','Tuesday','2021-09-07','14:25'),
       ('2','5','6','Tuesday','2021-09-07','17:20'),
       ('2','5','10','Tuesday','2021-09-07','19:35'),
       ('2','5','9','Tuesday','2021-09-07','21:55');

INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('3','1','1','Wednesday','2021-09-01','10:30'),
       ('3','1','5','Wednesday','2021-09-01','13:25'),
       ('3','1','9','Wednesday','2021-09-01','15:40'),
       ('3','1','3','Wednesday','2021-09-01','18:00'),
       ('3','1','8','Wednesday','2021-09-01','21:15');
INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('3','2','2','Wednesday','2021-09-01','10:30'),
       ('3','2','6','Wednesday','2021-09-01','13:30'),
       ('3','2','10','Wednesday','2021-09-01','15:45'),
       ('3','2','4','Wednesday','2021-09-01','18:00'),
       ('3','2','9','Wednesday','2021-09-01','22:20');
INSERT INTO screentime (cineplexID, cinemaID, mID, day,date, starttime)
VALUES ('3','3','3','Wednesday','2021-09-01','10:30'),
       ('3','3','7','Wednesday','2021-09-01','13:45'),
       ('3','3','1','Wednesday','2021-09-01','16:00'),
       ('3','3','5','Wednesday','2021-09-01','18:55'),
       ('3','3','7','Wednesday','2021-09-01','21:10');
INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('3','4','4','Wednesday','2021-09-01','10:30'),
       ('3','4','8','Wednesday','2021-09-01','14:55'),
       ('3','4','2','Wednesday','2021-09-01','17:50'),
       ('3','4','6','Wednesday','2021-09-01','20:55'),
       ('3','4','10','Wednesday','2021-09-01','23:10');

INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('3','1','1','Thursday','2021-09-02','10:30'),
       ('3','1','5','Thursday','2021-09-02','13:25'),
       ('3','1','9','Thursday','2021-09-02','15:40'),
       ('3','1','3','Thursday','2021-09-02','18:00'),
       ('3','1','8','Thursday','2021-09-02','21:15');
INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('3','2','2','Thursday','2021-09-02','10:30'),
       ('3','2','6','Thursday','2021-09-02','13:30'),
       ('3','2','10','Thursday','2021-09-02','15:45'),
       ('3','2','4','Thursday','2021-09-02','18:00'),
       ('3','2','9','Thursday','2021-09-02','22:20');
INSERT INTO screentime (cineplexID, cinemaID, mID, day,date, starttime)
VALUES ('3','3','3','Thursday','2021-09-02','10:30'),
       ('3','3','7','Thursday','2021-09-02','13:45'),
       ('3','3','1','Thursday','2021-09-02','16:00'),
       ('3','3','5','Thursday','2021-09-02','18:55'),
       ('3','3','7','Thursday','2021-09-02','21:10');
INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('3','4','4','Thursday','2021-09-02','10:30'),
       ('3','4','8','Thursday','2021-09-02','14:55'),
       ('3','4','2','Thursday','2021-09-02','17:50'),
       ('3','4','6','Thursday','2021-09-02','20:55'),
       ('3','4','10','Thursday','2021-09-02','23:10');

INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('3','1','1','Friday','2021-09-03','10:30'),
       ('3','1','5','Friday','2021-09-03','13:25'),
       ('3','1','9','Friday','2021-09-03','15:40'),
       ('3','1','3','Friday','2021-09-03','18:00'),
       ('3','1','8','Friday','2021-09-03','21:15');
INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('3','2','2','Friday','2021-09-03','10:30'),
       ('3','2','6','Friday','2021-09-03','13:30'),
       ('3','2','10','Friday','2021-09-03','15:45'),
       ('3','2','4','Friday','2021-09-03','18:00'),
       ('3','2','9','Friday','2021-09-03','22:20');
INSERT INTO screentime (cineplexID, cinemaID, mID, day,date, starttime)
VALUES ('3','3','3','Friday','2021-09-03','10:30'),
       ('3','3','7','Friday','2021-09-03','13:45'),
       ('3','3','1','Friday','2021-09-03','16:00'),
       ('3','3','5','Friday','2021-09-03','18:55'),
       ('3','3','7','Friday','2021-09-03','21:10');
INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('3','4','4','Friday','2021-09-03','10:30'),
       ('3','4','8','Friday','2021-09-03','14:55'),
       ('3','4','2','Friday','2021-09-03','17:50'),
       ('3','4','6','Friday','2021-09-03','20:55'),
       ('3','4','10','Friday','2021-09-03','23:10');

INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('3','1','1','Saturday','2021-09-04','10:30'),
       ('3','1','5','Saturday','2021-09-04','13:25'),
       ('3','1','9','Saturday','2021-09-04','15:40'),
       ('3','1','3','Saturday','2021-09-04','18:00'),
       ('3','1','8','Saturday','2021-09-04','21:15');
INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('3','2','2','Saturday','2021-09-04','10:30'),
       ('3','2','6','Saturday','2021-09-04','13:30'),
       ('3','2','10','Saturday','2021-09-04','15:45'),
       ('3','2','4','Saturday','2021-09-04','18:00'),
       ('3','2','9','Saturday','2021-09-04','22:20');
INSERT INTO screentime (cineplexID, cinemaID, mID, day,date, starttime)
VALUES ('3','3','3','Saturday','2021-09-04','10:30'),
       ('3','3','7','Saturday','2021-09-04','13:45'),
       ('3','3','1','Saturday','2021-09-04','16:00'),
       ('3','3','5','Saturday','2021-09-04','18:55'),
       ('3','3','7','Saturday','2021-09-04','21:10');
INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('3','4','4','Saturday','2021-09-04','10:30'),
       ('3','4','8','Saturday','2021-09-04','14:55'),
       ('3','4','2','Saturday','2021-09-04','17:50'),
       ('3','4','6','Saturday','2021-09-04','20:55'),
       ('3','4','10','Saturday','2021-09-04','23:10');

INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('3','1','1','Sunday','2021-09-05','10:30'),
       ('3','1','5','Sunday','2021-09-05','13:25'),
       ('3','1','9','Sunday','2021-09-05','15:40'),
       ('3','1','3','Sunday','2021-09-05','18:00'),
       ('3','1','8','Sunday','2021-09-05','21:15');
INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('3','2','2','Sunday','2021-09-05','10:30'),
       ('3','2','6','Sunday','2021-09-05','13:30'),
       ('3','2','10','Sunday','2021-09-05','15:45'),
       ('3','2','4','Sunday','2021-09-05','18:00'),
       ('3','2','9','Sunday','2021-09-05','22:20');
INSERT INTO screentime (cineplexID, cinemaID, mID, day,date, starttime)
VALUES ('3','3','3','Sunday','2021-09-05','10:30'),
       ('3','3','7','Sunday','2021-09-05','13:45'),
       ('3','3','1','Sunday','2021-09-05','16:00'),
       ('3','3','5','Sunday','2021-09-05','18:55'),
       ('3','3','7','Sunday','2021-09-05','21:10');
INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('3','4','4','Sunday','2021-09-05','10:30'),
       ('3','4','8','Sunday','2021-09-05','14:55'),
       ('3','4','2','Sunday','2021-09-05','17:50'),
       ('3','4','6','Sunday','2021-09-05','20:55'),
       ('3','4','10','Sunday','2021-09-05','23:10');

INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('3','1','1','Monday','2021-09-06','10:30'),
       ('3','1','5','Monday','2021-09-06','13:25'),
       ('3','1','9','Monday','2021-09-06','15:40'),
       ('3','1','3','Monday','2021-09-06','18:00'),
       ('3','1','8','Monday','2021-09-06','21:15');
INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('3','2','2','Monday','2021-09-06','10:30'),
       ('3','2','6','Monday','2021-09-06','13:30'),
       ('3','2','10','Monday','2021-09-06','15:45'),
       ('3','2','4','Monday','2021-09-06','18:00'),
       ('3','2','9','Monday','2021-09-06','22:20');
INSERT INTO screentime (cineplexID, cinemaID, mID, day,date, starttime)
VALUES ('3','3','3','Monday','2021-09-06','10:30'),
       ('3','3','7','Monday','2021-09-06','13:45'),
       ('3','3','1','Monday','2021-09-06','16:00'),
       ('3','3','5','Monday','2021-09-06','18:55'),
       ('3','3','7','Monday','2021-09-06','21:10');
INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('3','4','4','Monday','2021-09-06','10:30'),
       ('3','4','8','Monday','2021-09-06','14:55'),
       ('3','4','2','Monday','2021-09-06','17:50'),
       ('3','4','6','Monday','2021-09-06','20:55'),
       ('3','4','10','Monday','2021-09-06','23:10');

INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('3','1','1','Tuesday','2021-09-07','10:30'),
       ('3','1','5','Tuesday','2021-09-07','13:25'),
       ('3','1','9','Tuesday','2021-09-07','15:40'),
       ('3','1','3','Tuesday','2021-09-07','18:00'),
       ('3','1','8','Tuesday','2021-09-07','21:15');
INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('3','2','2','Tuesday','2021-09-07','10:30'),
       ('3','2','6','Tuesday','2021-09-07','13:30'),
       ('3','2','10','Tuesday','2021-09-07','15:45'),
       ('3','2','4','Tuesday','2021-09-07','18:00'),
       ('3','2','9','Tuesday','2021-09-07','22:20');
INSERT INTO screentime (cineplexID, cinemaID, mID, day,date, starttime)
VALUES ('3','3','3','Tuesday','2021-09-07','10:30'),
       ('3','3','7','Tuesday','2021-09-07','13:45'),
       ('3','3','1','Tuesday','2021-09-07','16:00'),
       ('3','3','5','Tuesday','2021-09-07','18:55'),
       ('3','3','7','Tuesday','2021-09-07','21:10');
INSERT INTO screentime (cineplexID, cinemaID, mID,day, date, starttime)
VALUES ('3','4','4','Tuesday','2021-09-07','10:30'),
       ('3','4','8','Tuesday','2021-09-07','14:55'),
       ('3','4','2','Tuesday','2021-09-07','17:50'),
       ('3','4','6','Tuesday','2021-09-07','20:55'),
       ('3','4','10','Tuesday','2021-09-07','23:10');

INSERT INTO foodbeverage ( itemName, itemImage, itemPrice)
VALUES ('Sweet Popcorn','.jpg','35000'),
       ('Caramel Popcorn','.jpg','45000'),
       ('Cheese Popcorn','.jpg','45000'),
       ('Coca-Cola','.jpg','25000'),
       ('Sprite','.jpg','25000'),
       ('Dasani','.jpg','20000'),
       ('Fries','.jpg','40000'),
       ('Lays Chip','.jpg','20000');

INSERT INTO fbsell (cineplexID,itemID,itemName,itemPrice)
VALUES ('1','1','Sweet Popcorn','35000'),
       ('1','2','Caramel Popcorn','45000'),
       ('1','3','Cheese Popcorn','45000'),
       ('1','4','Coca-Cola','25000'),
       ('1','5','Sprite','25000'),
       ('1','6','Dasani','20000'),
       ('1','7','Fries','40000');
INSERT INTO fbsell (cineplexID,itemID, itemName, itemPrice)
VALUES ('2','1','Sweet Popcorn','35000'),
       ('2','2','Caramel Popcorn','45000'),
       ('2','3','Cheese Popcorn','45000'),
       ('2','4','Coca-Cola','25000'),
       ('2','5','Sprite','25000'),
       ('2','6','Dasani','20000');
INSERT INTO fbsell (cineplexID,itemID,itemName, itemPrice)
VALUES ('3','1','Sweet Popcorn','35000'),
       ('3','2','Caramel Popcorn','45000'),
       ('3','3','Cheese Popcorn','45000'),
       ('3','4','Coca-Cola','25000'),
       ('3','5','Sprite','25000'),
       ('3','6','Dasani','20000'),
       ('3','7','Fries','40000'),
       ('3','8','Lays Chip','20000');

INSERT INTO customers (cUsername, cPassword, fname, lname, dob, gender, phone)
VALUES ('truongchinh411','Etl30e03FP','Chinh','Nguyen','1985-09-07','Male','0123456789'),
       ('manhdung1995','ksd76ChXMq','Dung','Nguyen','1995-05-06','Male','0123456788'),
       ('doanquang65','wtEqGzkDr3','Quang','Doan','1977-09-03','Male','0123456787'),
       ('phandung1018','NhHxZee97a','Dung','Phan','2002-10-18','Male','0123456786'),
       ('dohung91','LAAghbkErN','Hung','Do','1991-02-26','Male','0123456785'),
       ('vuquyen0603','xLxgJatHtF','Vu','Quyen','2000-06-06','Male','0123456784'),
       ('qiangq1218','Ou4SCAXMw8','Giang','Quach','1989-12-18','Male','0123456783'),
       ('thanhdang73','L5Ox2ijGve','Thanh','Dang','1973-01-10','Male','0123456782'),
       ('vanviet0101','mHoQ6tfoC2','Viet','Van','2001-01-07','Male','0123456781'),
       ('cuongt91','T6Ss22DAEV','Cuong','Tran','1991-05-18','Male','0123456780'),
       ('phucvu2k','SqDaFdb8RQ','Phuc','Vu','2000-06-02','Male','0123456779'),
       ('zangdang','lFYQL1t3w7','Giang','Dang','1998-06-05','Male','0123456778'),
       ('anninh83','eRRdC9FUxQ','Ninh','Nguyen','1983-04-12','Male','0123456777'),
       ('huypham2k1','N1ab01nAJf','Huy','Pham','2001-06-02','Male','0123456776'),
       ('xuanvu1999','kAQsd9YFPs','Xuan','Vu','1999-12-03','Male','0123456775'),
       ('tronghung94','kAQsd9YFPs','Hung','Nguyen','1994-05-19','Male','0123456774'),
       ('huytuan2003','kAQsd9YFPs','Tuan','Hoang','2003-05-16','Male','0123456773'),
       ('chiduong97','2hXW0ppxd6','Duong','Nguyen','1997-01-01','Male','0123456772'),
       ('tuanson90','tJjlJarQSe','Son','Vu','1990-10-01','Male','0123456771'),
       ('thienphuoc0802','gGdI91QbKE','Phuoc','Ngo','1999-08-02','Male','0123456770'),
       ('davidbui01','GRIB4gFEue','Duc','Bui','2001-06-18','Male','0123456769'),
       ('mibui811','65B8W2RoFE','Mi','Bui','1993-08-11','Female','0123456768'),
       ('phuongly2k','SOzx8qKafg','Ly','Nguyen','2000-04-30','Female','0123456767'),
       ('lanhuong90','tzOG80wsEA','Huong','Pham','1990-10-05','Female','0123456766'),
       ('dogiang02','iJFtbEU7JT','Giang','Do','2002-07-23','Female','0123456765'),
       ('uyenvu01','HlmhoBZgLd','Uyen','Vu','2001-11-10','Female','0123456764'),
       ('khanhvieee','gWpNDLq09u','Vi','Nguyen','1997-10-22','Female','0123456763'),
       ('annn_ngg','fa29wNhprd','An','Nguyen','1989-09-28','Female','0123456762'),
       ('gigifam','7NxgtYCXjg','Ngan','Pham','1996-03-12','Female','0123456761'),
       ('minhtam2k3','LvmyxDVu5M','Tam','Trinh','2003-03-21','Female','0123456760'),
       ('annehath','HCt0TkLTra','Anne','Hathaway','1982-11-12','Female','0123456759'),
       ('hermione','O3gTW68EAh','Emma','Watson','1990-04-15','Female','0123456758'),
       ('chrisno1fan','ooKabyoaEY','Chris','Hemsworth','1983-08-11','Male','0123456757'),
       ('spooderman','gS6733AOrE','Tom','Holland','1996-06-01','Male','0123456756'),
       ('faizali413','aSI1jwre94','Faiz','Ali','1999-01-15','Male','0123456755'),
       ('galgadot94','zfPIvRUIaA','Gal','Gadot','1985-04-30','Female','0123456754'),
       ('ricegum','lXtFddHud3','Bryan','Le','1996-11-19','Male','0123456753'),
       ('theflash01','chf5DPZ8fH','Barry','Allem','1992-09-30','Male','0123456752'),
       ('selenagomez','hFxQ0df2A2','Selena','Gomez','1992-07-22','Male','0123456751'),
       ('billieee','gM9a9anZKh','Billie','Eilish','2001-12-18','Female','0123456750');

INSERT INTO reservations (cID, screentimeID,cineplexID,cinemaID, seatNumb, totalprice)
VALUES ('1','169','2','2','4','70000'),('1','169','2','2','5','70000'),('1','169','2','2','6','70000'),
       ('2','353','3','4','4','70000'),('2','353','3','4','5','70000'),('2','353','3','4','6','70000'),('2','353','3','4','7','70000'),
       ('3','47','1','1','7','70000'),
       ('4','414','3','4','3','70000'),('4','414','3','4','4','70000'),
       ('5','215','2','1','1','70000'),('5','215','2','1','2','70000'),('5','215','2','1','3','70000'),('5','215','2','1','4','70000'),('5','215','2','1','5','70000'),
       ('6','1','1','1','6','70000'),('6','1','1','1','7','70000'),('6','1','1','1','8','70000'),
       ('7','261','2','4','11','70000'),('7','261','2','4','12','70000'),
       ('8','112','2','2','5','70000'),('8','112','2','2','6','70000'),('8','112','2','2','7','70000'),
       ('9','117','2','3','11','70000'),('9','117','2','3','12','70000'),
       ('10','202','2','3','5','70000'),('10','202','2','3','6','70000'),
       ('11','69','1','2','10','70000'),('11','69','1','2','11','70000'),('11','69','1','2','12','70000'),('11','69','1','2','13','70000'),
       ('12','389','3','3','5','70000'),
       ('13','339','3','1','9','70000'),('13','339','3','1','10','70000'),('13','339','3','1','11','70000'),
       ('14','277','2','2','4','70000'),('14','277','2','2','5','70000'),
       ('15','200','2','3','1','70000'),('15','200','2','3','2','70000'),('15','200','2','3','3','70000'),
       ('16','165','2','1','4','70000'),('16','165','2','1','5','70000'),
       ('17','25','1','2','7','70000'),('17','25','1','2','8','70000'),
       ('18','30','1','3','10','70000'),
       ('19','47','1','1','1','70000'),('19','47','1','1','2','70000'),
       ('20','353','3','4','3','70000'),('20','353','3','4','4','70000'),('20','353','3','4','5','70000'),('20','353','3','4','6','70000'),
       ('21','434','3','4','5','70000'),
       ('22','202','2','3','3','70000'),('22','202','2','3','4','70000'),
       ('23','217','2','1','11','70000'),('23','217','2','1','12','70000'),
       ('24','234','2','4','2','70000'),('24','234','2','4','3','70000'),('24','234','2','4','4','70000'),('24','234','2','4','5','70000'),
       ('25','333','3','4','3','70000'),
       ('26','401','3','2','6','70000'),('26','401','3','2','7','70000'),
       ('27','384','3','2','8','70000'),('27','384','3','2','9','70000'),('27','384','3','2','10','70000'),
       ('28','180','2','4','15','70000'),
       ('29','30','1','3','1','70000'),
       ('30','10','1','2','14','70000'),('30','10','1','2','15','70000'),
       ('31','41','1','3','8','70000'),
       ('32','170','2','2','9','70000'),('32','170','2','2','10','70000'),
       ('33','195','2','2','1','70000'),
       ('34','213','2','5','6','70000'),('34','213','2','5','7','70000'),('34','213','2','5','8','70000'),
       ('35','256','2','3','11','70000'),('35','256','2','3','12','70000'),
       ('36','310','3','4','4','70000'),
       ('37','157','2','5','3','70000'),('37','157','2','5','4','70000'),('37','157','2','5','5','70000'),
       ('38','180','2','4','5','70000'),('38','180','2','4','6','70000'),('38','180','2','4','7','70000'),
       ('39','201','2','3','6','70000'),
       ('40','74','1','3','4','70000'),('40','74','1','3','5','70000'),('40','74','1','3','6','70000');

INSERT INTO fborder (cID, cineplexID, itemID, date)
VALUES ('1','2','2','2021-09-03'),('1','2','3','2021-09-03'),('1','2','5','2021-09-03'),('1','2','5','2021-09-03'),
       ('15','2','1','2021-09-04'),('15','2','4','2021-09-04'),
       ('21','3','1','2021-09-07'),('21','3','6','2021-09-07'),
       ('27','3','1','2021-09-05'),('27','3','4','2021-09-05'),('27','3','5','2021-09-05'),
       ('32','2','1','2021-09-03'),('32','2','5','2021-09-05'),
       ('7','2','3','2021-09-06'),('31','2','4','2021-09-06'),
       ('39','2','5','2021-09-04'),
       ('40','1','2','2021-09-05'),('40','1','4','2021-09-05'),('40','1','5','2021-09-09'),
       ('18','1','2','2021-09-02'),('18','1','4','2021-09-02'),
       ('24','2','2','2021-09-05'),('24','2','3','2021-09-05'),('24','2','4','2021-09-05'),('24','2','5','2021-09-05');

INSERT INTO admininfo ( adminName, aUsername, aPassword)
VALUES ('Duc Trinh','admin1','adminpw1'),
       ('Truong Nguyen','admin2','adminpw2'),
       ('An Vuong','admin3','adminpw3'),
       ('Minh Nguyen','admin4','adminpw4');

COMMIT;
SET FOREIGN_KEY_CHECKS = 1;
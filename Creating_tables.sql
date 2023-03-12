CREATE TABLE books (
	bookID int NOT NULL AUTO_INCREMENT,
	title varchar(255) NOT NULL,
	author_firstName varchar(100) DEFAULT NULL,
	author_lastName varchar(100) NOT NULL,
	ISBN varchar(13) NOT NULL,
	publisher varchar(100) DEFAULT NULL,
	is_available boolean DEFAULT TRUE,
	pages int DEFAULT NULL,
	genre varchar(150) DEFAULT "unknown",
	PRIMARY KEY (bookID)
);

CREATE TABLE users (
	userID int NOT NULL AUTO_INCREMENT,
	user_firstName varchar(100) NOT NULL,
	user_lastName varchar(100) NOT NULL,
	is_student boolean NOT NULL DEFAULT TRUE,
	PRIMARY KEY (userID)
);

CREATE TABLE accounts (
	accountID int NOT NULL AUTO_INCREMENT,
	email varchar(100) NOT NULL,
	password varchar(100) NOT NULL,
	userID int NOT NULL,
	no_borrowed_books int DEFAULT 0,
	no_returned_books int DEFAULT 0,
	PRIMARY KEY (accountID),
    FOREIGN KEY (userID) REFERENCES users(userID)
);

CREATE TABLE staff (
	staffID int NOT NULL AUTO_INCREMENT,
	staff_firstName varchar(100) NOT NULL,
	staff_lastName varchar(100) NOT NULL,
	email varchar(100) NOT NULL,
	password varchar(100) NOT NULL,
	PRIMARY KEY (staffID)
);

CREATE TABLE checkout (
	borrowID int NOT NULL AUTO_INCREMENT,
	borrow_date timestamp DEFAULT CURRENT_TIMESTAMP,
	accountID int NOT NULL,
	bookID int NOT NULL,
	workerID int NOT NULL,
	return_day datetime DEFAULT ((now() + interval 14 day)),
	PRIMARY KEY (borrowID),
	FOREIGN KEY (accountID) REFERENCES accounts(accountID),
	FOREIGN KEY (bookID) REFERENCES books(bookID),
	FOREIGN KEY (workerID) REFERENCES staff(staffID)
);

alter table checkout add return_day datetime default (current_timestamp + interval 14 day);

CREATE TABLE book_returns (
	returnID int NOT NULL AUTO_INCREMENT,
	return_date timestamp DEFAULT CURRENT_TIMESTAMP,
	accountID int NOT NULL,
	bookID int NOT NULL,
	workerID int NOT NULL,
	PRIMARY KEY (returnID),
	FOREIGN KEY (accountID) REFERENCES accounts(accountID),
	FOREIGN KEY (bookID) REFERENCES books(bookID),
	FOREIGN KEY (workerID) REFERENCES staff(staffID)
);
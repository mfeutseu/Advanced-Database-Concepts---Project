drop TABLE G4_BookFormats; 
drop TABLE G4_BookConditions;
drop TABLE G4_MemberTypes;

DROP TABLE G4_Reservations;
DROP TABLE G4_Orders;
DROP TABLE G4_Transactions;
DROP TABLE G4_Users;
DROP TABLE G4_Books;
DROP TABLE G4_Publishers;
DROP TABLE G4_Authors;
DROP TABLE G4_Categories;

CREATE TABLE G4_BookFormats (
    FormatID INT PRIMARY KEY,
    FormatName VARCHAR(50) NOT NULL
);

CREATE TABLE G4_BookConditions (
    ConditionID INT PRIMARY KEY,
    ConditionName VARCHAR(50) NOT NULL
);

CREATE TABLE G4_MemberTypes (
    MemberTypeID INT PRIMARY KEY,
    MemberTypeName VARCHAR(50) NOT NULL
);

-- Create the G4_Categories table
CREATE TABLE G4_Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL
);

-- Create the G4_Authors table
CREATE TABLE G4_Authors (
    AuthorID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Biography VARCHAR(250) NOT NULL
);


CREATE TABLE G4_Publishers (
    PublisherID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Address VARCHAR(255),
    PhoneNumber VARCHAR(10),
    Email VARCHAR(255)
);

-- Create the G4_Books table
CREATE TABLE G4_Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    AuthorID INT NOT NULL,
    PublisherID INT NOT NULL,
    CategoryID INT NOT NULL,
    ISBN VARCHAR(13) NOT NULL UNIQUE,
    NumPages INT,
    YearPublished INT,
    AvailabilityStatus VARCHAR(20) DEFAULT 'Available',
    FormatID INT, -- New column for G4_BookFormats
    ConditionID INT, -- New column for G4_BookConditions
    FOREIGN KEY (AuthorID) REFERENCES G4_Authors(AuthorID),
    FOREIGN KEY (PublisherID) REFERENCES G4_Publishers(PublisherID),
    FOREIGN KEY (CategoryID) REFERENCES G4_Categories(CategoryID),
    FOREIGN KEY (FormatID) REFERENCES G4_BookFormats(FormatID), -- Foreign key constraint for G4_BookFormats
    FOREIGN KEY (ConditionID) REFERENCES G4_BookConditions(ConditionID) -- Foreign key constraint for G4_BookConditions
);


CREATE TABLE G4_Users (
    UserID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Address VARCHAR(255),
    PhoneNumber VARCHAR(20),
    Email VARCHAR(255) UNIQUE,
    MemberTypeID INT NOT NULL,
    FOREIGN KEY (MemberTypeID) REFERENCES G4_MemberTypes(MemberTypeID)
);


-- Create the G4_Transactions table
CREATE TABLE G4_Transactions (
    TransactionID INT PRIMARY KEY,
    BookID INT NOT NULL,
    UserID INT NOT NULL,
    CheckoutDate DATE NOT NULL,
    DueDate DATE NOT NULL,
    ReturnDate DATE,
    FOREIGN KEY (BookID) REFERENCES G4_Books(BookID),
    FOREIGN KEY (UserID) REFERENCES G4_Users(UserID)
);

-- Create the G4_Orders table
CREATE TABLE G4_Orders (
    OrderID INT PRIMARY KEY,
    BookID INT NOT NULL,
    PublisherID INT NOT NULL,
    OrderDate DATE NOT NULL,
    FOREIGN KEY (BookID) REFERENCES G4_Books(BookID),
    FOREIGN KEY (PublisherID) REFERENCES G4_Publishers(PublisherID)
);

-- Create the G4_Reservations table
CREATE TABLE G4_Reservations (
    ReservationID INT PRIMARY KEY,
    UserID INT NOT NULL,
    BookID INT NOT NULL,
    ReservationDate DATE NOT NULL,
    FOREIGN KEY (UserID) REFERENCES G4_Users(UserID),
    FOREIGN KEY (BookID) REFERENCES G4_Books(BookID)
);

-- Everything About Sequence
Drop Sequence G4_Books_Seq;
Drop Sequence G4_Users_Seq;
Drop Sequence G4_Transactions_Seq;
Drop Sequence G4_Publishers_Seq;
Drop Sequence G4_Orders_Seq;
Drop Sequence G4_Authors_Seq;
Drop Sequence G4_Reservations_Seq;
Drop Sequence G4_Categories_Seq;

-- Create a sequence for G4_Books
CREATE SEQUENCE G4_Books_Seq
START WITH 80
INCREMENT BY 1
NOCACHE
NOCYCLE;


-- Create a sequence for G4_Users
CREATE SEQUENCE G4_Users_Seq
START WITH 1600
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Create a sequence for G4_Transactions
CREATE SEQUENCE G4_Transactions_Seq
START WITH 3150
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Create a sequence for G4_Publishers
CREATE SEQUENCE G4_Publishers_Seq
START WITH 1050
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Create a sequence for G4_Orders
CREATE SEQUENCE G4_Orders_Seq
START WITH 5200
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Create a sequence for G4_Authors
CREATE SEQUENCE G4_Authors_Seq
START WITH 700
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Create a sequence for G4_Reservations
CREATE SEQUENCE G4_Reservations_Seq
START WITH 180
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Create a sequence for G4_Categories
CREATE SEQUENCE G4_Categories_Seq
START WITH 800
INCREMENT BY 1
NOCACHE
NOCYCLE;


----------------- Inserting data -----

-- G4_BookFormats table
  INSERT INTO G4_BookFormats (FormatID, FormatName) VALUES (1, 'Hardcover');
  INSERT INTO G4_BookFormats (FormatID, FormatName) VALUES (2, 'Paperback');
  INSERT INTO G4_BookFormats (FormatID, FormatName) VALUES (3, 'Audiobook');
  INSERT INTO G4_BookFormats (FormatID, FormatName) VALUES (4, 'eBook');
  INSERT INTO G4_BookFormats (FormatID, FormatName) VALUES (5, 'Large Print');

-- G4_BookConditions;
INSERT INTO G4_BookConditions (ConditionID, ConditionName) VALUES (1, 'New');
INSERT INTO G4_BookConditions (ConditionID, ConditionName) VALUES (2, 'Like New');
INSERT INTO G4_BookConditions (ConditionID, ConditionName) VALUES (3, 'Very Good');
INSERT INTO G4_BookConditions (ConditionID, ConditionName) VALUES (4, 'Good');
INSERT INTO G4_BookConditions (ConditionID, ConditionName) VALUES (5, 'Acceptable');


-- G4_MemberTypes;
INSERT INTO G4_MemberTypes (MemberTypeID, MemberTypeName) VALUES (1, 'Student');
INSERT INTO G4_MemberTypes (MemberTypeID, MemberTypeName) VALUES (2, 'Faculty');
INSERT INTO G4_MemberTypes (MemberTypeID, MemberTypeName) VALUES (3, 'Staff');
INSERT INTO G4_MemberTypes (MemberTypeID, MemberTypeName) VALUES (4, 'General Public');


-- G4_Categories
INSERT INTO G4_Categories (CategoryID, CategoryName) VALUES (G4_Categories_Seq.NEXTVAL, 'Science Fiction');
INSERT INTO G4_Categories (CategoryID, CategoryName) VALUES (G4_Categories_Seq.NEXTVAL, 'Mystery');
INSERT INTO G4_Categories (CategoryID, CategoryName) VALUES (G4_Categories_Seq.NEXTVAL, 'Romance');
INSERT INTO G4_Categories (CategoryID, CategoryName) VALUES (G4_Categories_Seq.NEXTVAL, 'Biography');
INSERT INTO G4_Categories (CategoryID, CategoryName) VALUES (G4_Categories_Seq.NEXTVAL, 'History');
INSERT INTO G4_Categories (CategoryID, CategoryName) VALUES (G4_Categories_Seq.NEXTVAL, 'Fantasy');
INSERT INTO G4_Categories (CategoryID, CategoryName) VALUES (G4_Categories_Seq.NEXTVAL, 'Thriller');
INSERT INTO G4_Categories (CategoryID, CategoryName) VALUES (G4_Categories_Seq.NEXTVAL, 'Self-help');
INSERT INTO G4_Categories (CategoryID, CategoryName) VALUES (G4_Categories_Seq.NEXTVAL, 'Children');
INSERT INTO G4_Categories (CategoryID, CategoryName) VALUES (G4_Categories_Seq.NEXTVAL, 'Young Adult');
   

-- G4_Authors
INSERT INTO G4_Authors (AuthorID, FirstName, LastName, Biography) VALUES (G4_Authors_Seq.NEXTVAL, 'John', 'Doe', 'John Doe is a fictional author.');
INSERT INTO G4_Authors (AuthorID, FirstName, LastName, Biography) VALUES (G4_Authors_Seq.NEXTVAL, 'Jane', 'Smith', 'Jane Smith is a well-known author in the mystery genre.');
INSERT INTO G4_Authors (AuthorID, FirstName, LastName, Biography) VALUES (G4_Authors_Seq.NEXTVAL, 'Michael', 'Johnson', 'Michael Johnson is a renowned science fiction writer.');
INSERT INTO G4_Authors (AuthorID, FirstName, LastName, Biography) VALUES (G4_Authors_Seq.NEXTVAL, 'Emily', 'Clark', 'Emily Clark is a popular romance novelist.');
INSERT INTO G4_Authors (AuthorID, FirstName, LastName, Biography) VALUES (G4_Authors_Seq.NEXTVAL, 'David', 'Brown', 'David Brown is a bestselling author of historical fiction.');
INSERT INTO G4_Authors (AuthorID, FirstName, LastName, Biography) VALUES (G4_Authors_Seq.NEXTVAL, 'Sarah', 'Taylor', 'Sarah Taylor writes captivating young adult novels.');
INSERT INTO G4_Authors (AuthorID, FirstName, LastName, Biography) VALUES (G4_Authors_Seq.NEXTVAL, 'James', 'Wilson', 'James Wilson is an award-winning author of literary fiction.');
INSERT INTO G4_Authors (AuthorID, FirstName, LastName, Biography) VALUES (G4_Authors_Seq.NEXTVAL, 'Jessica', 'Harris', 'Jessica Harris is known for her thrilling suspense novels.');
INSERT INTO G4_Authors (AuthorID, FirstName, LastName, Biography) VALUES (G4_Authors_Seq.NEXTVAL, 'Richard', 'White', 'Richard White is an influential author of nonfiction works.');
INSERT INTO G4_Authors (AuthorID, FirstName, LastName, Biography) VALUES (G4_Authors_Seq.NEXTVAL, 'Laura', 'Martin', 'Laura Martin is a talented children''s book author.');


-- G4_Publishers;
  INSERT INTO G4_Publishers (PublisherID, Name, Address, PhoneNumber, Email)
  VALUES (G4_Publishers_Seq.NEXTVAL, 'Penguin Books', '123 Main St', '555-1234', 'info@penguinbooks.com');
  
  INSERT INTO G4_Publishers (PublisherID, Name, Address, PhoneNumber, Email)
  VALUES (G4_Publishers_Seq.NEXTVAL, 'Random House', '456 Oak St', '555-5678', 'info@randomhouse.com');
  
  INSERT INTO G4_Publishers (PublisherID, Name, Address, PhoneNumber, Email)
  VALUES (G4_Publishers_Seq.NEXTVAL, 'HarperCollins', '789 Maple Ave', '555-9012', 'info@harpercollins.com');
  
  INSERT INTO G4_Publishers (PublisherID, Name, Address, PhoneNumber, Email)
  VALUES (G4_Publishers_Seq.NEXTVAL, 'Simon Schuster', '321 Elm St', '555-3456', 'info@simonandschuster.com');
  
  INSERT INTO G4_Publishers (PublisherID, Name, Address, PhoneNumber, Email)
  VALUES (G4_Publishers_Seq.NEXTVAL, 'Hachette Book Group', '654 Pine St', '555-7890', 'info@hachettebookgroup.com');
  
  INSERT INTO G4_Publishers (PublisherID, Name, Address, PhoneNumber, Email)
  VALUES (G4_Publishers_Seq.NEXTVAL, 'Macmillan Publishers', '987 Cedar Rd', '555-2345', 'info@macmillanpublishers.com');
  
  INSERT INTO G4_Publishers (PublisherID, Name, Address, PhoneNumber, Email)
  VALUES (G4_Publishers_Seq.NEXTVAL, 'Wiley', '246 Birch Ave', '555-6789', 'info@wiley.com');
  
  INSERT INTO G4_Publishers (PublisherID, Name, Address, PhoneNumber, Email)
  VALUES (G4_Publishers_Seq.NEXTVAL, 'Oxford University Press', '369 Ash St', '555-0123', 'info@oup.com');
  
  INSERT INTO G4_Publishers (PublisherID, Name, Address, PhoneNumber, Email)
  VALUES (G4_Publishers_Seq.NEXTVAL, 'Cambridge University Press', '802 Walnut St', '555-4567', 'info@cup.com');
  
  INSERT INTO G4_Publishers (PublisherID, Name, Address, PhoneNumber, Email)
  VALUES (G4_Publishers_Seq.NEXTVAL, 'Pearson Education', '1350 Oakwood Blvd', '555-8901', 'info@pearsoneducation.com');


-- G4_Users
INSERT INTO G4_Users (UserID, FirstName, LastName, Address, PhoneNumber, Email, MemberTypeID) VALUES
(G4_Users_Seq.nextval, 'John', 'Doe', '123 Main St', '555-1234', 'john.doe@email.com', 1);

INSERT INTO G4_Users (UserID, FirstName, LastName, Address, PhoneNumber, Email, MemberTypeID) VALUES
(G4_Users_Seq.nextval, 'Jane', 'Smith', '456 Oak St', '555-5678', 'jane.smith@email.com', 2);

INSERT INTO G4_Users (UserID, FirstName, LastName, Address, PhoneNumber, Email, MemberTypeID) VALUES
(G4_Users_Seq.nextval, 'Michael', 'Johnson', '789 Maple Ave', '555-9012', 'michael.johnson@email.com', 3);

INSERT INTO G4_Users (UserID, FirstName, LastName, Address, PhoneNumber, Email, MemberTypeID) VALUES
(G4_Users_Seq.nextval, 'Emily', 'Clark', '321 Elm St', '555-3456', 'emily.clark@email.com', 1);

INSERT INTO G4_Users (UserID, FirstName, LastName, Address, PhoneNumber, Email, MemberTypeID) VALUES
(G4_Users_Seq.nextval, 'David', 'Brown', '654 Pine St', '555-7890', 'david.brown@email.com', 2);

INSERT INTO G4_Users (UserID, FirstName, LastName, Address, PhoneNumber, Email, MemberTypeID) VALUES
(G4_Users_Seq.nextval, 'Sarah', 'Taylor', '987 Cedar Rd', '555-2345', 'sarah.taylor@email.com', 4);

INSERT INTO G4_Users (UserID, FirstName, LastName, Address, PhoneNumber, Email, MemberTypeID) VALUES
(G4_Users_Seq.nextval, 'James', 'Wilson', '246 Birch Ave', '555-6789', 'james.wilson@email.com', 1);

INSERT INTO G4_Users (UserID, FirstName, LastName, Address, PhoneNumber, Email, MemberTypeID) VALUES
(G4_Users_Seq.nextval, 'Jessica', 'Harris', '369 Ash St', '555-0123', 'jessica.harris@email.com', 2);

INSERT INTO G4_Users (UserID, FirstName, LastName, Address, PhoneNumber, Email, MemberTypeID) VALUES
(G4_Users_Seq.nextval, 'Richard', 'White', '802 Walnut St', '555-4567', 'richard.white@email.com', 3);

INSERT INTO G4_Users (UserID, FirstName, LastName, Address, PhoneNumber, Email, MemberTypeID) VALUES
(G4_Users_Seq.nextval, 'Laura', 'Martin', '1350 Oakwood Blvd', '555-8901', 'laura.martin@email.com', 3);


-- G4_Books;
  INSERT INTO G4_Books (BookID, Title, AuthorID, PublisherID, CategoryID, ISBN, NumPages, YearPublished, AvailabilityStatus, FormatID, ConditionID)
  VALUES (G4_Books_Seq.NEXTVAL, 'The Great Gatsby', 708, 1057, 808, '9780141182636', 180, 1925, 'Available', 1, 1);
  
  INSERT INTO G4_Books (BookID, Title, AuthorID, PublisherID, CategoryID, ISBN, NumPages, YearPublished, AvailabilityStatus, FormatID, ConditionID)
  VALUES (G4_Books_Seq.NEXTVAL, 'To Kill a Mockingbird', 709, 1058, 809, '9780446310789', 281, 1960, 'Available', 2, 2);
  
  INSERT INTO G4_Books (BookID, Title, AuthorID, PublisherID, CategoryID, ISBN, NumPages, YearPublished, AvailabilityStatus, FormatID, ConditionID)
  VALUES (G4_Books_Seq.NEXTVAL, '1984', 704, 1059, 800, '9780451524935', 328, 1949, 'Available', 3, 3);
  
  INSERT INTO G4_Books (BookID, Title, AuthorID, PublisherID, CategoryID, ISBN, NumPages, YearPublished, AvailabilityStatus, FormatID, ConditionID)
  VALUES (G4_Books_Seq.NEXTVAL, 'Pride and Prejudice', 700, 1050, 804, '9780141439518', 416, 1813, 'Available', 4, 4);
  
  INSERT INTO G4_Books (BookID, Title, AuthorID, PublisherID, CategoryID, ISBN, NumPages, YearPublished, AvailabilityStatus, FormatID, ConditionID)
  VALUES (G4_Books_Seq.NEXTVAL, 'Harry Potter and the Philosopher''s Stone', 708, 1051, 800, '9780747532743', 223, 1997, 'Available', 5, 5);
  
  INSERT INTO G4_Books (BookID, Title, AuthorID, PublisherID, CategoryID, ISBN, NumPages, YearPublished, AvailabilityStatus, FormatID, ConditionID)
  VALUES (G4_Books_Seq.NEXTVAL, 'The Lord of the Rings', 708, 1054, 805, '9780618640157', 1178, 1954, 'Available', 1, 2);
  
  INSERT INTO G4_Books (BookID, Title, AuthorID, PublisherID, CategoryID, ISBN, NumPages, YearPublished, AvailabilityStatus, FormatID, ConditionID)
  VALUES (G4_Books_Seq.NEXTVAL, 'The Hobbit', 700, 1053, 802, '9780261103344', 310, 1937, 'Available', 2, 3);
  
  INSERT INTO G4_Books (BookID, Title, AuthorID, PublisherID, CategoryID, ISBN, NumPages, YearPublished, AvailabilityStatus, FormatID, ConditionID)
  VALUES (G4_Books_Seq.NEXTVAL, 'The Catcher in the Rye', 704, 1057, 801, '9780316769174', 277, 1951, 'Available', 3, 1);


-- G4_Reservations
  INSERT INTO G4_Reservations (ReservationID, UserID, BookID, ReservationDate)
  VALUES (G4_Reservations_Seq.NEXTVAL, 1601, 80, TO_DATE('2023-04-09', 'YYYY-MM-DD'));
  INSERT INTO G4_Reservations (ReservationID, UserID, BookID, ReservationDate)
  VALUES (G4_Reservations_Seq.NEXTVAL, 1602, 81, TO_DATE('2023-04-09', 'YYYY-MM-DD'));
  INSERT INTO G4_Reservations (ReservationID, UserID, BookID, ReservationDate)
  VALUES (G4_Reservations_Seq.NEXTVAL, 1603, 88, TO_DATE('2023-04-09', 'YYYY-MM-DD'));
  INSERT INTO G4_Reservations (ReservationID, UserID, BookID, ReservationDate)
  VALUES (G4_Reservations_Seq.NEXTVAL, 1604, 88, TO_DATE('2023-04-09', 'YYYY-MM-DD'));
  INSERT INTO G4_Reservations (ReservationID, UserID, BookID, ReservationDate)
  VALUES (G4_Reservations_Seq.NEXTVAL, 1605, 91, TO_DATE('2023-04-09', 'YYYY-MM-DD'));
  INSERT INTO G4_Reservations (ReservationID, UserID, BookID, ReservationDate)
  VALUES (G4_Reservations_Seq.NEXTVAL, 1609, 93, TO_DATE('2023-04-10', 'YYYY-MM-DD'));
  INSERT INTO G4_Reservations (ReservationID, UserID, BookID, ReservationDate)
  VALUES (G4_Reservations_Seq.NEXTVAL, 1602, 94, TO_DATE('2023-04-10', 'YYYY-MM-DD'));
  INSERT INTO G4_Reservations (ReservationID, UserID, BookID, ReservationDate)
  VALUES (G4_Reservations_Seq.NEXTVAL, 1603, 97, TO_DATE('2023-04-10', 'YYYY-MM-DD'));
  INSERT INTO G4_Reservations (ReservationID, UserID, BookID, ReservationDate)
  VALUES (G4_Reservations_Seq.NEXTVAL, 1604, 88, TO_DATE('2023-04-10', 'YYYY-MM-DD'));
  INSERT INTO G4_Reservations (ReservationID, UserID, BookID, ReservationDate)
  VALUES (G4_Reservations_Seq.NEXTVAL, 1608, 89, TO_DATE('2023-04-10', 'YYYY-MM-DD'));



--  G4_Orders;
INSERT INTO G4_Orders (OrderID, BookID, PublisherID, OrderDate)
VALUES (G4_Orders_Seq.NEXTVAL, 80, 1050, TO_DATE('2023-04-09', 'YYYY-MM-DD'));

INSERT INTO G4_Orders (OrderID, BookID, PublisherID, OrderDate)
VALUES (G4_Orders_Seq.NEXTVAL, 81, 1051, TO_DATE('2023-04-09', 'YYYY-MM-DD'));

INSERT INTO G4_Orders (OrderID, BookID, PublisherID, OrderDate)
VALUES (G4_Orders_Seq.NEXTVAL, 88, 1059, TO_DATE('2023-04-09', 'YYYY-MM-DD'));

INSERT INTO G4_Orders (OrderID, BookID, PublisherID, OrderDate)
VALUES (G4_Orders_Seq.NEXTVAL, 89, 1054, TO_DATE('2023-04-09', 'YYYY-MM-DD'));

INSERT INTO G4_Orders (OrderID, BookID, PublisherID, OrderDate)
VALUES (G4_Orders_Seq.NEXTVAL, 91, 1055, TO_DATE('2023-04-09', 'YYYY-MM-DD'));

INSERT INTO G4_Orders (OrderID, BookID, PublisherID, OrderDate)
VALUES (G4_Orders_Seq.NEXTVAL, 93, 1052, TO_DATE('2023-04-10', 'YYYY-MM-DD'));

INSERT INTO G4_Orders (OrderID, BookID, PublisherID, OrderDate)
VALUES (G4_Orders_Seq.NEXTVAL, 94, 1059, TO_DATE('2023-04-10', 'YYYY-MM-DD'));

INSERT INTO G4_Orders (OrderID, BookID, PublisherID, OrderDate)
VALUES (G4_Orders_Seq.NEXTVAL, 97, 1057, TO_DATE('2023-04-10', 'YYYY-MM-DD'));

INSERT INTO G4_Orders (OrderID, BookID, PublisherID, OrderDate)
VALUES (G4_Orders_Seq.NEXTVAL, 88, 1050, TO_DATE('2023-04-10', 'YYYY-MM-DD'));

INSERT INTO G4_Orders (OrderID, BookID, PublisherID, OrderDate)
VALUES (G4_Orders_Seq.NEXTVAL, 81, 1052, TO_DATE('2023-04-10', 'YYYY-MM-DD'));


-- G4_Transactions
INSERT INTO G4_Transactions (TransactionID, BookID, UserID, CheckoutDate, DueDate)
VALUES (G4_Transactions_Seq.NEXTVAL, 80, 1600, TO_DATE('2023-04-09', 'YYYY-MM-DD'), TO_DATE('2023-04-16', 'YYYY-MM-DD'));

INSERT INTO G4_Transactions (TransactionID, BookID, UserID, CheckoutDate, DueDate)
VALUES (G4_Transactions_Seq.NEXTVAL, 81, 1601, TO_DATE('2023-04-09', 'YYYY-MM-DD'), TO_DATE('2023-04-16', 'YYYY-MM-DD'));

INSERT INTO G4_Transactions (TransactionID, BookID, UserID, CheckoutDate, DueDate)
VALUES (G4_Transactions_Seq.NEXTVAL, 88, 1603, TO_DATE('2023-04-09', 'YYYY-MM-DD'), TO_DATE('2023-04-16', 'YYYY-MM-DD'));

INSERT INTO G4_Transactions (TransactionID, BookID, UserID, CheckoutDate, DueDate)
VALUES (G4_Transactions_Seq.NEXTVAL, 91, 1602, TO_DATE('2023-04-09', 'YYYY-MM-DD'), TO_DATE('2023-04-16', 'YYYY-MM-DD'));

INSERT INTO G4_Transactions (TransactionID, BookID, UserID, CheckoutDate, DueDate)
VALUES (G4_Transactions_Seq.NEXTVAL, 94, 1609, TO_DATE('2023-04-09', 'YYYY-MM-DD'), TO_DATE('2023-04-16', 'YYYY-MM-DD'));

INSERT INTO G4_Transactions (TransactionID, BookID, UserID, CheckoutDate, DueDate)
VALUES (G4_Transactions_Seq.NEXTVAL, 97, 1607, TO_DATE('2023-04-10', 'YYYY-MM-DD'), TO_DATE('2023-04-17', 'YYYY-MM-DD'));

INSERT INTO G4_Transactions (TransactionID, BookID, UserID, CheckoutDate, DueDate)
VALUES (G4_Transactions_Seq.NEXTVAL, 89, 1605, TO_DATE('2023-04-10', 'YYYY-MM-DD'), TO_DATE('2023-04-17', 'YYYY-MM-DD'));

INSERT INTO G4_Transactions (TransactionID, BookID, UserID, CheckoutDate, DueDate)
VALUES (G4_Transactions_Seq.NEXTVAL, 93, 1604, TO_DATE('2023-04-10', 'YYYY-MM-DD'), TO_DATE('2023-04-17', 'YYYY-MM-DD'));

INSERT INTO G4_Transactions (TransactionID, BookID, UserID, CheckoutDate, DueDate)
VALUES (G4_Transactions_Seq.NEXTVAL, 91, 1608, TO_DATE('2023-04-10', 'YYYY-MM-DD'), TO_DATE('2023-04-17', 'YYYY-MM-DD'));

INSERT INTO G4_Transactions (TransactionID, BookID, UserID, CheckoutDate, DueDate)
VALUES (G4_Transactions_Seq.NEXTVAL, 80, 1601, TO_DATE('2023-04-10', 'YYYY-MM-DD'), TO_DATE('2023-04-17', 'YYYY-MM-DD'));


DROP INDEX idx_g4_books_title;
DROP INDEX idx_g4_books_authorid;
DROP INDEX idx_g4_books_categoryid;
DROP INDEX idx_g4_users_firstname;
DROP INDEX idx_g4_users_lastname;
DROP INDEX idx_g4_publishers_name;
DROP INDEX idx_g4_authors_firstname;
DROP INDEX idx_g4_authors_lastname;


-- G4_Books table - indexes on Title, AuthorID, CategoryID, and ISBN:
CREATE INDEX idx_g4_books_title ON G4_Books(Title);
CREATE INDEX idx_g4_books_authorid ON G4_Books(AuthorID);
CREATE INDEX idx_g4_books_categoryid ON G4_Books(CategoryID);


-- G4_Users table: indexes on FirstName, LastName, and Email
CREATE INDEX idx_g4_users_firstname ON G4_Users(FirstName);
CREATE INDEX idx_g4_users_lastname ON G4_Users(LastName);


-- G4_Publishers table: index on Name
CREATE INDEX idx_g4_publishers_name ON G4_Publishers(Name);

-- G4_Authors table: indexes on FirstName and LastName
CREATE INDEX idx_g4_authors_firstname ON G4_Authors(FirstName);
CREATE INDEX idx_g4_authors_lastname ON G4_Authors(LastName);


-- TRIGGERS ------------------

-- trg_g4_transactions_before_insert - A trigger that automatically sets the DueDate when a new transaction is created
CREATE OR REPLACE TRIGGER trg_g4_trans_before_insert
BEFORE INSERT ON G4_Transactions
FOR EACH ROW
BEGIN
  :NEW.DueDate := :NEW.CheckoutDate + 14;
END;

-- trg_g4_books_after_update: A trigger that sets the AvailabilityStatus of a book to 'Unavailable' when a new transaction is inserted.
CREATE OR REPLACE TRIGGER trg_g4_books_after_update
AFTER INSERT ON G4_Transactions
FOR EACH ROW
BEGIN
  UPDATE G4_Books
  SET AvailabilityStatus = 'Unavailable'
  WHERE BookID = :NEW.BookID;
END;

-- trg_g4_books_after_return: A trigger that sets the AvailabilityStatus of a book to 'Available' when the book is returned, i.e., when the ReturnDate of a transaction is updated.
CREATE OR REPLACE TRIGGER trg_g4_books_after_return
AFTER UPDATE ON G4_Transactions
FOR EACH ROW
BEGIN
  IF :OLD.ReturnDate IS NULL AND :NEW.ReturnDate IS NOT NULL THEN
    UPDATE G4_Books
    SET AvailabilityStatus = 'Available'
    WHERE BookID = :NEW.BookID;
  END IF;
END;

-- testing trg_g4_trans_before_insert  trigger
INSERT INTO G4_Transactions (TransactionID, BookID, UserID, CheckoutDate, DueDate)
VALUES (G4_Transactions_Seq.NEXTVAL, 88, 1608, TO_DATE('2023-04-08', 'YYYY-MM-DD'), TO_DATE('2023-04-17', 'YYYY-MM-DD'));

-- testing trg_g4_books_after_update trigger - Make sure that bookid 88 is set to 'Unavailable'
SELECT * from G4_books where bookid = 88;

-- Testing trg_g4_books_after_return triiger - 
UPDATE G4_Transactions set returndate = TO_DATE('2023-04-15', 'YYYY-MM-DD') where transactionid = 3160; 
SELECT * from G4_books where bookid = 88;



--- Procedures ---------

-- Procedure that inserts a new user into the G4_Users table
CREATE OR REPLACE PROCEDURE insert_user(
    p_first_name IN VARCHAR2,
    p_last_name IN VARCHAR2,
    p_address IN VARCHAR2,
    p_phone_number IN VARCHAR2,
    p_email IN VARCHAR2,
    p_member_type_id IN INT
)
IS
    v_user_id INT;
BEGIN
    SELECT G4_Users_Seq.NEXTVAL INTO v_user_id FROM DUAL;
    INSERT INTO G4_Users (UserID, FirstName, LastName, Address, PhoneNumber, Email, MemberTypeID)
    VALUES (v_user_id, p_first_name, p_last_name, p_address, p_phone_number, p_email, p_member_type_id);
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('User inserted successfully');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;


-- Testing insetion of a new user using insert_user procedure
BEGIN
  insert_user('John', 'Doe', '123 Main St', '555-1234', 'johndoe@example.com', 1);
END;


---  procedure to delete all reservations for a given user
CREATE OR REPLACE PROCEDURE delete_reservations_for_user(
    p_user_id IN INT
)
IS
BEGIN
    DELETE FROM G4_Reservations WHERE UserID = p_user_id;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Reservations for user ' || p_user_id || ' deleted successfully');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

-- testing 
BEGIN
  delete_reservations_for_user(1601);
END;



-- Procedure that update the due date for a transaction

CREATE OR REPLACE PROCEDURE update_transaction_due_date(
    p_transaction_id IN INT,
    p_new_due_date IN DATE
)
IS
BEGIN
    UPDATE G4_Transactions
    SET DueDate = p_new_due_date
    WHERE TransactionID = p_transaction_id;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Transaction due date updated successfully');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: No transaction found with ID ' || p_transaction_id);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

-- testing update_transaction_due_date procedure
DECLARE
  v_transaction_id G4_Transactions.TransactionID%TYPE := 3150;
  v_new_due_date DATE := TO_DATE('2023-04-23', 'YYYY-MM-DD');
BEGIN
  update_transaction_due_date(v_transaction_id, v_new_due_date);
  DBMS_OUTPUT.PUT_LINE('Transaction due date updated successfully');
END;
/


------------------ Functions ------------------------------

-- Function to check if a user has any overdue books
CREATE OR REPLACE FUNCTION has_overdue_books(p_user_id IN INT)
RETURN BOOLEAN
IS
    v_count INT;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM G4_Transactions
    WHERE UserID = p_user_id
    AND DueDate < SYSDATE
    AND ReturnDate IS NULL;

    IF v_count > 0 THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: No user found for UserID ' || p_user_id);
        RETURN NULL;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RETURN NULL;
END;
/


-- testing has_overdue_books function
UPDATE G4_TRANSACTIONS SET RETURNDATE = TO_DATE('2023-04-26', 'YYYY-MM-DD') WHERE transactionid = 3157;

UPDATE G4_TRANSACTIONS SET CHECKOUTDATE = TO_DATE('2023-05-02', 'YYYY-MM-DD'), DUEDATE = TO_DATE('2023-04-03', 'YYYY-MM-DD') WHERE transactionid = 3155;


DECLARE
  v_user_id INT := 1607; -- 1600
BEGIN
  IF has_overdue_books(v_user_id) THEN
    DBMS_OUTPUT.PUT_LINE('User ' || v_user_id || ' has overdue books');
  ELSE
    DBMS_OUTPUT.PUT_LINE('User ' || v_user_id || ' does not have overdue books');
  END IF;
END;


--- Function to retrieve the total number of books published by a publisher

CREATE OR REPLACE FUNCTION get_publisher_book_count(p_publisher_id IN INT)
RETURN INT
IS
    v_count INT;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM G4_Books
    WHERE PublisherID = p_publisher_id;

    RETURN v_count;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: No publisher found for PublisherID ' || p_publisher_id);
        RETURN NULL;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RETURN NULL;
END;
/
-- test get_publisher_book_count function
SELECT get_publisher_book_count(1057) FROM dual;

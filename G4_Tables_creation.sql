drop TABLE G4_Reservations;
drop TABLE G4_Transactions;
drop TABLE G4_Users;
drop TABLE G4_Orders;
drop TABLE G4_Books;
drop TABLE G4_Publishers;
drop TABLE G4_Authors;
drop TABLE G4_Categories;

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
    AvailabilityStatus VARCHAR(20) DEFAULT 'Available'
);


CREATE TABLE G4_Users (
    UserID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Address VARCHAR(255),
    PhoneNumber VARCHAR(20),
    Email VARCHAR(255) UNIQUE
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


CREATE TABLE G4_Publishers (
    PublisherID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Address VARCHAR(255),
    PhoneNumber VARCHAR(10),
    Email VARCHAR(255)
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

-- Create the G4_Authors table
CREATE TABLE G4_Authors (
    AuthorID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Biography VARCHAR(250) NOT NULL
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




-- Create the G4_Categories table
CREATE TABLE G4_Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL
);


ALTER TABLE G4_Books
ADD CONSTRAINT FK_G4_Books_Category
FOREIGN KEY (CategoryID)
REFERENCES G4_Categories(CategoryID);

ALTER TABLE G4_Books
ADD CONSTRAINT FK_G4_Books_Author
FOREIGN KEY (AuthorID)
REFERENCES G4_Authors(AuthorID);


ALTER TABLE G4_Books
ADD CONSTRAINT FK_G4_Books_Publisher
FOREIGN KEY (PublisherID)
REFERENCES G4_Publishers(PublisherID);
----------------------------------------------------------------------------------------------


--inserting table manually(To creat parent key). This need to be in order
INSERT INTO G4_Categories
VALUES (764,'Bildungsroman genre');

INSERT INTO G4_Publishers
VALUES (1000, 'Mark Avito', '543 Charles Street', '6478858885', 'Mark.Avito@email');

INSERT INTO G4_Users
VALUES (1564,'Roland', 'Baja', '123 main street', 6474708463, 'rbja@email.com');

INSERT INTO G4_Authors
VALUES (619,'Mark', 'Avito','Biography Cup in a Mug book');

INSERT INTO G4_Books
VALUES (55,'Cup in a Mug',619,1000,764,'8211108',300, 1997, Default);

INSERT INTO G4_Orders
VALUES (5123,55,1000, TO_Date('2022/08/01'));

INSERT INTO G4_Reservations
VALUES (150,1564, 55, TO_Date('2022/07/01'));

INSERT INTO G4_Transactions
VALUES (3097,55, 1564, TO_Date('2022/09/01'), TO_Date('2022/10/01'), TO_Date('2022/10/01'));
----------------------------------------------------------------------------------------------
-- Everything About Sequence
Drop Sequence G4_Books_Seq;
Drop Sequence G4_Users_Seq;
Drop Sequence G4_Transactions_Seq;
Drop Sequence G4_Publishers_Seq;
Drop Sequence G4_Orders_Seq;
Drop Sequence G4_Authors_Seq;
Drop Sequence G4_Reservations_Seq;
Drop Sequence G4_Categories_Seq;
Drop Sequence G4_ISBN_Seq;
Drop Sequence OrderID_Seq;
Drop Sequence Reservation_Seq;


---  Sequences ------------

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

-- Create a sequence for ISBN
CREATE SEQUENCE G4_ISBN_Seq
START WITH 8211325
INCREMENT BY 1
NOCACHE
NOCYCLE;
-- Create a sequence for OrderID
CREATE SEQUENCE OrderID_Seq
START WITH 5200
INCREMENT BY 1
NOCACHE
NOCYCLE;

CREATE SEQUENCE Reservation_Seq
START WITH 175
INCREMENT BY 1
NOCACHE
NOCYCLE;


/*inserting data into the table through Sequence.
It need to be in order to work properly: It cannot be group by table
1st: G4_Categories
2nd: G4_Publishers
3rd: G4_Users
4th: G4_Authors
5th: g4_books
6th: G4_Orders
7th: G4_Reservations
8th: G4_Transactions*/


INSERT INTO G4_Categories
VALUES (G4_Categories_Seq.nextval,'Fiction');
INSERT INTO G4_Publishers
VALUES (G4_Publishers_Seq.nextval, 'Guy de Maupassant', '514 Maupposent Street', '6478858235', 'Guyde.Maupassant@email');
INSERT INTO G4_Users
VALUES (G4_Users_Seq.nextval,'Calvin', 'Klein', '872 Yonge Street', 6474751696, 'Calvin.Klein@email.com');
INSERT INTO G4_Authors
VALUES (G4_Authors_Seq.nextval,'Guy de', 'Maupassant','Author of a Womans Life book');
INSERT INTO g4_books
VALUES (G4_Books_Seq.nextval,'A Womans Life',G4_Authors_Seq.currval,G4_Publishers_Seq.currval,G4_Categories_Seq.currval,G4_ISBN_Seq.nextval,208, 1888, Default);
INSERT INTO G4_Orders
VALUES (OrderID_Seq.nextval,G4_Books_Seq.currval,G4_Publishers_Seq.currval, TO_Date('2022/08/01'));
INSERT INTO G4_Reservations
VALUES (Reservation_Seq.nextval ,G4_Users_Seq.currval, G4_Books_Seq.currval, TO_Date('2022/07/01'));
INSERT INTO G4_Transactions
VALUES (G4_Transactions_Seq.nextval,G4_Books_Seq.currval, G4_Users_Seq.currval, TO_Date('2022/09/01'), TO_Date('2022/10/01'), TO_Date('2022/10/01'));



INSERT INTO G4_Categories
VALUES (G4_Categories_Seq.nextval,'Biography');
INSERT INTO G4_Publishers
VALUES (G4_Publishers_Seq.nextval, 'Abul Fazl', '1613 Adeleid Ave', '6478858678', 'Abul.Fazl@email');
INSERT INTO G4_Users
VALUES (G4_Users_Seq.nextval,'Abra', 'Cadabra', '5123 Bloor Street', 6474757864, 'Abra.Cadabra@email.com');
INSERT INTO G4_Authors
VALUES (G4_Authors_Seq.nextval,'Abul', 'Fazl','Author of Akbarnama book');
INSERT INTO g4_books
VALUES (G4_Books_Seq.nextval,'Akbarnama',G4_Authors_Seq.currval,G4_Publishers_Seq.currval,G4_Categories_Seq.currval,G4_ISBN_Seq.nextval,167, 1902, Default);
INSERT INTO G4_Orders
VALUES (OrderID_Seq.nextval,G4_Books_Seq.currval,G4_Publishers_Seq.currval, TO_Date('2022/12/22'));
INSERT INTO G4_Reservations
VALUES (Reservation_Seq.nextval ,G4_Users_Seq.currval, G4_Books_Seq.currval, TO_Date('2022/11/22'));
INSERT INTO G4_Transactions
VALUES (G4_Transactions_Seq.nextval,G4_Books_Seq.currval, G4_Users_Seq.currval, TO_Date('2023/01/22'), TO_Date('2023/02/22'), TO_Date('2023/02/22'));



INSERT INTO G4_Categories
VALUES (G4_Categories_Seq.nextval,'Social genre');
INSERT INTO G4_Publishers
VALUES (G4_Publishers_Seq.nextval, 'Amrita Pritam', '5124 Morningside Park', '6478857679', 'Amrita.Pritam@email');
INSERT INTO G4_Users
VALUES (G4_Users_Seq.nextval,'Victoria', 'Secret', '211 Spadina Street', 6474715267, 'Victoria.Secret@email.com');
INSERT INTO G4_Authors
VALUES (G4_Authors_Seq.nextval,'Amrita', 'Pritam','Author of Pinjar book');
INSERT INTO g4_books
VALUES (G4_Books_Seq.nextval,'Pinjar',G4_Authors_Seq.currval,G4_Publishers_Seq.currval,G4_Categories_Seq.currval,G4_ISBN_Seq.nextval,112, 1950, Default);
INSERT INTO G4_Orders
VALUES (OrderID_Seq.nextval,G4_Books_Seq.currval,G4_Publishers_Seq.currval, TO_Date('2022/08/25'));
INSERT INTO G4_Reservations
VALUES (Reservation_Seq.nextval ,G4_Users_Seq.currval, G4_Books_Seq.currval, TO_Date('2022/07/25'));
INSERT INTO G4_Transactions
VALUES (G4_Transactions_Seq.nextval,G4_Books_Seq.currval, G4_Users_Seq.currval, TO_Date('2022/09/25'), TO_Date('2022/10/25'), TO_Date('2022/10/25'));



INSERT INTO G4_Categories
VALUES (G4_Categories_Seq.nextval,'Romance Novel');
INSERT INTO G4_Publishers
VALUES (G4_Publishers_Seq.nextval, 'Vikram Seth', '489 Finch Stree West', '6478857346', 'Vikram.Seth@email');
INSERT INTO G4_Users
VALUES (G4_Users_Seq.nextval,'Sesame', 'Sid', '522 Keele Street', 6474776431, 'Sesame.Sid@email.com');
INSERT INTO G4_Authors
VALUES (G4_Authors_Seq.nextval,'Vikram', 'Seth','Author of A Suitable Boy book');
INSERT INTO g4_books
VALUES (G4_Books_Seq.nextval,'A Suitable Boy',G4_Authors_Seq.currval,G4_Publishers_Seq.currval,G4_Categories_Seq.currval,G4_ISBN_Seq.nextval,1349, 1993, Default);
INSERT INTO G4_Orders
VALUES (OrderID_Seq.nextval,G4_Books_Seq.currval,G4_Publishers_Seq.currval, TO_Date('2023/03/08'));
INSERT INTO G4_Reservations
VALUES (Reservation_Seq.nextval ,G4_Users_Seq.currval, G4_Books_Seq.currval, TO_Date('2023/02/08'));
INSERT INTO G4_Transactions
VALUES (G4_Transactions_Seq.nextval,G4_Books_Seq.currval, G4_Users_Seq.currval, TO_Date('2023/04/08'), TO_Date('2023/05/08'), TO_Date('2023/05/08'));



INSERT INTO G4_Categories
VALUES (G4_Categories_Seq.nextval,'Historical Novel');
INSERT INTO G4_Publishers
VALUES (G4_Publishers_Seq.nextval, 'Charles Darwin', '769 Lawrence Ave East', '6478786455', 'Charles.Darwin@email');
INSERT INTO G4_Users
VALUES (G4_Users_Seq.nextval,'Wendy', 'Sandwich', '512 Kennedy Street', 6474347437, 'Wendy.Sandwich@email.com');
INSERT INTO G4_Authors
VALUES (G4_Authors_Seq.nextval,'Charles', 'Darwin','Author of A Tale of Two Cities book');
INSERT INTO g4_books
VALUES (G4_Books_Seq.nextval,'A Tale of Two Cities',G4_Authors_Seq.currval,G4_Publishers_Seq.currval,G4_Categories_Seq.currval,G4_ISBN_Seq.nextval,304, 1859, Default);
INSERT INTO G4_Orders
VALUES (OrderID_Seq.nextval,G4_Books_Seq.currval,G4_Publishers_Seq.currval, TO_Date('2023/04/02'));
INSERT INTO G4_Reservations
VALUES (Reservation_Seq.nextval ,G4_Users_Seq.currval, G4_Books_Seq.currval, TO_Date('2023/03/02'));
INSERT INTO G4_Transactions
VALUES (G4_Transactions_Seq.nextval,G4_Books_Seq.currval, G4_Users_Seq.currval, TO_Date('2023/04/02'), TO_Date('2023/05/02'), TO_Date('2023/05/02'));

-- INDEXES

-- G4_Books table - indexes on Title, AuthorID, CategoryID, and ISBN:
CREATE INDEX idx_g4_books_title ON G4_Books(Title);
CREATE INDEX idx_g4_books_authorid ON G4_Books(AuthorID);
CREATE INDEX idx_g4_books_categoryid ON G4_Books(CategoryID);
CREATE INDEX idx_g4_books_isbn ON G4_Books(ISBN);

-- G4_Users table: indexes on FirstName, LastName, and Email
CREATE INDEX idx_g4_users_firstname ON G4_Users(FirstName);
CREATE INDEX idx_g4_users_lastname ON G4_Users(LastName);
CREATE INDEX idx_g4_users_email ON G4_Users(Email);

-- G4_Publishers table: index on Name
CREATE INDEX idx_g4_publishers_name ON G4_Publishers(Name);

-- G4_Authors table: indexes on FirstName and LastName
CREATE INDEX idx_g4_authors_firstname ON G4_Authors(FirstName);
CREATE INDEX idx_g4_authors_lastname ON G4_Authors(LastName);

-- TRIGGERS

-- trg_g4_transactions_before_insert: A trigger that automatically sets the DueDate when a new transaction is created
DELIMITER //
CREATE TRIGGER trg_g4_transactions_before_insert
BEFORE INSERT ON G4_Transactions
FOR EACH ROW
BEGIN
  SET NEW.DueDate = DATE_ADD(NEW.CheckoutDate, INTERVAL 14 DAY);
END;
//
DELIMITER ;


-- trg_g4_books_after_update: A trigger that sets the AvailabilityStatus of a book to 'Unavailable' when a new transaction is inserted.
DELIMITER //
CREATE TRIGGER trg_g4_books_after_update
AFTER INSERT ON G4_Transactions
FOR EACH ROW
BEGIN
  UPDATE G4_Books
  SET AvailabilityStatus = 'Unavailable'
  WHERE BookID = NEW.BookID;
END;
//
DELIMITER ;

-- trg_g4_books_after_return: A trigger that sets the AvailabilityStatus of a book to 'Available' when the book is returned, i.e., when the ReturnDate of a transaction is updated.
DELIMITER //
CREATE TRIGGER trg_g4_books_after_return
AFTER UPDATE ON G4_Transactions
FOR EACH ROW
BEGIN
  IF OLD.ReturnDate IS NULL AND NEW.ReturnDate IS NOT NULL THEN
    UPDATE G4_Books
    SET AvailabilityStatus = 'Available'
    WHERE BookID = NEW.BookID;
  END IF;
END;
//
DELIMITER ;






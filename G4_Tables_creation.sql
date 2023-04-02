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
    PhoneNumber VARCHAR(20),
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

-- Create a sequence for G4_Books
CREATE SEQUENCE G4_Books_Seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Create a sequence for G4_Users
CREATE SEQUENCE G4_Users_Seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Create a sequence for G4_Transactions
CREATE SEQUENCE G4_Transactions_Seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Create a sequence for G4_Publishers
CREATE SEQUENCE G4_Publishers_Seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Create a sequence for G4_Orders
CREATE SEQUENCE G4_Orders_Seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Create a sequence for G4_Authors
CREATE SEQUENCE G4_Authors_Seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Create a sequence for G4_Reservations
CREATE SEQUENCE G4_Reservations_Seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Create a sequence for G4_Categories
CREATE SEQUENCE G4_Categories_Seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;
CREATE DATABASE LibraryManagement;
USE LibraryManagement;

-- 2. Create Account table
CREATE TABLE Account (
    AccountID INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL UNIQUE,
    Password NVARCHAR(255) NOT NULL,
    Email NVARCHAR(100) UNIQUE,
    PhoneNumber NVARCHAR(15) UNIQUE,
    Role INT CHECK (Role IN (0, 1)) DEFAULT 0 NOT NULL, -- 0 is admin, 1 is user
    CreatedDate DATE DEFAULT GETDATE(),
    Status NVARCHAR(20) CHECK (Status IN ('Active', 'Inactive', 'Banned')) DEFAULT 'Active',
    FullName NVARCHAR(100),
    Address NVARCHAR(MAX)
);
-- 3. Create Book table (assuming you have this table; modify as necessary)
CREATE TABLE Book (
    BookID INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(255) NOT NULL,
    Author NVARCHAR(100),
	Genre VARCHAR(100),
    ISBN NVARCHAR(50) UNIQUE,
    PublishedYear INT,
    CopiesAvailable INT DEFAULT 0
);

-- 4. Create Borrow table
CREATE TABLE Borrow (
    BorrowID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT,
    BookID INT,
    BorrowDate DATE DEFAULT GETDATE(),
    DueDate DATE,
    ReturnDate DATE,
    Status NVARCHAR(20) CHECK (Status IN ('Borrowed', 'Returned', 'Overdue')) DEFAULT 'Borrowed',
    FineAmount DECIMAL(10, 2) DEFAULT 0,
    FOREIGN KEY (UserID) REFERENCES Account(AccountID), -- Link to Account
    FOREIGN KEY (BookID) REFERENCES Book(BookID)
);

-- 6. Create Review table
CREATE TABLE Review (
    ReviewID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT,
    BookID INT,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment TEXT,
    ReviewDate DATE DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Account(AccountID),
    FOREIGN KEY (BookID) REFERENCES Book(BookID)
);

-- 8. Create Feedback table
CREATE TABLE Feedback (
    FeedbackID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT,
    FeedbackType NVARCHAR(20) CHECK (FeedbackType IN ('Book', 'Service', 'Other')),
    Content TEXT,
    FeedbackDate DATE DEFAULT GETDATE(),
    Status NVARCHAR(20) CHECK (Status IN ('Resolved', 'Unresolved')) DEFAULT 'Unresolved',
    FOREIGN KEY (UserID) REFERENCES Account(AccountID)
);
--Problem 1.	Create Database
CREATE DATABASE Minions

USE Minions
--Problem 2.	Create Tables
CREATE TABLE Minions (
	Id INT NOT NULL,
	[Name] NVARCHAR(50) NOT NULL,
	Age INT
)

CREATE TABLE Towns(
	Id INT NOT NULL,
	[Name] NVARCHAR(50) NOT NULL
)

ALTER TABLE Minions
ADD CONSTRAINT PK_Id
PRIMARY KEY(Id)

ALTER TABLE Towns
ADD CONSTRAINT PK_TownId
PRIMARY KEY(Id)


--Problem 3. Alter Minions Table
ALTER TABLE Minions
ADD TownId INT

ALTER TABLE Minions
ADD CONSTRAINT FK_MinionTownId
FOREIGN KEY (TownId) REFERENCES Towns(Id)


--Problem 4.	Insert Records in Both Tables
INSERT INTO Towns(Id, [Name]) VALUES
(1, 'Sofia'),
(2, 'Plovdiv'),
(3, 'Varna')

INSERT INTO Minions(Id, [Name], Age, TownId) VALUES
(1, 'Kevin', 22, 1),
(2, 'Bob', 15, 3),
(3, 'Steward', NULL, 2)


--Problem 5.	Truncate Table Minions
TRUNCATE TABLE Minions


--Problem 6.	Drop All Tables


--Problem 7.	Create Table People
CREATE TABLE People (
	Id INT IDENTITY PRIMARY KEY,
	[Name] NVARCHAR(200) NOT NULL,
	Picture VARBINARY(2048),
	Height DECIMAL(3,2),
	[Weight] DECIMAL (5,2),
	Gender NCHAR(1) NOT NULL,
	Birthdate DATE NOT NULL,
	Biography NVARCHAR(MAX)
)

INSERT INTO People([Name], Picture, Height, [Weight], Gender, Birthdate) VALUES
('Name1', NULL, 1.11, 1.11, 'm',  '1994-01-01'),
('Name2', NULL, 2.22, 2.22, 'm',  '1994-02-02'),
('Name3', NULL, 3.33, 3.33, 'm',  '1994-03-03'),
('Name4', NULL, 4.44, 4.44, 'm',  '1994-04-04'),
('Name5', NULL, 5.55, 5.55, 'm',  '1994-05-05')


--Problem 8.	Create Table Users
CREATE TABLE Users (
	Id BIGINT IDENTITY PRIMARY KEY,
	Username NVARCHAR(30) UNIQUE NOT NULL,
	[Password] VARCHAR(26) NOT NULL,
	ProfilePicture VARBINARY(MAX),
	CHECK(DATALENGTH(ProfilePicture) <= 921600),
	LastLoginTime DATETIME2,
	IsDeleted BIT
)

INSERT INTO Users(Username, [Password]) VALUES
('Username1', 1),
('Username2', 2),
('Username3', 3),
('Username4', 4),
('Username5', 5)


--Problem 9.	Change Primary Key
ALTER TABLE Users
DROP CONSTRAINT PK__Users__3214EC077329BD97

ALTER TABLE Users
ADD PRIMARY KEY(Id, Username)


--Problem 10.	Add Check Constraint
ALTER TABLE Users
ADD CONSTRAINT CK_Password
CHECK (LEN([Password]) > 5)


--Problem 11.	Set Default Value of a Field
ALTER TABLE Users
ADD CONSTRAINT DF_LastLoginTime
DEFAULT GETDATE() FOR LastLoginTime


--Problem 12.	Set Unique Field


--Problem 13.	Movies Database
CREATE DATABASE Movies

GO
USE Movies

CREATE TABLE Directors (
	Id INT PRIMARY KEY IDENTITY,
	DirectorName NVARCHAR(50) NOT NULL,
	Notes NVARCHAR(100)
)

CREATE TABLE Genres (
	Id INT PRIMARY KEY IDENTITY,
	GenreName NVARCHAR(50) NOT NULL,
	Notes NVARCHAR(100)
)

CREATE TABLE Categories (
	Id INT PRIMARY KEY IDENTITY,
	CategoryName NVARCHAR(50) NOT NULL,
	Notes NVARCHAR(100)
)

CREATE TABLE Movies (
	Id INT PRIMARY KEY IDENTITY,
	Title NVARCHAR(50) NOT NULL,
	DirectorId INT FOREIGN KEY REFERENCES Directors(Id) NOT NULL,
	CopyrightYear DATETIME2 NOT NULL,
	[Length] DECIMAL(4,2) NOT NULL,
	GenreId INT FOREIGN KEY REFERENCES Genres(Id) NOT NULL,
	CategoryId INT FOREIGN KEY REFERENCES Categories(Id) NOT NULL,
	Rating DECIMAL(5,2),
	Notes NVARCHAR(100)
)

INSERT INTO Directors(DirectorName) VALUES
('DirectorName1'),
('DirectorName2'),
('DirectorName3'),
('DirectorName4'),
('DirectorName5')

INSERT INTO Genres(GenreName) VALUES
('GenreName1'),
('GenreName2'),
('GenreName3'),
('GenreName4'),
('GenreName5')

INSERT INTO Categories(CategoryName) VALUES
('CategoryName1'),
('CategoryName2'),
('CategoryName3'),
('CategoryName4'),
('CategoryName5')

INSERT INTO Movies(Title, DirectorId, CopyrightYear, [Length], GenreId, CategoryId) VALUES
('Title1', 1, GETDATE(), 1, 1, 1),
('Title2', 2, GETDATE(), 2, 2, 2),
('Title3', 3, GETDATE(), 3, 3, 3),
('Title4', 4, GETDATE(), 4, 4, 4),
('Title5', 5, GETDATE(), 5, 5, 5)


--Problem 14.	Car Rental Database
CREATE DATABASE CarRental

GO
USE CarRental

CREATE TABLE Categories (
	Id INT PRIMARY KEY IDENTITY,
	CategoryName NVARCHAR(50) NOT NULL,
	DailyRate DECIMAL(15,2),
	WeeklyRate DECIMAL(15,2),
	MonthlyRate DECIMAL(15,2),
	WeekendRate DECIMAL(15,2),
)

INSERT INTO Categories (CategoryName) VALUES
('CategoryName1'),
('CategoryName2'),
('CategoryName3')


CREATE TABLE Cars (
	Id INT PRIMARY KEY IDENTITY,
	PlateNumber NVARCHAR(50) NOT NULL,
	Manufacturer NVARCHAR(100) NOT NULL,
	Model NVARCHAR(100) NOT NULL,
	CarYear DateTime2 NOT NULL,
	CategoryId INT FOREIGN KEY REFERENCES Categories(Id) NOT NULL,
	Doors INT NOT NULL,
	Picture VARBINARY(MAX),
	Condition BIT DEFAULT 0,
	Available BIT DEFAULT 0
)

INSERT INTO Cars (PlateNumber, Manufacturer, Model, CarYear, CategoryId, Doors) VALUES
('PlateNumber1', 'Manufacturer1', 'Model1', '2019-06-06', 1, 5),
('PlateNumber2', 'Manufacturer2', 'Model2', '2019-06-06', 2, 3),
('PlateNumber3', 'Manufacturer3', 'Model3', '2019-06-06', 3, 5)


CREATE TABLE Employees (
	Id INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	Title NVARCHAR(100) NOT NULL,
	Notes NVARCHAR(MAX)
)

INSERT INTO Employees (FirstName, LastName, Title) VALUES
('FirstName1', 'LastName1', 'Title1'),
('FirstName2', 'LastName2', 'Title2'),
('FirstName3', 'LastName3', 'Title3')


CREATE TABLE Customers (
	Id INT PRIMARY KEY IDENTITY,
	DriverLicenceNumber NVARCHAR(50) NOT NULL,
	FullName NVARCHAR(50) NOT NULL,
	[Address] NVARCHAR(100) NOT NULL,
	City NVARCHAR(20) NOT NULL,
	ZIPCode INT NOT NULL,
	Notes NVARCHAR(MAX)
)

INSERT INTO Customers (DriverLicenceNumber, FullName, [Address], City, ZIPCode) VALUES
('DriverLicenceNumber1', 'FullName1', 'Address1', 'City1', 1),
('DriverLicenceNumber2', 'FullName2', 'Address2', 'City2', 2),
('DriverLicenceNumber3', 'FullName3', 'Address3', 'City3', 3)


CREATE TABLE RentalOrders (
	Id INT PRIMARY KEY IDENTITY,
	EmployeeId INT FOREIGN KEY REFERENCES Employees(Id) NOT NULL,
	CustomerId INT FOREIGN KEY REFERENCES Customers(Id) NOT NULL,
	CarId INT FOREIGN KEY REFERENCES Cars(Id) NOT NULL,
	TankLevel DECIMAL(6,3) NOT NULL,
	KilometrageStart DECIMAL(10,3) NOT NULL,
	KilometrageEnd DECIMAL(10,3) NOT NULL,
	TotalKilometrage DECIMAL(10,3) NOT NULL,
	StartDate DATETIME2 NOT NULL,
	EndDate DATETIME2 NOT NULL,
	TotalDays DATETIME2 NOT NULL,
	RateApplied DECIMAL(15,2) NOT NULL,
	TaxRate DECIMAL(15,2) NOT NULL,
	OrderStatus NVARCHAR(30) NOT NULL,
	Notes NVARCHAR(MAX)
)

INSERT INTO RentalOrders (EmployeeId, CustomerId, CarId, TankLevel, 
KilometrageStart, KilometrageEnd, TotalKilometrage, StartDate, EndDate, TotalDays, 
RateApplied, TaxRate, OrderStatus) VALUES
(1, 1, 1, 1.11, 1.11, 1.11, 1.11, GETDATE(), GETDATE(), GETDATE(), 1.11, 1.11, 1),
(2, 2, 2, 2.22, 2.22, 2.22, 2.22, GETDATE(), GETDATE(), GETDATE(), 2.22, 2.22, 2),
(3, 3, 3, 3.33, 3.33, 3.33, 3.33, GETDATE(), GETDATE(), GETDATE(), 3.33, 3.33, 3)
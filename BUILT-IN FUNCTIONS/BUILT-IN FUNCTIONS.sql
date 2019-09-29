USE SoftUni

-- Problem 1.	Find Names of All Employees by First Name
SELECT FirstName, LastName 
  FROM Employees
 WHERE FirstName LIKE 'SA%'


-- Problem 2.	  Find Names of All employees by Last Name 
SELECT FirstName, LastName 
  FROM Employees
 WHERE LastName LIKE '%ei%'


-- Problem 3.	Find First Names of All Employees
 SELECT FirstName 
   FROM Employees
 WHERE DepartmentID IN (3, 10) AND YEAR(HireDate) BETWEEN 1995 AND 2005


-- Problem 4.	Find All Employees Except Engineers
SELECT FirstName, LastName
  FROM Employees
 WHERE JobTitle NOT LIKE '%engineer%'


-- Problem 5.	Find Towns with Name Length
   SELECT [Name] 
     FROM Towns
    WHERE LEN([Name]) IN (5, 6)
 ORDER BY [Name] ASC


-- Problem 6.	 Find Towns Starting With
  SELECT * 
    FROM Towns
   WHERE [Name] LIKE ('[MKBE]%')
ORDER BY [Name] ASC


-- Problem 7.	 Find Towns Not Starting With
  SELECT * 
    FROM Towns
   WHERE [Name] NOT LIKE ('[RBD]%')
ORDER BY [Name] ASC


-- Problem 8.	Create View Employees Hired After 2000 Year
CREATE VIEW V_EmployeesHiredAfter2000 AS
SELECT FirstName, LastName
  FROM Employees
 WHERE YEAR(HireDate) > 2000


-- Problem 9.	Length of Last Name
SELECT FirstName, LastName 
  FROM Employees
 WHERE LEN(LastName) = 5


-- Problem 10.	Rank Employees by Salary
  SELECT EmployeeID, FirstName, LastName, Salary, DENSE_RANK() OVER (PARTITION BY Salary ORDER BY EmployeeID) AS [Rank]
    FROM Employees
   WHERE Salary BETWEEN 10000 AND 50000
ORDER BY Salary DESC


-- Problem 11.	Find All Employees with Rank 2 *
  SELECT * 
    FROM (SELECT EmployeeID, FirstName, LastName, Salary, DENSE_RANK() OVER (PARTITION BY Salary ORDER BY EmployeeID) AS [Rank]
		    FROM Employees
           WHERE Salary BETWEEN 10000 AND 50000) AS temp
   WHERE temp.Rank = 2
ORDER BY Salary DESC


USE Geography

-- Problem 12.	Countries Holding ‘A’ 3 or More Times
  SELECT CountryName, IsoCode
    FROM Countries
   WHERE CountryName LIKE '%A%A%A%'
ORDER BY IsoCode ASC


-- Problem 13.	 Mix of Peak and River Names
   SELECT p.PeakName, r.RiverName, LOWER(p.PeakName + SUBSTRING(r.RiverName, 2, Len(r.RiverName))) as Mix
     FROM Peaks AS p, Rivers AS r
    WHERE SUBSTRING(p.PeakName, LEN(p.PeakName), 1) = (SUBSTRING(r.RiverName, 1, 1))
 ORDER BY Mix ASC


USE Diablo

-- Problem 14.	Games from 2011 and 2012 year
  SELECT TOP(50) [Name], FORMAT ([Start], 'yyyy-MM-dd') AS [Start]
    FROM Games
   WHERE YEAR(Start) IN (2011, 2012)
ORDER BY [Start] ASC, [Name] ASC


-- Problem 15.	 User Email Providers
  SELECT Username, SUBSTRING(Email, CHARINDEX('@', Email) + 1, LEN(Email)) AS [Email Provider]
    FROM Users
ORDER BY [Email Provider] ASC, Username ASC


-- Problem 16.	 Get Users with IPAdress Like Pattern
  SELECT Username, IpAddress AS [IP Address]
    FROM Users
   WHERE IpAddress LIKE '___.1_%._%.___'
ORDER BY Username ASC


-- Problem 17.	 Show All Games with Duration and Part of the Day
    SELECT [Name] as Game,
     	   CASE
     		     WHEN DATEPART(HOUR, [Start]) >= 0 AND DATEPART(HOUR, [Start]) < 12 THEN 'Morning'
     		     WHEN DATEPART(HOUR, [Start]) >= 12 AND DATEPART(HOUR, [Start]) < 18 THEN 'Afternoon'
     		     WHEN DATEPART(HOUR, [Start]) >= 18 AND DATEPART(HOUR, [Start]) < 24 THEN 'Evening'
     	     END AS [Part of the Day],
     	   CASE
     		     WHEN Duration <= 3 THEN 'Extra Short'
     		     WHEN Duration BETWEEN 4 AND 6 THEN 'Short'
     		     WHEN Duration > 6 THEN 'Long'
     		     WHEN Duration IS NULL THEN 'Extra Long'
     	     END AS Duration
    FROM Games
ORDER BY Game ASC, Duration ASC , [Part of the Day] ASC


--Problem 18.	 Orders Table
CREATE TABLE Orders(
	Id INT PRIMARY KEY,
	ProductName NVARCHAR(50),
	OrderDate DATETIME2
)

INSERT INTO Orders (Id, ProductName, OrderDate) VALUES
	(1, 'Butter', '2016-09-19 00:00:00.000'),
	(2, 'Milk', '2016-09-30 00:00:00.000'),
	(3, 'Cheese', '2016-09-04 00:00:00.000'),
	(4, 'Bread', '2015-12-20 00:00:00.000'),
	(5, 'Tomatoes', '2015-12-30 00:00:00.000')

SELECT ProductName, OrderDate, 
	   DATEADD(DAY, 3, OrderDate) AS [Pay Due],
	   DATEADD(MONTH, 1, OrderDate) AS [Deliver Due]
  FROM Orders


-- Problem 19.	 People Table
CREATE TABLE People(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(30),
	Birthdate DATETIME2
)

INSERT INTO People ([Name], Birthdate) VALUES
	('Victor', '2000-12-07 00:00:00.000'),
	('Steven', '1992-09-10 00:00:00.000'),
	('Stephen', '1910-09-19 00:00:00.000'),
	('John', '2010-01-06 00:00:00.000')

SELECT [Name], 
	   DATEDIFF(YEAR,Birthdate, GETDATE()) AS [Age in Years],
	   DATEDIFF(MONTH,Birthdate, GETDATE()) AS [Age in Months],
	   DATEDIFF(DAY,Birthdate, GETDATE()) AS [Age in Days],
	   DATEDIFF(MINUTE,Birthdate, GETDATE()) AS [Age in Minutes]
  FROM People

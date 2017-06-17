USE AdventureWorks2016CTP3
--------------
SELECT p.ProductId, p.Name, p.Color , sc.Name 'SubCategoryName'
FROM Production.Product p
INNER JOIN Production.ProductSubcategory sc
ON p.ProductSubcategoryID = sc.ProductSubcategoryID
--------------
SELECT p.ProductId, p.Name, p.Color , sc.Name 'SubCategoryName'
FROM Production.Product p
LEFT OUTER JOIN Production.ProductSubcategory sc
ON p.ProductSubcategoryID = sc.ProductSubcategoryID
---------------اشتباه
SELECT p.ProductId, p.Name, p.Color , sc.Name 'SubCategoryName'
FROM Production.Product p
LEFT OUTER JOIN Production.ProductSubcategory sc
ON p.ProductID = sc.ProductSubcategoryID
-----------------
SELECT p.ProductId, p.Name, ISNULL(p.Color, '[NoColor]') , 
ISNULL(sc.Name,'[NoCategory]') 'SubCategoryName'
FROM Production.Product p
LEFT OUTER JOIN Production.ProductSubcategory sc
ON p.ProductSubcategoryID = sc.ProductSubcategoryID
------------------
SELECT DISTINCT ISNULL(Color, 'NoColor')
FROM Production.Product
------------------
SELECT p.ProductId, p.Name,ISNULL(ListPrice, 0), ISNULL(p.Color, '[NoColor]') , 
ISNULL(sc.Name,'[NoCategory]') 'SubCategoryName'
FROM Production.Product p
LEFT OUTER JOIN Production.ProductSubcategory sc
ON p.ProductSubcategoryID = sc.ProductSubcategoryID
------------------
SELECT p.ProductId, p.Name, 
sc.Name 'SubCategoryName', 
SUM(s.LineTotal) 'TotalSales'
FROM Production.ProductSubcategory sc
INNER JOIN Production.Product p
ON sc.ProductSubcategoryID = p.ProductSubcategoryID
INNER JOIN Sales.SalesOrderDetail s
ON p.ProductID = s.ProductID
GROUP BY p.ProductId, p.Name, sc.Name
ORDER BY TotalSales DESC
----------------
SELECT p.ProductId, p.Name, 
sc.Name 'SubCategoryName', 
SUM(s.LineTotal) 'TotalSales'
FROM Production.ProductSubcategory sc
RIGHT OUTER JOIN Production.Product p
ON sc.ProductSubcategoryID = p.ProductSubcategoryID
LEFT OUTER JOIN Sales.SalesOrderDetail s
ON p.ProductID = s.ProductID
GROUP BY p.ProductId, p.Name, sc.Name
ORDER BY TotalSales DESC
-------------------
SELECT p.ProductId, p.Name, 
sc.Name 'SubCategoryName', 
SUM(s.LineTotal) 'TotalSales'
FROM Production.Product p
LEFT OUTER JOIN Production.ProductSubcategory sc
ON sc.ProductSubcategoryID = p.ProductSubcategoryID
LEFT OUTER JOIN Sales.SalesOrderDetail s
ON p.ProductID = s.ProductID
GROUP BY p.ProductId, p.Name, sc.Name
ORDER BY TotalSales DESC
---------------------
SELECT DISTINCT ProductSubCategoryID
FROM Production.Product
---------------------
CREATE DATABASE Session05
GO
USE Session05
GO
CREATE TABLE Product
(
	ProductID INT IDENTITY PRIMARY KEY,
	Name NVARCHAR(50),
	CategoryID INT
)
GO
CREATE TABLE Category
(
	CategoryId INT IDENTITY PRIMARY KEY,
	Name NVARCHAR(50)
)
GO
---------------------
SELECT p.Name , c.Name 'CategoryName'
FROM Product p
INNER JOIN Category c
ON p.CategoryID = c.CategoryId
---------------------
SELECT p.Name , c.Name 'CategoryName'
FROM Product p
FULL OUTER JOIN Category c
ON p.CategoryID = c.CategoryId
---------------------
CREATE TABLE Student
(
	StudentId INT IDENTITY PRIMARY KEY,
	Name NVARCHAR(50)
)
GO
CREATE TABLE Course
(
	CourseID INT IDENTITY PRIMARY KEY,
	Name NVARCHAR(50)
)
GO
INSERT INTO Student VALUES ('Reza'), 
('John') ,
('Peyman'), 
('Maryam'), 
('Sarah')
GO
INSERT INTO Course VALUES ('C# Intro'), 
('SQL Serevr Development') ,
('Python'), 
('Client-Side Development'), 
('Java')
GO
-------------------
SELECT s.Name, c.Name 'CourseName'
FROM Student s
CROSS JOIN Course c
ORDER BY Name
----------------
SELECT s.StudentId,s.Name, c.Name 'CourseName'
FROM Student s
CROSS JOIN Course c
WHERE c.Name != 'Python'
ORDER BY Name

----------------
CREATE TABLE Employee
(
	EmployeeId INT PRIMARY KEY,
	Name NVARCHAR(50),
	Position NVARCHAR(50),
	ManagerId INT
)
----------------
SELECT e.Name, e.Position, 
m.Name 'Manager1Name', m.Position 'ManagerPosition1'
FROM Employee e
LEFT OUTER JOIN Employee m
ON e.ManagerId = m.EmployeeId
----------------
SELECT e.Name, e.Position, 
m.Name 'ManagerName1', m.Position 'ManagerPosition1',
m2.Name 'ManagerName2', m2.Position 'ManagerPosition2'
FROM Employee e
LEFT OUTER JOIN Employee m
ON e.ManagerId = m.EmployeeId
LEFT OUTER JOIN Employee m2
ON m.ManagerId = m2.EmployeeId
----------------
USE AdventureWorks2016CTP3
----------------
SELECT Name, Color, ListPrice
FROM Production.Product
WHERE ProductId IN
(
	SELECT TOP 3 ProductId
	FROM Sales.SalesOrderDetail
	GROUP BY ProductId
	ORDER BY SUM(OrderQty) DESC
)
-----------------
SELECT Name, Color, ListPrice
FROM Production.Product
WHERE ProductId IN
(
	777,711,825,3,901
)
------------------
SELECT ProductId, UnitPrice
FROM Sales.SalesOrderDetail
WHERE UnitPrice > ANY
(
	SELECT UnitPrice 
	FROM Sales.SalesOrderDetail 
	WHERE ModifiedDate BETWEEN '2011-10-10' AND '2011-11-10'
)
------------------
SELECT ProductId, UnitPrice
FROM Sales.SalesOrderDetail
WHERE UnitPrice > 
(
	SELECT MAX(UnitPrice)
	FROM Sales.SalesOrderDetail 
	WHERE ModifiedDate BETWEEN '2011-10-10' AND '2011-11-10'
)
--------------------
SELECT p.Name , p.Color, 
(
	SELECT sc.Name
	FROM Production.ProductSubcategory sc
	WHERE p.ProductSubcategoryID = sc.ProductSubcategoryID
)
FROM Production.Product p
---------------------
--------------------
SELECT p.Name , p.Color, 
(
	SELECT sc.Name
	FROM Production.ProductSubcategory sc
	WHERE p.ProductSubcategoryID = sc.ProductSubcategoryID
) 'SubCategoryName'
FROM Production.Product p
WHERE p.ProductSubcategoryID IN
(
	SELECT ProductSubcategoryID 
	FROM Production.ProductSubcategory sc
	WHERE sc.ProductCategoryID IN 
	(
		SELECT c.ProductCategoryId
		FROM Production.ProductCategory c
		WHERE c.Name LIKE '%Bike%'
	)
)
---------------------
SELECT TOP 1 p.Color, SUM(s.OrderQty) 'TotalQty'
FROM Production.Product p
INNER JOIN Sales.SalesOrderDetail s
ON p.ProductID = s.ProductID
GROUP BY p.Color
ORDER BY TotalQty DESC
-----------------------
SELECT TOP 5
sc.Name , SUM(s.LineTotal) 'TotalSales'
FROM Production.ProductSubCategory sc
INNER JOIN Production.Product p
ON sc.ProductSubcategoryID = p.ProductSubcategoryID
INNER JOIN Sales.SalesOrderDetail s
ON p.ProductID = s.ProductID
GROUP BY sc.Name 
ORDER BY TotalSales DESC
------------------------
SELECT
c.Name 'Category', SUM(s.LineTotal) 'TotalSales'
FROM Production.ProductCategory c
INNER JOIN Production.ProductSubCategory sc
ON c.ProductCategoryID = sc.ProductCategoryID
INNER JOIN Production.Product p
ON sc.ProductSubcategoryID = p.ProductSubcategoryID
INNER JOIN Sales.SalesOrderDetail s
ON p.ProductID = s.ProductID
GROUP BY c.Name
ORDER BY TotalSales DESC


USE AdventureWorks2016CTP3
GO
SELECT ProductId, 
(
	SELECT Name
	FROM Production.Product p
	WHERE s.ProductID = p.ProductID
) 'Name'
,OrderQty, UnitPrice, LineTotal
FROM Sales.SalesOrderDetail s
-------------------
SELECT ProductId, Name, 
CASE Color
WHEN 'Black' THEN N'مشکی'
WHEN 'Blue' THEN N'آبی'
WHEN 'Red' THEN N'قرمز'
ELSE N'سایر رنگها'
END 'Color'
FROM Production.Product
--------------------
SELECT SalesOrderId, 
CASE
WHEN SUM(LineTotal) > 10000 THEN N'فروش بالا'
WHEN SUM(LineTotal) BETWEEN 5000 AND 9999 THEN N'متوسط'
ELSE N'کم'
END 'SalesRange'
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderId
ORDER BY SUM(LineTotal) DESC
---------------------
SELECT AVG(SumQty) 'Average'
FROM(
SELECT SalesOrderId, SUM(OrderQty) 'SumQty'
FROM Sales.SalesOrderDetail 
GROUP BY SalesOrderID
) AS s
-----------------------
SELECT AVG(OrderQty)
FROM Sales.SalesOrderDetail
-----------------------
GO
WITH Q
AS
(
	SELECT ROW_NUMBER() OVER(ORDER BY Name) 'Row', ProductID, Name
	FROM Production.Product
)
SELECT *
FROM Q
WHERE [Row] > ( 3 - 1 ) * 10 AND [Row] <= 3 * 10
----------------------
CREATE DATABASE Session06
GO
USE Session06
GO
CREATE TABLE Employee
(
	EmployeeId INT,
	Name NVARCHAR(50),
	JobId INT
)
GO
CREATE TABLE Job
(
	JobId INT,
	Name NVARCHAR(50)
)
GO
CREATE TABLE JobCourse
(
	JobId INT,
	CourseId INT
)
GO
CREATE TABLE Course
(
	CourseId INT,
	Name NVARCHAR(50)
)
GO
CREATE TABLE EmployeeCourse
(
	EmployeeId INT,
	CourseId INT
)
GO
SELECT c.Name
FROM Job j
--INNER JOIN Employee e
--ON j.JobId = e.JobId
INNER JOIN JobCourse jc
ON jc.JobId = j.JobId
INNER JOIN Course c
ON jc.CourseId = c.CourseId
WHERE j.Name LIKE '%dev%'
EXCEPT
SELECT c.Name
FROM Employee e
INNER JOIN EmployeeCourse ec
ON e.EmployeeId = ec.EmployeeId
INNER JOIN Course c
ON ec.CourseId = c.CourseId
WHERE e.Name LIKE '%John%'
GO
SELECT c.Name
FROM Job j
INNER JOIN JobCourse jc
ON jc.JobId = j.JobId
INNER JOIN Course c
ON jc.CourseId = c.CourseId
WHERE j.Name LIKE '%dev%'
UNION
SELECT c.Name
FROM Job j
INNER JOIN JobCourse jc
ON jc.JobId = j.JobId
INNER JOIN Course c
ON jc.CourseId = c.CourseId
WHERE j.Name LIKE '%manag%'
GO
SELECT c.Name
FROM Job j
INNER JOIN JobCourse jc
ON jc.JobId = j.JobId
INNER JOIN Course c
ON jc.CourseId = c.CourseId
WHERE j.Name LIKE '%dev%'
UNION ALL
SELECT c.Name
FROM Job j
INNER JOIN JobCourse jc
ON jc.JobId = j.JobId
INNER JOIN Course c
ON jc.CourseId = c.CourseId
WHERE j.Name LIKE '%manag%'
GO
SELECT c.Name
FROM Job j
INNER JOIN JobCourse jc
ON jc.JobId = j.JobId
INNER JOIN Course c
ON jc.CourseId = c.CourseId
WHERE j.Name LIKE '%dev%'
INTERSECT
SELECT c.Name
FROM Job j
INNER JOIN JobCourse jc
ON jc.JobId = j.JobId
INNER JOIN Course c
ON jc.CourseId = c.CourseId
WHERE j.Name LIKE '%manag%'
GO
INSERT INTO Employee(EmployeeId, Name)
VALUES (5,'Reza'),(6,'Payam'),(7,'Elham'), (8, 'Maryam')
GO
INSERT INTO Employee
VALUES (9,'Ali', 2)
GO
DROP TABLE Employee
GO
CREATE TABLE Employee
(
	EmployeeId INT IDENTITY PRIMARY KEY,
	Name NVARCHAR(50),
	JobId INT
)
GO
INSERT INTO Employee
VALUES ('Ali', 2, 5, 4)
GO
INSERT INTO Job
VALUES('abc',3)
GO
SELECT p.ProductId, Name, Color, ISNULL(SUM(s.OrderQty),0 )'SumQty'
INTO Product
FROM AdventureWorks2016CTP3.Production.Product p
LEFT OUTER JOIN AdventureWorks2016CTP3.Sales.SalesOrderDetail s
ON p.ProductID = s.ProductID
GROUP BY p.ProductId, Name, Color

GO
SELECT * FROM Product
GO
INSERT INTO Employee(Name)
SELECT CONCAT(FirstName, ' ' , MiddleName, ' ' ,LastName)
FROM AdventureWorks2016CTP3.Person.Person
WHERE PersonType = 'EM'

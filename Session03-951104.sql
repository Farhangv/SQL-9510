SELECT 'John' + ' ' + 'Doe'
-------------
USE AdventureWorks2016CTP3
-------------
SELECT * FROM Person.Person
-------------
SELECT FirstName + ' ' + MiddleName + ' ' + LastName
FROM Person.Person
--------------
SELECT * 
FROM Sales.SalesOrderDetail
---------------
SELECT *
FROM Sales.SalesOrderHeader
---------------
SELECT SUM(LineTotal)
FROM Sales.SalesOrderDetail
---------------
SELECT SUM(LineTotal)
FROM Sales.SalesOrderDetail
WHERE SalesOrderID = 43659
----------------
SELECT SUM(LineTotal)
FROM Sales.SalesOrderDetail
WHERE ModifiedDate BETWEEN '2012-12-01' AND '2012-12-15'
-----------------
SELECT COUNT(*)
FROM Sales.SalesOrderDetail
------------------
SELECT COUNT(Color)
FROM Production.Product
------------------
SELECT COUNT(*)
FROM Production.Product
------------------
SELECT *
FROM Production.Product
------------------
SELECT AVG(UnitPrice)
FROM Sales.SalesOrderDetail
-------------------
SELECT AVG(ListPrice)
FROM Production.Product
--------------------
SELECT MIN(UnitPrice), MAX(UnitPrice)
FROM Sales.SalesOrderDetail
--------------------
SELECT VAR(UnitPrice)
FROM Sales.SalesOrderDetail
--------------------
SELECT MAX(1000)
--------------------
SELECT *
FROM Sales.SalesOrderDetail
WHERE UnitPrice > 1000
---------------------
SELECT ProductId, Name, Color
FROM Production.Product 
WHERE Color = 'Blue'
---------------------
SELECT ProductId, Name, Color
FROM Production.Product
WHERE Name > 'a' AND Name < 'c'
---------------------
SELECT ProductId, Name, Color
FROM Production.Product
WHERE Name BETWEEN 'a' AND 'c'
ORDER BY Name
----------------------
SELECT ProductId, Name, Color
FROM Production.Product 
WHERE Name LIKE 'b%'
-----------------------
SELECT ProductId, Name, Color
FROM Production.Product 
WHERE Name LIKE '___b%'
-----------------------
SELECT ProductId, Name, Color
FROM Production.Product 
WHERE Name LIKE '%bearing%'
------------------------
SELECT ProductId, Name, Color
FROM Production.Product 
WHERE Name NOT LIKE '%e'
------------------------
SELECT ProductId, Name, Color
FROM Production.Product 
WHERE Color IS NULL
------------------------
SELECT ProductId, Name, Color
FROM Production.Product 
WHERE Color IS NOT NULL
------------------------
SELECT COUNT(*)
FROM Production.Product
WHERE Color IS NOT NULL
------------------------
SELECT SUM(LineTotal)
FROM Sales.SalesOrderDetail
WHERE SalesOrderID = 43668
------------------------
SELECT SUM(LineTotal) 'Sum', SUM(OrderQty) 'QtySum', 
SUM((UnitPrice * OrderQty) * UnitPriceDiscount) 'SumDiscount'
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderId
------------------------
SELECT SalesOrderId,SUM(LineTotal) 'Sum', SUM(OrderQty) 'QtySum', 
SUM((UnitPrice * OrderQty) * UnitPriceDiscount) 'SumDiscount'
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderId
--ORDER BY QtySum DESC
ORDER BY SumDiscount DESC
------------------------
SELECT SalesOrderId,SUM(LineTotal) 'Sum', SUM(OrderQty) 'QtySum', 
SUM((UnitPrice * OrderQty) * UnitPriceDiscount) 'SumDiscount'
FROM Sales.SalesOrderDetail
--GROUP BY SalesOrderId
ORDER BY SumDiscount DESC
--------------------------
SELECT Color, COUNT(*)
FROM Production.Product
GROUP BY Color
--------------------------
SELECT YEAR(HireDate), COUNT(*)
FROM HumanResources.Employee
GROUP BY YEAR(HireDate)
--------------------------
SELECT YEAR(HireDate) 'Year', 
MONTH(HireDate) 'Month', 
DAY(HireDate) 'Day',  
COUNT(*) 'Count'
FROM HumanResources.Employee
GROUP BY YEAR(HireDate), MONTH(HireDate), DAY(HireDate)
WITH ROLLUP
ORDER BY 1,2,3 --[Year],[Month],[Day]
-----------------
SELECT COUNT(*)
FROM HumanResources.Employee
------------------
SELECT YEAR(HireDate) 'Year', 
MONTH(HireDate) 'Month', 
DAY(HireDate) 'Day',  
COUNT(*) 'Count'
FROM HumanResources.Employee
GROUP BY YEAR(HireDate), MONTH(HireDate), DAY(HireDate)
WITH CUBE
ORDER BY 1,2,3 --[Year],[Month],[Day]
-------------------
--Concatination
SELECT FirstName + ' ' + MiddleName + ' ' + LastName
FROM Person.Person
--------------------
SELECT CONCAT(FirstName , ' ' , MiddleName , ' ' , LastName)
FROM Person.Person
--------------------
SELECT SUBSTRING(Name, 1, 5)
FROM Production.Product
--------------------
SELECT LEFT(Name, 3)
FROM Production.Product
--------------------
SELECT RIGHT(Name, 3)
FROM Production.Product
--------------------
SELECT LEFT(Name,1), COUNT(*)
--WHERE LEFT(Name,1) = 'a'
FROM Production.Product
GROUP BY LEFT(Name,1)

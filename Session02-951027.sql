SELECT 123
-----------
SELECT 'Hello'
-----------
SELECT 'سلام'
-----------
SELECT N'سلام'
-----------
SELECT @@CONNECTIONS
-----------
SELECT GETDATE()
-----------
USE AdventureWorks2016CTP3
-----------
sElect 'salaam'
-----------
SELECT *
FROM Production.Product
-----------
SELECT ProductId, Name, Color, ListPrice
FROM Production.Product
-----------
SELECT ProductId AS 'شناسه', Name 'نام', Color رنگ, ListPrice AS قیمت
FROM Production.Product
-----------
SELECT ProductId AS 'شناسه', [Name] 'نام', Color رنگ, ListPrice AS قیمت
FROM [Production].[Product]
-----------
SELECT ProductId, Name, Color, ListPrice
FROM Production.Product
-----------
SELECT Name, ProductId, Color, ListPrice
FROM Production.Product
-----------
SELECT ProductId, [Name], Color, ListPrice
FROM Production.Product
ORDER BY 2
-----------
SELECT ProductId, [Name], Color, ListPrice
FROM Production.Product
ORDER BY Color, Name
-----------
SELECT ProductId, [Name], Color, ListPrice
FROM Production.Product
ORDER BY Color DESC, Name DESC
------------
SELECT ProductId, [Name], Color, ListPrice 'قیمت فروش'
FROM Production.Product
ORDER BY Color DESC, Name DESC
------------
SELECT ProductId, [Name], Color, ListPrice 'قیمت فروش'
FROM Production.Product
--WHERE [قیمت فروش] > 0
ORDER BY [قیمت فروش] DESC
------------
SELECT ProductId, Name, ListPrice, StandardCost,ListPrice - StandardCost 'Profit'
FROM Production.Product
------------
SELECT TOP 10 PERCENT
ProductId, Name, ListPrice, StandardCost,ListPrice - StandardCost 'Profit'
FROM Production.Product
ORDER BY Profit DESC
------------
SELECT TOP 10 WITH TIES
ProductId, Name, ListPrice, StandardCost,ListPrice - StandardCost 'Profit'
FROM Production.Product
ORDER BY Profit DESC
------------
SELECT
ProductId, Name, ListPrice, StandardCost,ListPrice - StandardCost 'Profit'
FROM Production.Product
ORDER BY Profit DESC
OFFSET 10 ROWS FETCH NEXT 25 ROWS ONLY
-------------
SELECT
ProductId, Name, ListPrice, StandardCost,ListPrice - StandardCost 'Profit'
FROM Production.Product
ORDER BY ProductId
OFFSET (5 - 1)* 20 ROWS FETCH NEXT 20 ROWS ONLY
--------------
SELECT DISTINCT
ProductId, Name, ListPrice, StandardCost,ListPrice - StandardCost 'Profit'
FROM Production.Product
ORDER BY ProductId
---------------
SELECT DISTINCT
Color
FROM Production.Product
---------------
SELECT DISTINCT
Color, ListPrice
FROM Production.Product
---------------
SELECT GETDATE() 'DateTime', 
SYSDATETIME() 'DateTime2', 
SYSDATETIMEOFFSET() 'DateTimeOffset'
---------------
SELECT DATEPART(YEAR, GETDATE()), 
DATEPART(MONTH, GETDATE()),
DATEPART(DAY, GETDATE())
---------------
SELECT DATEADD(MONTH, 2, GETDATE())
---------------
SELECT DATEPART(YEAR,ModifiedDate)
FROM Production.Product
---------------
SELECT DATEPART(YEAR, GETDATE()) - DATEPART(YEAR,HireDate)
FROM HumanResources.Employee





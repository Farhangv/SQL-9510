USE AdventureWorks2016CTP3
---------------
SELECT SalesOrderId,SUM(LineTotal) 'InvoiceTotal'
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
ORDER BY [InvoiceTotal] DESC
----------------
SELECT SalesOrderId,SUM(LineTotal) 'InvoiceTotal'
FROM Sales.SalesOrderDetail
WHERE ModifiedDate BETWEEN '2012-01-01' AND '2013-01-01'
GROUP BY SalesOrderID
ORDER BY [InvoiceTotal] DESC
-----------------
SELECT * FROM Sales.SalesOrderDetail
-----------------
SELECT SalesOrderId,SUM(LineTotal) 'InvoiceTotal'
FROM Sales.SalesOrderDetail
WHERE ModifiedDate BETWEEN '2012-01-01' AND '2013-01-01'
GROUP BY SalesOrderID
HAVING SUM(LineTotal) BETWEEN 8000 AND 10000
ORDER BY [InvoiceTotal] DESC
-----------------
SELECT ROW_NUMBER() OVER(ORDER BY [Name]) 'Row' ,ProductId, Name, Color
FROM Production.Product
-----------------
SELECT ROW_NUMBER() OVER(ORDER BY [Name]) 'Row' ,ProductId, Name, Color
FROM Production.Product
ORDER BY Name
------------------
SELECT ROW_NUMBER() OVER(PARTITION BY [Color] ORDER BY [Name] ) 'Row',
ProductId, [Name], Color
FROM Production.Product
------------------
SELECT ROW_NUMBER() OVER(ORDER BY ListPrice) 'Row' ,ProductId, 
Name, Color, ListPrice
FROM Production.Product
ORDER BY ListPrice
------------------
SELECT ROW_NUMBER() OVER(PARTITION BY [Color] ORDER BY [Name] ) 'Row',
ProductId, [Name], Color
FROM Production.Product
------------------
SELECT ROW_NUMBER() OVER(PARTITION BY [Color] ORDER BY [Name] ) 'Row',
ProductId, [Name], Color
FROM Production.Product
-------------------
SELECT RANK() OVER(ORDER BY Color) 'Rank',
ProductId, [Name], Color
FROM Production.Product
-------------------
SELECT DENSE_RANK() OVER(ORDER BY Color) 'Rank',
ProductId, [Name], Color
FROM Production.Product
-------------------
SELECT TOP 3 WITH TIES RANK() OVER (ORDER BY ListPrice DESC) 'Rank',
ProductId, ListPrice
FROM Production.Product
ORDER BY ListPrice DESC

--------------------
SELECT ProductID, Name, Color, NTILE(5) OVER (ORDER BY ProductId) 'Tile'
FROM Production.Product
--------------------
SELECT ROW_NUMBER() OVER (ORDER BY Name) 'Row',
ProductID, Name, Color, NTILE(5) OVER (PARTITION BY Color 
ORDER BY ProductId) 'Tile'
FROM Production.Product
ORDER BY [Row]
--------------------
SELECT DISTINCT SalesOrderId,
SUM(LineTotal) OVER(PARTITION BY SalesOrderId) 'InvoiceTotal', 
--SUM(LineTotal) OVER() 'GrandTotal', 
SUM(LineTotal) OVER(PARTITION BY SalesOrderId) / SUM(LineTotal) OVER() 'Percent'
FROM Sales.SalesOrderDetail
--GROUP BY SalesOrderID
ORDER BY [Percent] DESC
----------------------
SELECT s.SalesOrderDetailID, s.ProductID, p.Name, 
p.Color, s.UnitPrice, s.OrderQty, s.UnitPriceDiscount, s.LineTotal
FROM Sales.SalesOrderDetail s
INNER JOIN Production.Product p
ON s.ProductID = p.ProductID
--WHERE p.Color = 'Red'
-----------------------
SELECT p.ProductId, p.Name, ps.Name 'SubCategoryName'
FROM Production.Product p
INNER JOIN Production.ProductSubcategory ps
ON p.ProductSubcategoryID = ps.ProductSubcategoryID
-----------------------
SELECT p.ProductId, p.Name, ps.Name 'SubCategoryName'
FROM Production.Product p
,Production.ProductSubcategory ps
WHERE p.ProductSubcategoryID = ps.ProductSubcategoryID
----------------------
SELECT p.ProductId, p.Name, ps.Name 'SubCategoryName', pc.Name 'CategoryName'
FROM Production.Product p
INNER JOIN Production.ProductSubcategory ps
ON p.ProductSubcategoryID = ps.ProductSubcategoryID
INNER JOIN Production.ProductCategory pc
ON ps.ProductCategoryID = pc.ProductCategoryID
----------------------



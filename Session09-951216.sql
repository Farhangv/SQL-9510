CREATE DATABASE Session09
GO
USE Session09
GO
CREATE TABLE Department
(
	Id INT IDENTITY PRIMARY KEY,
	Name NVARCHAR(50)
)
GO
CREATE TABLE Employee
(
	Id INT PRIMARY KEY IDENTITY,
	Name NVARCHAR(50),
	Family NVARCHAR(50),
	DepartmentId INT FOREIGN KEY REFERENCES Department(Id)
)
GO
INSERT INTO Department VALUES(N'تولید'),( N'پشتیبانی'),(N'مالی')
GO
INSERT INTO Employee VALUES
(N'پیمان', N'پیمانی', 1),
(N'رضا', N'رضایی', 1),
(N'سارا', N'سارایی', 2),
(N'جان', N'دو', 2),
(N'سارا', N'اسمیت', 3)
GO
CREATE VIEW VW_Production
AS
	SELECT e.Id,d.Name 'DepartmentName',e.Name,e.Family
	FROM Employee AS e
	INNER JOIN Department AS d
	ON e.DepartmentId = d.Id
	WHERE d.Id = 1 
GO
CREATE VIEW VW_Support
AS
	SELECT e.Id,d.Name 'DepartmentName',e.Name,e.Family
	FROM Employee AS e
	INNER JOIN Department AS d
	ON e.DepartmentId = d.Id
	WHERE d.Id = 2 
GO
CREATE VIEW VW_Financial
AS
	SELECT e.Id,d.Name 'DepartmentName',e.Name,e.Family
	FROM Employee AS e
	INNER JOIN Department AS d
	ON e.DepartmentId = d.Id
	WHERE d.Id = 3
GO
SELECT * FROM 
VW_Financial
GO
SELECT * FROM 
VW_Production
GO
ALTER VIEW VW_Production
AS
	SELECT e.Id,e.Name,e.Family, e.DepartmentId
	FROM Employee AS e
	WHERE e.DepartmentId = 1 
GO
ALTER VIEW VW_Support
AS
	SELECT e.Id,e.Name,e.Family, e.DepartmentId
	FROM Employee AS e
	WHERE e.DepartmentId = 2
GO
ALTER VIEW VW_Financial
AS
	SELECT e.Id,e.Name,e.Family, e.DepartmentId
	FROM Employee AS e
	WHERE e.DepartmentId = 3

GO
SELECT * FROM VW_Financial
GO
INSERT INTO VW_Financial(Name,Family,DepartmentId) VALUES (N'پیام',N'پیامی',3)
GO 
INSERT INTO VW_Financial(Name,Family,DepartmentId) VALUES (N'کسرا',N'کسرایی',1)
GO
ALTER VIEW VW_Production
AS
	SELECT e.Id,e.Name,e.Family, e.DepartmentId
	FROM Employee AS e
	WHERE e.DepartmentId = 1 
	WITH CHECK OPTION
GO
ALTER VIEW VW_Support
AS
	SELECT e.Id,e.Name,e.Family, e.DepartmentId
	FROM Employee AS e
	WHERE e.DepartmentId = 2
	WITH CHECK OPTION
GO
ALTER VIEW VW_Financial
AS
	SELECT e.Id,e.Name,e.Family, e.DepartmentId
	FROM Employee AS e
	WHERE e.DepartmentId = 3
	WITH CHECK OPTION

GO
INSERT INTO VW_Financial(Name,Family,DepartmentId) VALUES (N'مریم',N'مریمی',3)
GO
DELETE FROM VW_Financial WHERE Name = N'مریم'
GO
ALTER VIEW VW_Production
WITH ENCRYPTION
AS
	SELECT e.Id,e.Name,e.Family, e.DepartmentId
	FROM Employee AS e
	WHERE e.DepartmentId = 1 
	WITH CHECK OPTION
GO
ALTER VIEW VW_Support
WITH SCHEMABINDING
AS
	SELECT e.Id,e.Name,e.Family, e.DepartmentId
	FROM dbo.Employee AS e
	WHERE e.DepartmentId = 2
	WITH CHECK OPTION
GO
ALTER VIEW VW_Financial
AS
	SELECT e.Id,e.Name,e.Family, e.DepartmentId
	FROM Employee AS e
	WHERE e.DepartmentId = 3
	WITH CHECK OPTION
GO
SELECT * FROM sys.databases
GO
SELECT * FROM INFORMATION_SCHEMA.TABLES
GO
SELECT * FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'VIEW'
GO
SELECT * FROM INFORMATION_SCHEMA.COLUMNS c
INNER JOIN INFORMATION_SCHEMA.TABLES t
ON c.TABLE_NAME = t.TABLE_NAME
WHERE t.TABLE_TYPE = 'VIEW'
GO
SELECT * FROM INFORMATION_SCHEMA.VIEWS
GO
SELECT * FROM INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE
GO
SELECT * FROM INFORMATION_SCHEMA.CONSTRAINT_TABLE_USAGE
GO
USE AdventureWorks2016CTP3
GO
SELECT * FROM Production.Product
GO
ALTER FUNCTION UDF_CalculateBenefits
(
	@ProductId INT,
	@SalesPrice DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
AS
BEGIN
	DECLARE @Cost DECIMAL(10,2)
	SELECT @Cost = StandardCost FROM Production.Product WHERE ProductID = @ProductId
	RETURN @SalesPrice - @Cost
END
GO
SELECT ProductId, OrderQty, UnitPrice, dbo.UDF_CalculateBenefits(ProductId, UnitPrice) 'Benefit'
FROM Sales.SalesOrderDetail
GO
EXEC sp_configure 'show advanced options', '1'
GO
RECONFIGURE
GO
EXEC sp_configure 'clr enabled', '1'
GO
RECONFIGURE
GO
SELECT Session09.dbo.ToPersianDate(GETDATE())
GO
SELECT BusinessEntityId, Session09.dbo.ToPersianDate(HireDate) 'HireDate', Session09.dbo.ToPersianDate(BirthDate ) 'DOB'
FROM HumanResources.Employee
ORDER BY DOB DESC
GO
CREATE FUNCTION UDF_GetInvoicesByRange
(
	@Min INT,
	@Max INT
)
RETURNS TABLE
AS
RETURN 
SELECT SalesOrderId, SubTotal FROM Sales.SalesOrderHeader
WHERE SubTotal >= @Min AND SubTotal <= @Max
GO
SELECT * FROM UDF_GetInvoicesByRange(2000,5000)
ORDER BY SubTotal
GO
USE Session09
GO
CREATE FUNCTION UDF_SearchEmployees
(
	@Search NVARCHAR(50)
)
RETURNS TABLE
AS
RETURN
SELECT * FROM Employee 
WHERE Name LIKE '%'+ @Search +'%' OR Family LIKE '%'+@Search+'%'
GO
SELECT * FROM UDF_SearchEmployees(N'اسم')
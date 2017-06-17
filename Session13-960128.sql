CREATE DATABASE Session13
GO
USE Session13
GO
SELECT ProductId, Name,Color,ListPrice
INTO Product
FROM AdventureWorks2016CTP3.Production.Product
GO
ALTER TABLE Product
ADD CONSTRAINT PK_ProductId PRIMARY KEY(ProductId)
GO
DECLARE product_cursor CURSOR
KEYSET
FOR
SELECT ProductId, Name,Color, ListPrice
FROM Product

OPEN product_cursor
DECLARE @productId INT
DECLARE @name NVARCHAR(50)
DECLARE @color NVARCHAR(50)
DECLARE @listPrice DECIMAL(10,2)

FETCH NEXT FROM product_cursor INTO @productId,@name,@color,@listPrice
SELECT @productId 'ProductId',@name 'Name',@color 'Color',@listPrice 'ListPrice', @@FETCH_STATUS 'FetchStatus'

CLOSE product_cursor
DEALLOCATE product_cursor

GO
SELECT * FROM Product
GO
DELETE FROM Product WHERE ProductId = 321
GO
UPDATE Product SET Name = 'My Product' WHERE ProductId = 319
GO
INSERT INTO Product VALUES(2, 'Sample Product', 'Red', 1000)

GO
CREATE TABLE Account
(
	Id INT PRIMARY KEY,
	HolderName NVARCHAR(50),
	Balance INT
)
GO
INSERT INTO Account VALUES(1,'John', 1000),(2,'David',1000)
GO
CREATE PROC USP_ResetAccounts
AS
BEGIN 
	TRUNCATE TABLE Account
	INSERT INTO Account VALUES(1,'John', 1000),(2,'David',1000)
END
GO
EXEC USP_ResetAccounts
GO
SELECT * FROM Account
GO
BEGIN TRAN
SET XACT_ABORT ON
UPDATE Account SET Balance = 500 WHERE Id = 1
SELECT 10/0
UPDATE Account SET Balance = 1500 WHERE Id = 2

--ROLLBACK TRAN
COMMIT TRAN
SELECT * FROM Account
GO
EXEC USP_ResetAccounts
GO
SELECT * FROM Account
GO
BEGIN TRAN
SET XACT_ABORT ON
UPDATE Account SET Balance = 500 WHERE Id = 1
UPDATE Account SET Balance = 'abcd' WHERE Id = 2

--ROLLBACK TRAN
COMMIT TRAN
SELECT * FROM Account

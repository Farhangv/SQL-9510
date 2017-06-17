CREATE DATABASE Session12
GO
USE Session12
GO
SELECT ProductId, Name, Color, ListPrice
INTO Product
FROM AdventureWorks2016CTP3.Production.Product
GO
CREATE TRIGGER TG_Product_DEL
ON Product
FOR DELETE
AS
BEGIN
	ROLLBACK TRAN
END
GO
SELECT * FROM Product
GO
DELETE FROM Product WHERE ProductId = 1
GO
CREATE TABLE DeletedProducts
(
	Id INT PRIMARY KEY,
	Name NVARCHAR(50),
	Color NVARCHAR(50),
	ListPrice DECIMAL(10,2),
	DeletedDate DATETIME DEFAULT GETDATE()
)
GO
ALTER TRIGGER TG_Product_DEL
ON Product
FOR DELETE
AS
BEGIN
	INSERT INTO DeletedProducts(Id,Name,Color,ListPrice)
	SELECT * FROM deleted
END
GO
DELETE FROM Product WHERE ProductId = 1
GO
SELECT * FROM Product
GO
SELECT * FROM DeletedProducts
GO
DROP TRIGGER TG_Product_DEL
GO
ALTER TABLE Product
ADD IsDeleted BIT DEFAULT 0
GO
CREATE TRIGGER TG_Product_DEL
ON Product
INSTEAD OF DELETE
AS
BEGIN
	UPDATE Product SET IsDeleted = 1
	WHERE ProductId IN 
	(
		SELECT ProductId
		FROM deleted
	)
END
GO
DELETE FROM Product WHERE ProductId BETWEEN 2 AND 10
GO
SELECT * FROM Product
GO 
DROP TRIGGER TG_Product_DEL
GO
CREATE TRIGGER TG_Product_DEL
ON Product
FOR DELETE
AS
BEGIN
	IF EXISTS(SELECT * FROM deleted WHERE ProductId BETWEEN 500 AND 800)
	BEGIN
		ROLLBACK TRAN
	END
END
GO
DELETE FROM Product WHERE ProductId = 2
GO
SELECT * FROM Product
GO
DELETE FROM Product WHERE ProductId = 535
GO
SELECT * FROM Product
GO
DROP TRIGGER TG_Product_DEL
GO
CREATE TRIGGER TG_Product_DEL
ON Product
INSTEAD OF DELETE
AS
BEGIN
	IF EXISTS(SELECT * FROM deleted WHERE ProductId BETWEEN 500 AND 800)
	BEGIN
		DELETE FROM Product WHERE ProductId IN (SELECT ProductId FROM deleted) 
		AND 
		ProductId NOT IN (SELECT ProductId FROM deleted WHERE ProductId BETWEEN 500 AND 800)
	END
	ELSE
	BEGIN
		DELETE FROM Product WHERE ProductId IN (SELECT ProductId FROM deleted)
	END
END

GO
DELETE FROM Product WHERE ProductId IN (3,850,535)
GO
SELECT * FROM Product
GO
CREATE TRIGGER TG_DropDatabaseBan
ON ALL SERVER
FOR DROP_DATABASE
AS
BEGIN
	ROLLBACK TRAN
END
GO
DROP DATABASE Session11
GO
ALTER TRIGGER TG_DropDatabaseBan
ON ALL SERVER
FOR DROP_DATABASE
AS
BEGIN
	DECLARE @EVENTDATA XML
	SET @EVENTDATA = EVENTDATA()
	--SELECT @EVENTDATA
	DECLARE @DATABASENAME NVARCHAR(50)
	SET @DATABASENAME = CONVERT(NVARCHAR(50), @EVENTDATA.query('data(/EVENT_INSTANCE/DatabaseName)'))
	IF @DATABASENAME = 'Session11'
	BEGIN
	ROLLBACK TRAN
	END
END
GO
DROP DATABASE Session10
GO
DROP TRIGGER TG_DropDatabaseBan
ON ALL SERVER
GO
CREATE TRIGGER TG_CreateAlterTable
ON DATABASE 
FOR CREATE_TABLE, ALTER_TABLE
AS
BEGIN
	SELECT EVENTDATA()
END
GO
CREATE TABLE [User]
(
	Id INT PRIMARY KEY,
	Name NVARCHAR(50),
	Family NVARCHAR(50)
)
GO
DECLARE @path NVARCHAR(200)
DECLARE @filepath NVARCHAR(250)
SET @path = 'd:\backupsamples\'
DECLARE db_cursor CURSOR
FOR
SELECT [name],database_id FROM sys.databases
WHERE [name] NOT IN ('master','tempdb','model','msdb')

OPEN db_cursor
DECLARE @dbname NVARCHAR(50)
DECLARE @dbid INT

FETCH NEXT FROM db_cursor INTO @dbname,@dbid
SET @filepath = @path + @dbname + '.bak'
BACKUP DATABASE @dbname TO DISK = @filepath
PRINT 'database ' + @dbname + 'backed up into ' + @filepath

WHILE @@FETCH_STATUS = 0
BEGIN
	FETCH NEXT FROM db_cursor INTO @dbname,@dbid
	SET @filepath = @path + @dbname + '.bak'
	BACKUP DATABASE @dbname TO DISK = @filepath
	PRINT 'database ' + @dbname + 'backed up into ' + @filepath

END
CLOSE db_cursor
DEALLOCATE db_cursor
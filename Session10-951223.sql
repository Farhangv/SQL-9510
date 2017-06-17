USE AdventureWorks2016CTP3
GO
ALTER FUNCTION GetProductsByPage
(
	@PageNo INT,
	@PageSize INT
)
RETURNS @Result TABLE 
(
	RowNumber INT,
	ProductId INT,
	Name NVARCHAR(50),
	Color NVARCHAR(50)
)
AS
BEGIN
	
	WITH Q
	AS
	(
		SELECT ROW_NUMBER() OVER (ORDER BY Name) 'Row', ProductId, Name,Color
		FROM Production.Product
	)
	INSERT INTO @Result
	SELECT * FROM Q
	WHERE [Row] BETWEEN ((@PageNo - 1) * @PageSize) + 1 AND @PageNo * @PageSize

	RETURN
END

GO
SELECT * FROM 
GetProductsByPage(2,20)
GO
EXEC sp_executesql N'SELECT * FROM Production.Product'
GO
CREATE FUNCTION UDF_Test
()
RETURNS @R TABLE (Id INT)
AS
BEGIN
	EXEC sp_executesql N'SELECT * FROM Production.Product'
	RETURN
END
SELECT * FROM UDF_Test
GO
DECLARE @R INT
EXEC @R = sp_executesql N'SELECT * FROM Production.Product'
SELECT @R
GO
CREATE DATABASE Session10
GO
USE Session10
GO
CREATE TABLE [User]
(
	UserId INT IDENTITY PRIMARY KEY,
	Username NVARCHAR(50),
	[Password] NVARCHAR(70),
	BirthDate DATETIME,
	Age AS YEAR(GETDATE()) - YEAR(BirthDate)
)
GO
CREATE PROC User_Insert
(
	@Username NVARCHAR(50),
	@Password NVARCHAR(50),
	@BirthDate DATETIME
)
AS
BEGIN
	INSERT INTO [User](Username,Password,BirthDate) VALUES 
	(
	@Username,
	HASHBYTES('md5',@Password), 
	@BirthDate
	)
END
GO
EXEC User_Insert 'john', '123', '1950/10/10'
Go
SELECT * FROM [User]
GO
CREATE PROC User_Select
(
	@Id INT
)
AS
BEGIN
	SELECT * FROM [User] WHERE UserId = @Id
END
Go
CREATE PROC User_Update
(
	@Id INT,
	@Username NVARCHAR(50),
	@Password NVARCHAR(50),
	@BirthDate DATETIME
)
AS
BEGIN
	UPDATE [User] SET Username = @Username, Password = HASHBYTES('md5',@Password) , BirthDate = @BirthDate
	WHERE UserID = @Id
END
GO
CREATE PROC User_Delete
(
	@Id INT
)
AS
BEGIN
	DELETE FROM [User] WHERE UserId = @Id
END
GO
EXEC User_Select 1
GO
EXEC User_Update 1 , 'Sarah','987654', '1990/10/10'
GO
USE Session10
GO
CREATE PROC GetUsersByPage
(
	@PageNo INT,
	@PageSize INT,
	@SortColumn NVARCHAR(50)
)
AS
BEGIN
	DECLARE @Query NVARCHAR(1000)
	SET @Query =
	N'WITH Q ' +
	N'AS ' +
	N'( '+
	N'	SELECT ROW_NUMBER() OVER(ORDER BY '+ @SortColumn + N') AS [Row], * FROM [User] '+
	N') '+
	N'SELECT * FROM Q '+
	N'WHERE [Row] BETWEEN (('+CONVERT(NVARCHAR(50),@PageNo)+N' - 1) * '+ CONVERT(NVARCHAR(50),@PageSize) +N' + 1) AND '+CONVERT(NVARCHAR(50),@PageNo)+N' * '+CONVERT(NVARCHAR(50),@PageSize)+N'; '
	EXEC sp_executesql @Query
END
GO
EXEC User_Insert 'john', '123', '1950/10/10'
EXEC User_Insert 'Adam', '123', '1950/10/10'
EXEC User_Insert 'Sarah', '123', '1950/10/10'
EXEC User_Insert 'David', '123', '1950/10/10'
GO
EXEC GetUsersByPage 1,3,'Username DESC'

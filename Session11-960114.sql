CREATE DATABASE Session11
GO
USE Session11
GO
CREATE TABLE Student
(
	Id INT IDENTITY PRIMARY KEY,
	Username NVARCHAR(10) UNIQUE,
	[PasswordHash] NVARCHAR(50)
)
GO
SET NOCOUNT ON
BEGIN TRY
	INSERT INTO Student(Username,PasswordHash) VALUES ('Ali', HASHBYTES('md5', '123'))
	SELECT ERROR_NUMBER()
END TRY
BEGIN CATCH
	PRINT N'خطایی در افزودن کاربر بوجود آمده'
	SELECT ERROR_NUMBER() 'ErrorNo', ERROR_MESSAGE() 'ErrorMsg', ERROR_SEVERITY() 'ErrorSvr', ERROR_STATE() 'ErrorSt'
END CATCH

GO
BEGIN TRY
	SELECT 10/0
END TRY
BEGIN CATCH
	SELECT N'خطایی در محاسبات ریاضی بوجود آمده'
END CATCH
GO
CREATE TABLE ErrorLog
(
	Id INT PRIMARY KEY IDENTITY,
	ErrorNumber INT,
	ErrorMessage NVARCHAR(300)
)
GO
ALTER TABLE ErrorLog
ADD ErrorDate DATETIME
GO
ALTER PROC USP_Insert_User
(
	@Username NVARCHAR(50),
	@Password NVARCHAR(50),
	@ErrorNumber INT OUTPUT,
	@ErrorMessage NVARCHAR(300) OUTPUT,
	@ErrorRefCode INT OUTPUT
)
AS
BEGIN
SET NOCOUNT ON
BEGIN TRY
	INSERT INTO Student(Username,PasswordHash) VALUES (@Username, HASHBYTES('md5',@Password))
	RETURN SCOPE_IDENTITY()
END TRY
BEGIN CATCH
	--PRINT N'خطایی در افزودن کاربر بوجود آمده'
	--PRINT ERROR_NUMBER() 
	--PRINT ERROR_MESSAGE()
	SET @ErrorNumber = ERROR_NUMBER()
	SET @ErrorMessage = ERROR_MESSAGE()
	INSERT INTO ErrorLog(ErrorNumber,ErrorMessage,ErrorDate) VALUES (ERROR_NUMBER(),ERROR_MESSAGE(),GETDATE())
	--PRINT N'کد پیگیری خطای شما :‌'
	--PRINT SCOPE_IDENTITY()
	SET @ErrorRefCode = SCOPE_IDENTITY()
END CATCH

END
GO
EXEC USP_Insert_User 'Reza', '123'
GO
SELECT * FROM ErrorLog
WHERE Id = 1
GO
DECLARE @UserId INT
EXEC @UserId = USP_Insert_User 'Johnny', '456'
IF(@UserId > 0)
BEGIN
PRINT N'کاربر با کد کاربری زیر تعریف شد ' 
PRINT @UserId
END
GO
SELECT * FROM Student
GO
DECLARE @UserId INT
DECLARE @ErrNo INT
DECLARE @ErrMsg NVARCHAR(300)
DECLARE @RefCode INT
EXEC @UserId = USP_Insert_User 'Johnny2', '456', @ErrNo OUTPUT, @ErrMsg OUTPUT, @RefCode OUTPUT
IF(@UserId > 0) --کاربر با موفقیت ثبت شده
BEGIN
PRINT N'کاربر با کد کاربری زیر تعریف شد ' 
PRINT @UserId
END
ELSE
BEGIN
SELECT @ErrNo 'ErrorNumber',@ErrMsg 'ErrorMessage', @RefCode 'ReferenceCode'
END
GO
USE AdventureWorks2016CTP3
GO
CREATE PROC USP_GetProductsByPage
(
	@PageNo INT,
	@RecordsPerPage INT,
	@TotalPages INT OUTPUT,
	@TotalRecords INT OUTPUT
)
AS
BEGIN
	WITH Q
	AS
	(
	SELECT ROW_NUMBER() OVER(ORDER BY ProductId) 'Row', ProductId, Name, Color, ListPrice
	FROM Production.Product
	)
	SELECT * FROM Q
	WHERE [Row] BETWEEN ((@PageNo - 1) * @RecordsPerPage) + 1 AND @PageNo * @RecordsPerPage
	SELECT @TotalRecords = COUNT(*) FROM Production.Product
	IF(@TotalRecords % @RecordsPerPage = 0)
	BEGIN
		SET @TotalPages = @TotalRecords / @RecordsPerPage
	END
	ELSE
	BEGIN 
		SET @TotalPages = (@TotalRecords / @RecordsPerPage) + 1
	END
END
GO
DECLARE @TotalRecords INT
DECLARE @TotalPages INT
EXEC USP_GetProductsByPage 5,10, @TotalPages OUTPUT, @TotalRecords OUTPUT
PRINT N'Total Records : ' + CONVERT(NVARCHAR(50), @TotalRecords)
PRINT N'Total Pages : ' + CONVERT(NVARCHAR(50), @TotalPages)
GO

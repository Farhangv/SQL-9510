SELECT 'SQL'
GO 10
USE [model]
GO
CREATE TABLE Test
(
	Id INT IDENTITY PRIMARY KEY,
	Name NVARCHAR(50)
)
GO
CREATE DATABASE [Session07]
GO
INSERT INTO Test VALUES('jkdsaaaaahkjsahdkjashdkjhaskjdhasjkdhkajshdkashdkjashdkjashdkjashdkjashdkashdkhasdkjhaskdhaskdhaskdhaskdhkashdkashdkashdkjashdkjashdkjashdkjashdkashdkasjhdkajshdkasjhdkjasdashd')
INSERT INTO Test VALUES('C#')
GO
SELECT * FROM Test
GO
CREATE DATABASE Session072
GO
DROP DATABASE Session07
GO
CREATE DATABASE Session07
ON
(
	Name = 'session07_data',
	FileName = 'd:\databases\session07_data.mdf',
	Size = 5MB,
	FileGrowth = 10MB,
	MaxSize = 50MB
)
LOG ON
(
	Name = 'session07_log',
	FileName = 'd:\databases\session07_log.ldf',
	Size = 10MB,
	FileGrowth = 10%,
	MaxSize = 50MB
)
GO
DROP DATABASE Session07
GO
CREATE DATABASE Session07
GO
USE Session07
GO
CREATE TABLE Person
(
	PersonId INT PRIMARY KEY IDENTITY(100,2),
	Name NVARCHAR(50),
	Family NVARCHAR(50),
	NationalCode CHAR(10),
	CreatedDate DATETIME,
	ModifiedDate DATETIME
)
GO
INSERT INTO Person VALUES(N'پیام', N'پیامی', '1234567890', GETDATE(), GETDATE())
GO
SELECT * FROM Person
GO
CREATE TABLE Score
(
	StudentId INT,
	TermId INT,
	CourseId INT,
	Score DECIMAL(4,2),
	PRIMARY KEY(StudentId, TermId, CourseId)
)
GO
DROP TABLE Score
GO
CREATE TABLE Score
(
	StudentId INT,
	TermId INT,
	CourseId INT,
	Score DECIMAL(4,2),
	CONSTRAINT PK_Score_StudentId_CourseId_TermId
	PRIMARY KEY(StudentId, TermId, CourseId)
)


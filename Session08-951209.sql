CREATE DATABASE Session08
GO
USE Session08
GO
CREATE TABLE Student
(
	Id INT PRIMARY KEY IDENTITY,
	Name NVARCHAR(50) NOT NULL,
	Username NVARCHAR(50) NOT NULL,
	Email NVARCHAR(50) NOT NULL UNIQUE, --CHECK(Email LIKE '%@%.%'),
	CreateDate DATETIME NOT NULL DEFAULT(GETDATE()),
	--UNIQUE(Name, Username)
	CONSTRAINT UQ_Username UNIQUE(Username),
	CONSTRAINT CHK_Email CHECK(Email LIKE '%@%.%')
)
GO
--DROP TABLE Student
GO
INSERT INTO Student(Name, Username, Email)
VALUES('John', 'JohnDoe','john@doe.com')
GO
SELECT * FROM Student
GO
CREATE TABLE #User --Temp Table
(
	Id INT PRIMARY KEY IDENTITY,
	Name NVARCHAR(50) NOT NULL,
	Family NVARCHAR(50)
)
GO
INSERT INTO #User VALUES('John', 'Doe')
GO
SELECT * FROM #User
GO
CREATE TABLE ##User --Temp Table
(
	Id INT PRIMARY KEY IDENTITY,
	Name NVARCHAR(50) NOT NULL,
	Family NVARCHAR(50)
)
GO
INSERT INTO ##User VALUES('John', 'Doe')
GO
SELECT * FROM ##User
GO
INSERT INTO ##User
SELECT FirstName, LastName
FROM AdventureWorks2016CTP3.Person.Person
GO
DROP TABLE Student
GO
CREATE TABLE Person
(
	Id INT PRIMARY KEY,
	Name NVARCHAR(50),
	Family NVARCHAR(50)
)
GO
CREATE TABLE Student
(
	Id INT PRIMARY KEY IDENTITY,
	PersonId INT NOT NULL FOREIGN KEY REFERENCES Person(Id) ON DELETE NO ACTION ON UPDATE CASCADE,
	StudentCode NVARCHAR(6),
	Grade NVARCHAR(10)
)
GO
CREATE TABLE Teacher
(
	Id INT PRIMARY KEY IDENTITY,
	PersonId INT NOT NULL,
	Field NVARCHAR(20),
	Rate DECIMAL(10,2),
	CONSTRAINT FK_PersonId FOREIGN KEY(PersonId) REFERENCES Person(Id) ON UPDATE CASCADE ON DELETE NO ACTION
)
GO
CREATE TABLE Course
(
	Id INT IDENTITY PRIMARY KEY,
	TeacherId INT NOT NULL,
	Name NVARCHAR(50),
	Hours INT,
	Code NVARCHAR(6),
	CONSTRAINT FK_TeacherId FOREIGN KEY(TeacherId) REFERENCES Teacher(Id)
)
GO
CREATE TABLE Student_Course
(
	CourseId INT FOREIGN KEY REFERENCES Course(Id),
	StudentId INT FOREIGN KEY REFERENCES Student(Id),
	PRIMARY KEY(CourseId,StudentId)
)
GO
ALTER TABLE Person
ADD BirthDate DATETIME NOT NULL DEFAULT(GETDATE()),
	NationalCode NVARCHAR(12)
GO
ALTER TABLE Person
ALTER COLUMN NationalCode NVARCHAR(10)
GO
ALTER TABLE Person
DROP COLUMN NationalCode
GO
EXEC sp_rename 'Person.BirthDate', 'DOB', 'COLUMN'
GO
EXEC sp_rename 'Person', 'People'
GO
EXEC sp_rename 'People', 'Person'


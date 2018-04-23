--CREATE DATABASE Teachers
--GO
--USE Teachers
--GO

--CREATE TABLE Post
--(
--	Id int IDENTITY(1,1),
--	+AFs-Name+AF0- nvarchar(20) NOT NULL,

--	CONSTRAINT PK+AF8-PostId PRIMARY KEY (Id)
--)

--CREATE TABLE Teacher
--(
--	Id int IDENTITY(1,1),
--	+AFs-Name+AF0- nvarchar(15) NOT NULL,
--	Code char(10) NOT NULL,
--	IdPost int NOT NULL,
--	Tel char(7) NOT NULL,
--	Salary int NOT NULL,
--	Rise numeric(6,2) NOT NULL,
--	HireDate datetime NOT NULL,

--	CONSTRAINT PK+AF8-TeacherId PRIMARY KEY (Id),
--	CONSTRAINT FK+AF8-IdPost FOREIGN KEY (IdPost) REFERENCES Post(Id)
--)

--ALTER TABLE Teacher
--DROP CONSTRAINT FK+AF8-IdPost

--ALTER TABLE Teacher
--DROP COLUMN IdPost

--DROP TABLE Post

--ALTER TABLE Teacher
--ADD CONSTRAINT CK+AF8-Teacher+AF8-HireDate CHECK(HireDate +AD4- N'19900101')

--ALTER TABLE Teacher
--ADD CONSTRAINT UC+AF8-TeacherCode UNIQUE (Code)

--ALTER TABLE Teacher
--ALTER COLUMN Salary numeric(6,2) NOT NULL

--ALTER TABLE Teacher
--ADD CONSTRAINT CK+AF8-Teacher+AF8-SalaryLim CHECK(1000 +ADwAPQ- Salary AND Salary +ADwAPQ- 5000)

--EXEC sp+AF8-rename N'Teacher.Tel', N'Phone', N'COLUMN'

--ALTER TABLE Teacher
--ALTER COLUMN Phone char(11) NOT NULL

--CREATE TABLE Post
--(
--	Id int IDENTITY(1,1),
--	+AFs-Name+AF0- nvarchar(20) NOT NULL,

--	CONSTRAINT PK+AF8-PostId PRIMARY KEY (Id)
--)

--ALTER TABLE Post
--ADD CONSTRAINT CK+AF8-Post+AF8-NameLim CHECK(+AFs-Name+AF0- +AD0- N'+BD8EQAQ+BEQENQRBBEEEPgRA-' OR +AFs-Name+AF0- +AD0- N'+BDQEPgRGBDUEPQRC-' OR +AFs-Name+AF0- +AD0- N'+BD8EQAQ1BD8EPgQ0BDAEMgQwBEIENQQ7BEw-' OR +AFs-Name+AF0- +AD0- N'+BDAEQQRBBDgEQQRCBDUEPQRC-')

--ALTER TABLE Teacher
--ADD CONSTRAINT CK+AF8-Post+AF8-NameLimWithNum CHECK(+AFs-Name+AF0- LIKE N'+ACUAWwBe-0-9+AF0AJQ-')

--ALTER TABLE Teacher
--ADD IdPost int NOT NULL

--ALTER TABLE Teacher
--ADD CONSTRAINT FK+AF8-Teacher+AF8-IdPost FOREIGN KEY (IdPost) REFERENCES Post(Id)

--SET IDENTITY+AF8-INSERT Post ON

--INSERT INTO Post(Id,Name) VALUES(1,N'+BB8EQAQ+BEQENQRBBEEEPgRA-')+ADs-
--INSERT INTO post(Id,Name) VALUES(2,N'+BBQEPgRGBDUEPQRC-')+ADs-
--INSERT INTO post(Id,Name) VALUES(3,N'+BB8EQAQ1BD8EPgQ0BDAEMgQwBEIENQQ7BEw-')+ADs-
--INSERT INTO post(Id,Name) VALUES(4,N'+BBAEQQRBBDgEQQRCBDUEPQRC-')+ADs-

--SET IDENTITY+AF8-INSERT Teacher ON

--ALTER TABLE Teacher
--ALTER COLUMN Phone char(11) NULL

--ALTER TABLE Teacher
--ALTER COLUMN Code char(10) NULL

--INSERT INTO Teacher (Id, +AFs-Name+AF0-, Code, IdPost, phone, Salary, Rise, HireDate)
--VALUES (1, N'+BCEEOAQ0BD4EQAQ+BDI-','0123456789', 1, NULL, 1070, 470, '01.09.1992')+ADs-
--INSERT INTO TEACHER (Id, +AFs-Name+AF0-, Code, IdPost, phone, Salary, Rise, HireDate)
--VALUES (2, N'+BCAEMAQ8BDgESAQ1BDIEQQQ6BDgEOQ-','4567890123', 2, '4567890', 1110, 370, '09.09.1998')+ADs-
--INSERT INTO TEACHER (Id, +AFs-Name+AF0-, Code, IdPost, phone, Salary, Rise, HireDate)
--VALUES (3, N'+BCUEPgRABDUEPQQ6BD4-','1234567890', 3, NULL, 2000, 230, '10.10.2001')+ADs-
--INSERT INTO TEACHER (Id, +AFs-Name+AF0-, Code, IdPost, phone, Salary, Rise, HireDate)
--VALUES (4, N'+BBIEOAQxBEAEPgQyBEEEOgQ4BDk-','2345678901', 4, NULL, 4000, 170, '01.09.2003')+ADs-
--INSERT INTO TEACHER (Id, +AFs-Name+AF0-, Code, IdPost, phone, Salary, Rise, HireDate)
--VALUES (5, N'+BBIEPgRABD4EPwQwBDUEMg-',NULL, 4, NULL, 1500, 150, '02.09.2002')+ADs-
--INSERT INTO TEACHER (Id, +AFs-Name+AF0-, Code, IdPost, phone, Salary, Rise, HireDate)
--VALUES (6, N'+BBoEQwQ3BDgEPQRGBDUEMg-','5678901234', 3, '4567890', 3000, 270, '01.01.1991')+ADs-

--CREATE VIEW PostName
--AS
--SELECT Post.+AFs-Name+AF0-
--FROM Post

--CREATE VIEW TeachersLastName
--AS
--SELECT Teacher.+AFs-Name+AF0-
--FROM Teacher

--CREATE VIEW IdNamePostSal ??
--AS
--SELECT TOP 100 PERCENT Teacher.Id, Teacher.+AFs-Name+AF0-, Post.+AFs-Name+AF0- AS PostName, Teacher.Salary
--FROM Teacher JOIN Post
--	ON Teacher.IdPost +AD0- Post.Id
--ORDER BY Teacher.Salary

--CREATE VIEW IdNamePhone
--AS
--SELECT Teacher.Id, Teacher.+AFs-Name+AF0-, Teacher.Phone
--FROM Teacher
--WHERE Teacher.Phone IS NOT NULL

--CREATE VIEW NamePostDateForm
--AS
--SELECT Teacher.+AFs-Name+AF0-, Post.+AFs-Name+AF0- AS PostName, FORMAT(Teacher.HireDate, N'dd/MM/yy') AS HireDate
--FROM Teacher JOIN Post
--	ON Teacher.IdPost +AD0- Post.Id

--CREATE VIEW NamePostDateFormMonthName
--AS
--SELECT Teacher.+AFs-Name+AF0-, Post.+AFs-Name+AF0- AS PostName, FORMAT(Teacher.HireDate, N'dd/MMM/yy') AS HireDate
--FROM Teacher JOIN Post
--	ON Teacher.IdPost +AD0- Post.Id
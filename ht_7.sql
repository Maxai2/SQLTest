-- 1. Создать базу данных «Преподаватели» и добавить в неё две таблицы.

--CREATE DATABASE Teachers
--GO
--USE Teachers
--GO

--CREATE TABLE Post
--(
--	Id int IDENTITY(1,1),
--	[Name] nvarchar(20) NOT NULL,

--	CONSTRAINT PK_PostId PRIMARY KEY (Id)
--)

--CREATE TABLE Teacher
--(
--	Id int IDENTITY(1,1),
--	[Name] nvarchar(15) NOT NULL,
--	Code char(10) NOT NULL,
--	IdPost int NOT NULL,
--	Tel char(7) NOT NULL,
--	Salary int NOT NULL,
--	Rise numeric(6,2) NOT NULL,
--	HireDate datetime NOT NULL,

--	CONSTRAINT PK_TeacherId PRIMARY KEY (Id),
--	CONSTRAINT FK_IdPost FOREIGN KEY (IdPost) REFERENCES Post(Id)
--)

-- 2. Удалить таблицу «POST».

--ALTER TABLE Teacher
--DROP CONSTRAINT FK_IdPost

--DROP TABLE Post

-- 3. В таблице «TEACHER» удалить столбец «IdPost».

--ALTER TABLE Teacher
--DROP COLUMN IdPost

-- 4. Для столбца «HireDate» создать ограничение: дата приёма на работу должна быть не меньше 01.01.1990.

--ALTER TABLE Teacher
--ADD CONSTRAINT CK_Teacher_HireDate CHECK(HireDate > N'19900101')

-- 5. Создать ограничение уникальности для столбца «Code».

--ALTER TABLE Teacher
--ADD CONSTRAINT UC_TeacherCode UNIQUE (Code)

-- 6. Изменить тип данных в поле Salary c INTEGER на NUMERIC(6,2).

--ALTER TABLE Teacher
--ALTER COLUMN Salary numeric(6,2) NOT NULL

-- 7. Добавить в таблицу «TEACHER» следующее ограничение: зарплата не должна быть ниже 1000, но и не должна превышать 5000.

--ALTER TABLE Teacher
--ADD CONSTRAINT CK_Teacher_SalaryLim CHECK(1000 <= Salary AND Salary <= 5000)

-- 8. Переименовать столбец Tel на Phone.

--EXEC sp_rename N'Teacher.Tel', N'Phone', N'COLUMN'

-- 9. Изменить тип данных в поле Phone с CHAR(7) на CHAR(11).

--ALTER TABLE Teacher
--ALTER COLUMN Phone char(11) NOT NULL

-- 10. Создать снова таблицу «POST».

--CREATE TABLE Post
--(
--	Id int IDENTITY(1,1),
--	[Name] nvarchar(20) NOT NULL,

--	CONSTRAINT PK_PostId PRIMARY KEY (Id)
--)

-- 11. Для поля Name таблицы «POST» задать ограничение на должность (профессор, доцент, преподаватель или ассистент).

--ALTER TABLE Post
--ADD CONSTRAINT CK_Post_NameLim CHECK([Name] = N'профессор' OR [Name] = N'доцент' OR [Name] = N'преподаватель' OR [Name] = N'ассистент')

-- 12. Для поля Name таблицы «TEACHER» задать ограничение, в котором запретить наличие цифр в фамилии преподавателя.

--ALTER TABLE Teacher
--ADD CONSTRAINT CK_Post_NameLimWithNum CHECK([Name] LIKE N'%[^0-9]%')

-- 13. Добавить столбец IdPost (int) в таблицу «TEACHER».

--ALTER TABLE Teacher
--ADD IdPost int NOT NULL

-- 14. Связать поле IdPost таблицы «TEACHER» c полем Id таблицы «POST».

--ALTER TABLE Teacher
--ADD CONSTRAINT FK_Teacher_IdPost FOREIGN KEY (IdPost) REFERENCES Post(Id)

-- 15. Заполнить обе таблицы данными.

--SET IDENTITY_INSERT Post ON

--INSERT INTO Post(Id,Name) VALUES(1,N'Профессор');
--INSERT INTO post(Id,Name) VALUES(2,N'Доцент');
--INSERT INTO post(Id,Name) VALUES(3,N'Преподаватель');
--INSERT INTO post(Id,Name) VALUES(4,N'Ассистент');

--SET IDENTITY_INSERT Teacher ON

--ALTER TABLE Teacher
--ALTER COLUMN Phone char(11) NULL

--ALTER TABLE Teacher
--ALTER COLUMN Code char(10) NULL

--INSERT INTO TEACHER (Id, Name, Code, IdPost, phone, Salary, Rise, HireDate)
--VALUES (1, N'Сидоров','0123456789', 1, NULL, 1070, 470, '01.09.1992');
--INSERT INTO TEACHER (Id, Name, Code, IdPost, phone, Salary, Rise, HireDate)
--VALUES (2, N'Рамишевский','4567890123', 2, '4567890', 1110, 370, '09.09.1998');
--INSERT INTO TEACHER (Id, Name, Code, IdPost, phone, Salary, Rise, HireDate)
--VALUES (3, N'Хоренко','1234567890', 3, NULL, 2000, 230, '10.10.2001');
--INSERT INTO TEACHER (Id, Name, Code, IdPost, phone, Salary, Rise, HireDate)
--VALUES (4, N'Вибровский','2345678901', 4, NULL, 4000, 170, '01.09.2003');
--INSERT INTO TEACHER (Id, Name, Code, IdPost, phone, Salary, Rise, HireDate)
--VALUES (5, N'Воропаев',NULL, 4, NULL, 1500, 150, '02.09.2002');
--INSERT INTO TEACHER (Id, Name, Code, IdPost, phone, Salary, Rise, HireDate)
--VALUES (6, N'Кузинцев','5678901234', 3, '4567890', 3000, 270, '01.01.1991');

/*16. Cоздать представления:

16.1. Все названия должностей.*/

--CREATE VIEW PostName
--AS
--SELECT Post.[Name]
--FROM Post

/*16.2. Все фамилии учителей. */

--CREATE VIEW TeachersLastName
--AS
--SELECT Teacher.[Name]
--FROM Teacher

/*16.3. Идентификатор, фамилия учителя, его должность, общая з\п (сортировать по з\п). ? */

--CREATE VIEW IdNamePostSal 
--AS
--SELECT Teacher.Id, Teacher.[Name], Post.[Name] AS PostName, Teacher.Salary AS Salary
--FROM Teacher JOIN Post
--	ON Teacher.IdPost = Post.Id

--SELECT *
--FROM IdNamePostSal
--ORDER BY Salary

/*16.4. Идентификационный номер, фамилия, номер телефона (только те, у кого есть номер телефона).*/

--CREATE VIEW IdNamePhone
--AS
--SELECT Teacher.Id, Teacher.[Name], Teacher.Phone
--FROM Teacher
--WHERE Teacher.Phone IS NOT NULL


/*16.5. Фамилия, должность, дата приема в формате дд/мм/гг. */

--CREATE VIEW NamePostDateForm
--AS
--SELECT Teacher.[Name], Post.[Name] AS PostName, FORMAT(Teacher.HireDate, N'dd/MM/yy') AS HireDate
--FROM Teacher JOIN Post
--	ON Teacher.IdPost = Post.Id


/* 16.6. Фамилия, должность, дата приема в формате дд месяц_текстом гггг.*/

--CREATE VIEW NamePostDateFormMonthName
--AS
--SELECT Teacher.[Name], Post.[Name] AS PostName, FORMAT(Teacher.HireDate, N'dd/MMM/yy') AS HireDate
--FROM Teacher JOIN Post
--	ON Teacher.IdPost = Post.Id

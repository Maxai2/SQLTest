--CREATE DATABASE Academy_ru
--GO
--USE Academy_ru
--GO


--CREATE TABLE Employees
--(
--	Id int IDENTITY(1, 1),
--	First_Name nvarchar(15) NOT NULL,
--	Last_Name nvarchar(15) NOT NULL,
--	Birth_Date date NOT NULL,
--	Number nvarchar(20) NULL,
--	Email nvarchar(30) NULL,

--	CONSTRAINT PK_Employee_Id PRIMARY KEY (Id)
--)
--GO
--CREATE TABLE Post
--(
--	Id int IDENTITY(1, 1),
--	Post_Name nvarchar(30) NOT NULL,

--	CONSTRAINT PK_Post_Id PRIMARY KEY (Id)
--)
--GO
--CREATE TABLE Post_Employees
--(
--	Employees_Id int NOT NULL,
--	Post_Id int NOT NULL,
--	Amount int NOT NULL,
--	[State] bit NOT NULL,

--	CONSTRAINT FK_Empployees_Id FOREIGN KEY (Employees_Id) REFERENCES Employees(Id),
--	CONSTRAINT FK_Employees_Post_Id FOREIGN KEY (Post_Id) REFERENCES Post(Id),
--	CONSTRAINT CK_Post_Employees_Amount_Lim CHECK(Amount > 0)
--)
--GO
--CREATE TABLE Faculty
--(
--	Id int IDENTITY(1, 1),
--	Faculty_Name nvarchar(30) NOT NULL,
--	Owner_Id int NOT NULL,
	
--	CONSTRAINT PK_Faculty_Id PRIMARY KEY (Id),
--	CONSTRAINT FK_Faculty_Owner_Id FOREIGN KEY (Owner_Id) REFERENCES Employees(Id)
--)
--GO
--CREATE TABLE [Group]
--(
--	Id int IDENTITY(1, 1),
--	Group_Name nvarchar(15) NOT NULL,
--	Cource int NOT NULL,
--	Fakulty_Id int NOT NULL,
	
--	CONSTRAINT PK_Group_Id PRIMARY KEY (Id),
--	CONSTRAINT FK_Group_Fakulty_Id FOREIGN KEY (Fakulty_Id) REFERENCES Faculty(Id),
--	CONSTRAINT CK_Group_CourceLim CHECK(0 < Cource AND Cource < 5) 
--)
--GO
--CREATE TABLE Student
--(
--	Id int IDENTITY(1, 1),
--	First_Name nvarchar(15) NOT NULL,
--	Last_Name nvarchar(15) NOT NULL,
--	Birth_Date date NOT NULL,
--	Group_Id int NOT NULL,
--	Number nvarchar(20) NULL,
--	Email nvarchar(30) NULL

--	CONSTRAINT PK_Student_Id PRIMARY KEY (Id),
--	CONSTRAINT FK_Student_Group_Id FOREIGN KEY (Group_Id) REFERENCES [Group](Id)
--)
--GO
--CREATE TABLE [Subject]
--(
--	Id int IDENTITY(1, 1),
--	Subject_Name nvarchar(50) NOT NULL,
--	Hour_Count int NOT NULL,
--	Fakulty_Id int NOT NULL,

--	CONSTRAINT PK_Subject_Id PRIMARY KEY (Id),
--	CONSTRAINT FK_Subject_Fakulty_Id FOREIGN KEY (Fakulty_Id) REFERENCES Faculty(Id),
--	CONSTRAINT CK_Subject_Hour_CountLim CHECK(Hour_Count > 0)
--)
--GO
--CREATE TABLE Lecture_Hall
--(
--	Id int IDENTITY(1, 1),
--	Hall_Num char(5) NOT NULL,
--	[Floor] int NOT NULL,
--	Num_Of_Seats int NOT NULL,

--	CONSTRAINT PK_Lecture_Hall_Id PRIMARY KEY (Id),
--	CONSTRAINT CK_Lecture_Hall_FloorLim CHECK([Floor] > 0),
--	CONSTRAINT CK_Lecture_Hall_Num_Of_SeatsLim CHECK(Num_Of_Seats > 0)
--)
--GO
--CREATE TABLE Couple
--(
--	Id int IDENTITY(1, 1),
--	Couple_Num int NOT NULL,
--	Couple_STime time NOT NULL,
--	Couple_FTime time NOT NULL,
	
--	CONSTRAINT PK_Couple_Id PRIMARY KEY (Id),
--	CONSTRAINT CK_Couple_Couple_NumLim CHECK(0 <= Couple_Num AND Couple_Num <= 13)
--)
--GO
--CREATE TABLE Schedule
--(
--	Id int IDENTITY (1, 1),
--	Subject_Id int NOT NULL,
--	Lecture_Hall_Id int NOT NULL,
--	Group_Id int NOT NULL,
--	Employees_Id int NOT NULL,
--	[Date] date NOT NULL,
--	Couple_Id int NOT NULL,

--	CONSTRAINT PK_Schedule_Id PRIMARY KEY (Id),
--	CONSTRAINT FK_Schedule_Subject_Id FOREIGN KEY (Subject_Id) REFERENCES [Subject](Id),
--	CONSTRAINT FK_Schedule_Lecture_Hall_Id FOREIGN KEY (Lecture_Hall_Id) REFERENCES Lecture_Hall(Id),
--	CONSTRAINT FK_Schedule_Group_Id FOREIGN KEY (Group_Id) REFERENCES [Group](Id),
--	CONSTRAINT FK_Schedule_Employees_Id FOREIGN KEY (Employees_Id) REFERENCES Employees(Id),
--	CONSTRAINT FK_Schedule_Couple_Id FOREIGN KEY (Couple_Id) REFERENCES Couple(Id)
--)
------------------------------------------------------------------------------------
--INSERT INTO Couple (Couple_Num, Couple_STime, Couple_FTime)
--VALUES (0, '09:00', '10:20'), 
--	   (1, '10:30', '11:50'),
--	   -- 20
--	   (2, '12:10', '13:30'),
--	   (3, '13:40', '15:00'),
--	   -- 20
--	   (4, '15:20', '16:40'),
--	   (5, '17:00', '18:20'),
--	   -- 20
--	   (6, '18:40', '20:00'),
--	   (7, '20:10', '21:30')

--INSERT INTO Employees (First_Name, Last_Name, Birth_Date, Email, Number)
--VALUES (N'Мальвина', N'Кулагина', N'1985-01-13', N'malkul@gmail.com', N'8 (927) 125-48-76'),
--	   (N'Никон', N'Мартынов', N'1974-05-25', N'nikmar@gmail.com', N'8 (977) 156-44-84'),
--	   (N'Зоя', N'Усачёва', N'1980-03-23', N'zoyus@gmail.com', N'8 (967) 763-35-28'),
--	   (N'Август', N'Рустамов', N'1975-01-14', N'avrus@gmail.com', N'8 (902) 514-98-50'),
--	   (N'Святополк', N'Скачков', N'1971-08-20', N'svaska@gmail.com', N'8 (900) 475-67-43')

--INSERT INTO Faculty (Faculty_Name, Owner_Id)
--VALUES (N'Программирование', 5),
--	   (N'Компьютерная графика', 1),
--	   (N'Сети и кибербезопасность', 2)

--INSERT INTO [Group] (Group_Name, Fakulty_Id, Cource)
--VALUES (N'FBM-1711-ru', 2, 1),
--	   (N'FSDE-1712-ru', 3, 2),
--	   (N'FSDM-1711-ru', 4, 3),
--	   (N'FBS-1611-ru', 2, 4),
--	   (N'FBL-1612-ru', 4, 3)

--SET IDENTITY_INSERT Lecture_Hall ON

--INSERT INTO Lecture_Hall (Id, Hall_Num, [Floor], Num_Of_Seats)
--VALUES (1, N'1A', 1, 15),
--	   (2, N'1C', 1, 15),
--	   (3, N'2A', 2, 25),
--	   (4, N'2E', 2, 15),
--	   (5, N'2D', 2, 15)

--SET IDENTITY_INSERT Lecture_Hall OFF

--SET IDENTITY_INSERT Post ON

--INSERT INTO Post (Id, Post_Name)
--VALUES (1, N'Директор'),
--	   (2, N'Заместитель директор'),
--	   (3, N'Заведующий кафедрой')

--SET IDENTITY_INSERT Post OFF

--SET IDENTITY_INSERT Post_Employees ON

--INSERT INTO Post_Employees (Post_Id, Employees_Id, Amount, [State])
--VALUES (1, 3, 1500, 0),
--	   (2, 4, 1000, 0),
--	   (3, 1, 1200, 1),
--	   (3, 2, 1200, 1),
--	   (3, 5, 1200, 1)

--SET IDENTITY_INSERT Post_Employees OFF

--SET IDENTITY_INSERT [Subject] ON

--INSERT INTO [Subject] (Id, Subject_Name, Hour_Count, Fakulty_Id)
--VALUES (1, N'C/C++', 120, 2),
--	   (2, N'C#', 160, 2),
--	   (3, N'Дизайн', 100, 3),
--	   (4, N'Моделирование', 80, 3),
--	   (5, N'Администрирование Linux', 150, 4),
--	   (6, N'Сети и безопасность', 160, 4)

--SET IDENTITY_INSERT [Subject] OFF

--SET IDENTITY_INSERT Schedule ON

--INSERT INTO Schedule (Id, Subject_Id, Lecture_Hall_Id, Group_Id, Employees_Id, [Date], Couple_Id)
--VALUES (1, 1, 1, 3, 5, GETDATE() + 20, 1),
--	   (2, 2, 2, 4, 5, GETDATE() + 20, 2),
--	   (3, 3, 3, 5, 1, GETDATE() + 20, 3),
--	   (4, 4, 3, 5, 1, GETDATE() + 20, 4),
--	   (5, 5, 4, 6, 2, GETDATE() + 20, 5),
--	   (6, 6, 5, 7, 2, GETDATE() + 20, 6)
	   
--SET IDENTITY_INSERT Schedule OFF

--SET IDENTITY_INSERT Student ON

--INSERT INTO Student (Id, First_Name, Last_Name, Birth_Date, Group_Id, Number, Email)
--VALUES (1, N'Дементий', N'Вирский', N'1992-01-09', 3, N'8 (914) 918-60-48', N'demvir@gmail.com'),
--	   (2, N'Инесса', N'Мамедова', N'1992-01-05', 3, N'8 (959) 685-71-65', N'inemam@gmail.com'),
--	   (3, N'Парамон', N'Шалдыбин', N'1997-05-21', 3, N'8 (942) 550-86-29', N'parjal@gmail.com'),
--	   (4, N'Инна', N'Усачёва', N'1991-08-08', 3, N'8 (977) 758-71-31', N'innusa@gmail.com'),
--	   (5, N'Глеб', N'Мамедов', N'1996-12-01', 3, N'8 (971) 589-92-49', N'qlemam@gmail.com'),
--	   (6, N'Наталья', N'Кулагина', N'1993-07-20', 4, N'8 (915) 976-90-40', N'natkul@gmail.com'),
--	   (7, N'Константин', N'Секунов', N'1992-08-10', 4, N'8 (971) 251-60-32', N'konsek@gmail.com'),
--	   (8, N'Зосима', N'Крылов', N'1991-01-23', 4, N'8 (909) 627-98-48', N'zoskri@gmail.com'),
--	   (9, N'Роза', N'Соболева', N'1998-05-19', 4, N'8 (953) 522-66-91', N'rozsob@gmail.com'),
--	   (10, N'Леокадия', N'Данилова', N'1997-10-03', 4, N'8 (954) 977-46-78', N'leodan@gmail.com'),
--	   (11, N'Велимир', N'Кириллов', N'1999-12-18', 5, N'8 (971) 942-37-46', N'velkir@gmail.com'),
--	   (12, N'Нина', N'Конягина', N'1992-04-11', 5, N'8 (926) 223-63-28', N'ninkon@gmail.com'),
--	   (13, N'Александра', N'Усачёва', N'1993-10-26', 5, N'8 (930) 166-34-74', N'aleusa@gmail.com'),
--	   (14, N'Максимильян', N'Троицкий', N'1994-02-22', 5, N'8 (928) 218-35-91', N'maktro@gmail.com'),
--	   (15, N'Валентина', N'Яковлева', N'1993-09-16', 5, N'8 (924) 986-36-61', N'valyako@gmail.com'),
--	   (16, N'Руслан', N'Иванов', N'1998-03-08', 6, N'8 (906) 119-99-20', N'rusiva@gmail.com'),
--	   (17, N'Виссарион', N'Миронов', N'1994-02-07', 6, N'8 (971) 649-38-48', N'vismir@gmail.com'),
--	   (18, N'Инна', N'Орлова', N'1990-12-04', 6, N'8 (974) 516-79-29', N'innorl@gmail.com'),
--	   (19, N'Евгения', N'Васильева', N'1990-01-08', 6, N'8 (919) 616-40-29', N'yevgvas@gmail.com'),
--	   (20, N'Нестор', N'Морозов', N'1994-04-19', 6, N'8 (977) 275-29-88', N'nesmor@gmail.com'),
--	   (21, N'Флора', N'Крылова', N'1992-08-18', 7, N'8 (940) 704-34-76', N'flokir@gmail.com'),
--	   (22, N'Арефий', N'Леонов', N'1995-07-23', 7, N'8 (902) 599-97-29', N'areleo@gmail.com'),
--	   (23, N'Иннокентий', N'Шмидт', N'1994-02-06', 7, N'8 (946) 810-71-55', N'innjmi@gmail.com'),
--	   (24, N'Эвелина', N'Демьянова', N'1992-12-09', 7, N'8 (941) 785-34-46', N'evadem@gmail.com'),
--	   (25, N'Нифонт', N'Федотов', N'1996-02-27', 7, N'8 (935) 177-76-99', N'niffed@gmail.com')

--SET IDENTITY_INSERT Student OFF
-------------------------------------------------------------------------------------------------------

/*1. Вывод подробной информации о студентах в указанной группе. */

--CREATE FUNCTION ShowGroupInfo
--( @groupName nvarchar(20) )
--RETURNS TABLE
--AS
--RETURN
--(
--	SELECT Student.First_Name, Student.Last_Name, Student.Birth_Date, [Group].Group_Name, Student.Number, Student.Email
--	FROM Student JOIN [Group]
--		ON Student.Group_Id = [Group].Id
--	WHERE [Group].Group_Name = @groupName
--)

--SELECT *
--FROM ShowGroupInfo(N'FBM-1711-ru')

/*2. Вывод сотрудников по указанной должности. */

--CREATE FUNCTION ShowEmployeesPost
--( @postName nvarchar(20) )
--RETURNS TABLE
--AS
--RETURN
--(
--	SELECT Employees.First_Name, Employees.Last_Name, Employees.Birth_Date, Employees.Number, Employees.Email, Post.Post_Name
--	FROM Employees JOIN Post_Employees
--		ON Employees.Id = Post_Employees.Employees_Id
--		JOIN Post
--		ON Post.Id = Post_Employees.Post_Id
--	WHERE Post.Post_Name = @postName
--)

--SELECT *
--FROM ShowEmployeesPost(N'Заведующий кафедрой')

/*3. Вывод расписания на неделю в понятном и подробном виде для указанной группы. */

--CREATE FUNCTION ShowSheduleInfo
--( @groupName nvarchar(20) )
--RETURNS TABLE
--AS
--RETURN
--(
--	SELECT [Subject].Subject_Name, Lecture_Hall.Hall_Num, [Group].Group_Name, Employees.First_Name, Employees.Last_Name, Schedule.[Date], Couple.Couple_Num, Couple.Couple_STime, Couple.Couple_FTime 
--	FROM Schedule JOIN [Subject]
--		ON Schedule.Subject_Id = [Subject].Id
--		JOIN Lecture_Hall
--		ON Schedule.Lecture_Hall_Id = Lecture_Hall.Id
--		JOIN [Group]
--		ON Schedule.Group_Id = [Group].Id
--		JOIN Employees
--		ON Schedule.Employees_Id = Employees.Id
--		JOIN Couple
--		ON Schedule.Couple_Id = Couple.Id
--	WHERE [Group].Group_Name = @groupName
--)

--SELECT *
--FROM ShowSheduleInfo(N'FBM-1711-ru')

/*4. Вывод расписания на неделю в понятном и подробном виде для указанного преподавателя. */

--CREATE FUNCTION ShowSheduleForTeacherInfo
--( 
--	@TeacherFName nvarchar(20),
--	@TeacherLName nvarchar(20)
--)
--RETURNS TABLE
--AS
--RETURN
--(
--	SELECT [Subject].Subject_Name, Lecture_Hall.Hall_Num, [Group].Group_Name, Employees.First_Name, 
--			Employees.Last_Name, Schedule.[Date], Couple.Couple_Num, Couple.Couple_STime, Couple.Couple_FTime
--	FROM Schedule JOIN [Subject]
--		ON Schedule.Subject_Id = [Subject].Id
--		JOIN Lecture_Hall
--		ON Schedule.Lecture_Hall_Id = Lecture_Hall.Id
--		JOIN [Group]
--		ON Schedule.Group_Id = [Group].Id
--		JOIN Employees
--		ON Schedule.Employees_Id = Employees.Id
--		JOIN Couple
--		ON Schedule.Couple_Id = Couple.Id
--	WHERE Employees.First_Name = @TeacherFName AND Employees.Last_Name = @TeacherLName
--)

--SELECT *
--FROM ShowSheduleForTeacherInfo(N'Мальвина', N'Кулагина')

/*5. Вывод расписания на неделю в понятном и подробном виде для указанной аудитории. */

--CREATE FUNCTION ShowSheduleForLecHallInfo
--( 
--	@LecHallNum nvarchar(5)
--)
--RETURNS TABLE
--AS
--RETURN
--(
--	SELECT [Subject].Subject_Name, Lecture_Hall.Hall_Num, [Group].Group_Name, Employees.First_Name, 
--			Employees.Last_Name, Schedule.[Date], Couple.Couple_Num, Couple.Couple_STime, Couple.Couple_FTime
--	FROM Schedule JOIN [Subject]
--		ON Schedule.Subject_Id = [Subject].Id
--		JOIN Lecture_Hall
--		ON Schedule.Lecture_Hall_Id = Lecture_Hall.Id
--		JOIN [Group]
--		ON Schedule.Group_Id = [Group].Id
--		JOIN Employees
--		ON Schedule.Employees_Id = Employees.Id
--		JOIN Couple
--		ON Schedule.Couple_Id = Couple.Id
--	WHERE Lecture_Hall.Hall_Num = @LecHallNum
--)

--SELECT *
--FROM ShowSheduleForLecHallInfo(N'1A')

/*6. Подсчет зарплаты указанного преподавателя за 1 месяц (зарплата - это количество пар умноженное на ставку за 1 пару; считаем, что 1 месяц - это ровно 4 недели).*/

--CREATE FUNCTION TeachSalCounter
--( 
--	@TeachFName nvarchar(20),
--	@TeachLName nvarchar(20)
--)
--RETURNS int
--AS
--BEGIN
--	DECLARE @Sal int = 0;
--	SELECT @Sal = Post_Employees.Amount / (SELECT COUNT(*) FROM Schedule WHERE Schedule.Employees_Id = (SELECT Employees.Id FROM Employees WHERE Employees.First_Name = @TeachFName AND Employees.Last_Name = @TeachLName))
--	FROM Post_Employees JOIN Employees
--		ON Post_Employees.Employees_Id = Employees.Id
--	WHERE Employees.First_Name = @TeachFName AND Employees.Last_Name = @TeachLName

--	RETURN @Sal
--END

--DECLARE @TempSal int = 0;
--EXEC @TempSal = TeachSalCounter N'Никон', N'Мартынов'

--PRINT @TempSal

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

--	CONSTRAINT PK_Student_Id PRIMARY KEY (Id),
--	CONSTRAINT FK_Student_Group_Id FOREIGN KEY (Group_Id) REFERENCES [Group](Id)
--)
--GO
--CREATE TABLE [Subject]
--(
--	Id int IDENTITY(1, 1),
--	Subject_Name nvarchar(20) NOT NULL,
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
--	CONSTRAINT CK_Lecture_Hall_Hall_NumLim CHECK(Hall_Num > 0),
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

INSERT INTO Employees (First_Name, Last_Name, Birth_Date, Email, Number)
VALUES ()

SELECT *
FROM Couple


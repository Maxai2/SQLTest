CREATE DATABASE Muzarium_ru
GO
USE Muzarium_ru
GO

CREATE TABLE City
(
	Id int IDENTITY (1, 1),
	City_Name nvarchar(20) NOT NULL,

	CONSTRAINT PK_City_Id PRIMARY KEY (Id)
)

CREATE TABLE Museum
(
	Id int IDENTITY (1, 1),
	Museum_Name nvarchar(50) NOT NULL,
	Museum_Description ntext NULL,
	[Address] nvarchar(150) NOT NULL,
	Number nvarchar(30) NOT NULL,
	Museum_Picture_Src nvarchar(100) NULL,
	WebSite nvarchar(30) NULL,
	[Login] nvarchar(15) NOT NULL,
	[Password] nvarchar(15) NOT NULL,
	Latitude float NOT NULL,
	Longitude float NOT NULL,
	Radius float NOT NULL,
	City_Id int NOT NULL

	CONSTRAINT PK_Museum_Id PRIMARY KEY (Id),
	CONSTRAINT FK_Museum_City_Id FOREIGN KEY (City_Id) REFERENCES City(Id)
)

CREATE TABLE QuestionType
(
	Id int IDENTITY (1, 1),
	QuestionType_Name nvarchar(20) NOT NULL,

	CONSTRAINT PK_QuestionType_Id PRIMARY KEY (Id)
)

CREATE TABLE Prize
(
	Id int IDENTITY (1, 1),
	Prize_Name nvarchar(15) NOT NULL,
	Prize_Picture_Src nvarchar(100) NULL,

	CONSTRAINT PK_Prize_Id PRIMARY KEY (Id)
)

CREATE TABLE Quest
(
	Id int IDENTITY (1, 1),
	Quest_Name nvarchar(50) NOT NULL,
	Quest_Description ntext NULL,
	Difficult nvarchar(15) NOT NULL,
	Quest_Picture_Src nvarchar(100) NULL,
	Quest_Score int NOT NULL,
	Museum_Id int NULL,
	Prize_Id int NULL,
	
	CONSTRAINT PK_Quest_Id PRIMARY KEY (Id),
	CONSTRAINT FK_Quest_Museum_Id FOREIGN KEY (Museum_Id) REFERENCES Museum(Id),
	CONSTRAINT FK_Quest_Prize_Id FOREIGN KEY (Prize_Id) REFERENCES Prize(Id)
)

CREATE TABLE Question
(
	Id int IDENTITY (1, 1),
	Question_Description ntext NULL,
	Question_Picture_Src nvarchar(100) NULL,
	Question_Scrore int NOT NULL,
	Hint nvarchar(50) NULL,
	QuestionType_Id int NOT NULL,
	Quest_Id int NOT NULL,

	CONSTRAINT PK_Question_Id PRIMARY KEY (Id),
	CONSTRAINT FK_Question_QuestionType_Id FOREIGN KEY (QuestionType_Id) REFERENCES QuestionType(Id),
	CONSTRAINT FK_Question_Quest_Id FOREIGN KEY (Quest_Id) REFERENCES Quest(Id)
)

CREATE TABLE [User]
(
	Id int IDENTITY (1, 1),
	First_Name nvarchar(20) NOT NULL,
	Last_Name nvarchar(20) NOT NULL,
	Birth_Date date NOT NULL,
	User_Scrore int NOT NULL DEFAULT (0),

	CONSTRAINT PK_User_Id PRIMARY KEY (Id)
)

CREATE TABLE Answer
(
	Id int IDENTITY (1, 1),
	Answer nvarchar(50) NOT NULL,
	IsRight bit NOT NULL,
	Question_Id int NOT NULL,

	CONSTRAINT PK_Answer_Id PRIMARY KEY (Id),
	CONSTRAINT FK_Answer_Question_Id FOREIGN KEY (Question_Id) REFERENCES Question(Id)
)

CREATE TABLE [Static]
(
	Id int IDENTITY (1, 1),
	[User_Id] int NOT NULL,
	Static_Score int NOT NULL,
	Duration int NOT NULL,
	[Date] date NOT NULL,
	IsComplete bit NOT NULL,
	Prize_Id int NOT NULL,
	Quest_Id int NOT NULL,

	CONSTRAINT PK_Static_Id PRIMARY KEY (Id),
	CONSTRAINT FK_Static_User_Id FOREIGN KEY ([User_Id]) REFERENCES [User](Id),
	CONSTRAINT FK_Staic_Prize_Id FOREIGN KEY (Prize_Id) REFERENCES Prize(Id),
	CONSTRAINT FK_Staic_Quest_Id FOREIGN KEY (Quest_Id) REFERENCES Quest(Id)
)
CREATE DATABASE Turisma_ru
GO
USE Turisma_ru
GO

CREATE TABLE Country
(
	Id int IDENTITY(1, 1),
	Country_Name nvarchar(25) NOT NULL,

	CONSTRAINT PK_Country_Id PRIMARY KEY (Id)
)

CREATE TABLE City
(
	Id int IDENTITY(1, 1),
	City_Name nvarchar(30) NOT NULL,
	Country_Id int NOT NULL,

	CONSTRAINT PK_City_Id PRIMARY KEY (Id),
	CONSTRAINT FK_Country_Id FOREIGN KEY (Country_Id) REFERENCES Country(Id)
)

CREATE TABLE [User]
(
	Id int IDENTITY(1, 1),
	First_Name nvarchar(20) NOT NULL,
	Last_Name nvarchar(20) NOT NULL,
	Picture_Src nvarchar(50) NULL,

	CONSTRAINT PK_User_Id 
)

CREATE TABLE [Route]
(
	Id int IDENTITY(1, 1),
	Route_Name nvarchar(50) NOT NULL,
	Route_Description text NULL,
	Route_Time time NOT NULL,
	City_Id int NOT NULL,

	CONSTRAINT PK_Route_Id PRIMARY KEY (Id),
	CONSTRAINT FK_Route_City_Id FOREIGN KEY (City_Id) REFERENCES City(Id)
)

CREATE TABLE Route_Type
(
	Id int IDENTITY(1, 1),
	Route_Type_Name nvarchar(50) NOT NULL,
	Route_Id int NOT NULL,

	CONSTRAINT PK_Route_Id PRIMARY KEY (Id),
	CONSTRAINT FK_Route_Type_Route_Id FOREIGN KEY (Route_Id) REFERENCES [Route](Id)
)

CREATE TABLE Point
(
	Id int IDENTITY(1, 1),
	Point_Name nvarchar(50) NOT NULL,
	Point_Location geography NOT NULL,
	Point_Description text NULL,
	Picture_Src nvarchar(50) NULL,
	[Index] int NOT NULL,
	Route_Id int NOT NULL,

	CONSTRAINT PK_Point_Id PRIMARY KEY (Id),
	CONSTRAINT FK_Point_Route_Id FOREIGN KEY (Route_Id) REFERENCES [Route](Id)
)
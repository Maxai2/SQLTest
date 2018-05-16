CREATE DATABASE Turisma_ru
GO
USE Turisma_ru
GO

------------------------------------------------------------------------------

BACKUP DATABASE Turisma_ru
TO DISK = ''
WITH
NAME = 'First BACKUP(full)',
DESCRIPTION = 'Create DATABASE'

------------------------------------------------------------------------------

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
	[Mail] nvarchar(50) NOT NULL,
	[FB] nvarchar(50) NULL,
	Picture_Src nvarchar(50) NULL,

	CONSTRAINT PK_User_Id PRIMARY KEY (Id)
)

CREATE TABLE Route_Type
(
	Id int IDENTITY(1, 1),
	Route_Type_Name nvarchar(50) NOT NULL,

	CONSTRAINT PK_Route_Type_Id PRIMARY KEY (Id)
)

CREATE TABLE [Route]
(
	Id int IDENTITY(1, 1),
	[User_Id] int NOT NULL,
	Route_Type_Id int NOT NULL,
	City_Id int NOT NULL,
	Route_Time time NOT NULL,
	Route_Name nvarchar(50) NOT NULL,
	Route_Description text NULL,

	CONSTRAINT PK_Route_Id PRIMARY KEY (Id),
	CONSTRAINT FK_Route_City_Id FOREIGN KEY (City_Id) REFERENCES City(Id),
	CONSTRAINT FK_Route_User_Id FOREIGN KEY ([User_Id]) REFERENCES [User](Id),
	CONSTRAINT FK_Route_RouteType_Id FOREIGN KEY (Route_Type_Id) REFERENCES Route_Type(Id)
)

INSERT INTO Route_Type (Route_Type_Name)
VALUES (N'Пешеход'), (N'Роликовые коньки'), (N'Велосипед'), (N'Машина')

CREATE TABLE Point
(
	Route_Id int NOT NULL,
	Point_Name nvarchar(50) NOT NULL,
	Point_Description text NULL,
	Temp_Latitude nvarchar(15) NULL,
	Temp_Longitude nvarchar(15) NULL,
	Id int IDENTITY(1, 1),
	[Index] int NULL,
	Point_Location geography NULL,
	Picture_Src nvarchar(50) NULL,

	CONSTRAINT PK_Point_Id PRIMARY KEY (Id),
	CONSTRAINT FK_Point_Route_Id FOREIGN KEY (Route_Id) REFERENCES [Route](Id)
)

ALTER TABLE Point
ALTER COLUMN Temp_Longitude nvarchar(15) NULL

CREATE TABLE Raiting
(
	Id int IDENTITY(1, 1),
	[Date] date NOT NULL,
	Mark int NOT NULL,
	Route_Id int NOT NULL,
	[User_Id] int NOT NULL,

	CONSTRAINT PK_Raiting_Id PRIMARY KEY (Id),
	CONSTRAINT FK_Raiting_Route_Id FOREIGN KEY (Route_Id) REFERENCES [Route](Id),
	CONSTRAINT FK_RAINTING_User_Id FOREIGN KEY ([User_Id]) REFERENCES [User](Id)
)

CREATE TABLE Comment
(
	Id int IDENTITY(1, 1),
	[Date] date NOT NULL,
	[Text] text NOT NULL,
	Like_Count int NOT NULL DEFAULT(0),
	Route_Id int NOT NULL,

	CONSTRAINT PK_Comment_Id PRIMARY KEY (Id),
	CONSTRAINT FK_Comment_Route_Id FOREIGN KEY (Route_Id) REFERENCES [Route](Id)
)

CREATE TABLE Likes
(
	[User_Id] int NOT NULL,
	Comment_Id  int NOT NULL,

	CONSTRAINT FK_Likes_User_Id FOREIGN KEY ([User_Id]) REFERENCES [User](Id),
	CONSTRAINT FK_Likes_Comment_Id FOREIGN KEY (Comment_Id) REFERENCES  Comment(Id)
)

BACKUP DATABASE Tourism
TO DISK = ''
WITH
NAME = 'Dif BackUp',
DESCRIPTION = 'Create Tables',
DIFFERENTIAL

----------------------------------------------------------------------

BULK INSERT [User]
FROM 'D:\Ali\Desktop\Data\users.txt'
WITH
(
	FORMATFILE = 'D:\Ali\Desktop\Data\userFormat.fmt',
	CODEPAGE = '65001'
)

UPDATE [User]
SET FB = NULL

SELECT *
FROM [User]

BULK INSERT [Route]
FROM 'C:\TempSQL\Turisma\routes.txt'
WITH
(
	FORMATFILE = 'C:\TempSQL\Turisma\routeFormat.fmt',
	CODEPAGE = '65001'
)

SELECT *
FROM [Route]


GO

CREATE TRIGGER PointInsert
ON Point INSTEAD OF INSERT
AS
BEGIN
	INSERT INTO Point (Route_Id, Point_Name, Point_Description, Point_Location)
	SELECT inserted.Route_Id , inserted.Point_Name, inserted.Point_Description, geography::Point(inserted.Temp_Latitude, inserted.Temp_Longitude, 4326)
	FROM inserted
END

BULK INSERT Point
FROM 'C:\TempSQL\Turisma\route1.txt'
WITH
(
	FORMATFILE = 'C:\TempSQL\Turisma\pointForm.fmt',
	CODEPAGE = '65001',
	FIRE_TRIGGERS
)

UPDATE Point
SET [Index] += 1

SET IDENTITY_INSERT Point OFF

SELECT *
FROM Point

TRUNCATE TABLE Point

SELECT Point.Point_Location.ToString()
FROM Point

--DECLARE @Geo geography
--SET @Geo = geography::Point(47.65100, -122.34900, 4326)  
--PRINT @Geo.ToString();  

----------------------------------------------------------------------
GO
/*1. Вывод всех маршрутов указанного города. */

CREATE FUNCTION AllRouteByCity
(@CityName nvarchar(20))
RETURNS TABLE
AS
RETURN
(
	SELECT [Route].Route_Name, [Route].Route_Description, [Route].Route_Time, Route_Type.Route_Type_Name, City.City_Name
	FROM [Route] JOIN City
		ON [Route].City_Id = City.Id
		JOIN Route_Type
		ON [Route].Route_Type_Id = Route_Type.Id
	WHERE City.City_Name = @CityName
)

/*2. Вывод всех маршрутов указанного города и типа.*/
GO

CREATE FUNCTION AllRouteByCityAndRouteType
(@CityName nvarchar(20), @RouteTypeName nvarchar(20))
RETURNS TABLE
AS
RETURN
(
	SELECT [Route].Route_Name, [Route].Route_Description, [Route].Route_Time, Route_Type.Route_Type_Name
	FROM [Route] JOIN City
		ON [Route].City_Id = City.Id
		JOIN Route_Type
		ON [Route].Route_Type_Id = Route_Type.Id
	WHERE City.City_Name = @CityName AND Route_Type.Route_Type_Name = @RouteTypeName
)

/*3. Вывод всех маршрутов указанного города, типа и отсортированным по рейтингу. ?? */

GO

CREATE FUNCTION AllRouteByCityAndRouteTypeOrederByRating
(@CityName nvarchar(20), @RouteTypeName nvarchar(20))
RETURNS TABLE
AS
RETURN
(
	SELECT [Route].Route_Name, [Route].Route_Description, [Route].Route_Time, Route_Type.Route_Type_Name, (SELECT SUM(Raiting.Mark) FROM Raiting JOIN [Route] 
		ON Raiting.Route_Id = [Route].Id) AS RaitingMark
	FROM [Route] JOIN City
		ON [Route].City_Id = City.Id
		JOIN Route_Type
		ON [Route].Route_Type_Id = Route_Type.Id
	WHERE City.City_Name = @CityName AND Route_Type.Route_Type_Name = @RouteTypeName
	ORDER BY RaitingMark
)

/*4. Вывод всех маршрутов, которые пользователь создал. */

GO

CREATE FUNCTION AllRouteByCityByUser
(@CityName nvarchar(20), @UserId int)
RETURNS TABLE
AS
RETURN
(
	SELECT [Route].Route_Name, [Route].Route_Description, [Route].Route_Time, Route_Type.Route_Type_Name
	FROM [Route] JOIN City
		ON [Route].City_Id = City.Id
		JOIN Route_Type
		ON [Route].Route_Type_Id = Route_Type.Id
	WHERE City.City_Name = @CityName AND [Route].[User_Id] = @UserId
)

/*5. Вывод информации и описания конкретного маршрута (по Id). */

GO

CREATE FUNCTION InfoAboutRouteById
(@UserId int)
RETURNS TABLE
AS
RETURN
(
	SELECT [Route].Route_Name, [Route].Route_Description, [Route].Route_Time, Route_Type.Route_Type_Name, City.City_Name, [User].First_Name, [User].Last_Name
	FROM [Route] JOIN City
		ON [Route].City_Id = City.Id
		JOIN Route_Type
		ON [Route].Route_Type_Id = Route_Type.Id
		JOIN [User]
		ON [Route].[User_Id] = [User].Id
	WHERE [User].Id = @UserId
)

/*6. Вывод всех точек маршрута для отображения их списком. ?? */

GO

CREATE FUNCTION AllPointByRouteIdForList
(@RouteId int)
RETURNS TABLE
AS
RETURN
(
	SELECT Point.Id, Point.Point_Name, Point.Point_Description, Point.[Index], [Route].Route_Name
	FROM Point JOIN [Route]
		ON Point.Route_Id = [Route].Id
	WHERE [Route].Id = @RouteId
)

/*7. Вывод всех точек маршрута для отображения их на карте. */

GO

CREATE FUNCTION AllPointByRouteIdForMap
(@RouteId int)
RETURNS TABLE
AS
RETURN
(
	SELECT Point.Id, Point.Point_Name, Point.Point_Description, Point.[Index], [Route].Route_Name, Point.Point_Location.ToString()
	FROM Point JOIN [Route]
		ON Point.Route_Id = [Route].Id
	WHERE [Route].Id = @RouteId
)

/*8. Вывод всех комментариев к маршруту. */

GO

CREATE FUNCTION AllCommentByRoute
(@RouteId int)
RETURNS TABLE
AS
RETURN
(
	SELECT Comment.Id, Comment.[Text], Comment.Like_Count, Comment.[Date], [Route].Route_Name
	FROM Comment JOIN [Route]
		ON Comment.Route_Id = [Route].Id
	WHERE [Route].Id = @RouteId
)

/*9. Запрос для регистрации пользователя через почтовый ящик. */

GO

CREATE PROCEDURE RegUserByMail
	@FirstName nvarchar(25),
	@LastName nvarchar(25),
	@mail nvarchar(25)
AS
BEGIN
	INSERT INTO [User] (First_Name, Last_Name, Mail)
	VALUES (@FirstName, @LastName, @mail)
END

/*10. Запрос для регистрации пользователя через FB.
11. Запрос для добавления маршрута.
12. Запрос для добавления точки в маршрут.
13. Запрос для добавления комментария маршруту.
14. Запрос для оценивания маршрута.*/

----------------------------------------------------------------------

/*1. Триггер, для пересчета рейтинга маршрута.*/

---------------------------------------------------------------------

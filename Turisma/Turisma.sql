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

INSERT INTO Route_Type (Route_Type_Name)
VALUES (N'Пешеход'), (N'Роликовые коньки'), (N'Велосипед'), (N'Машина')

CREATE TABLE [Route]
(
	Id int IDENTITY(1, 1),
	[User_Id] int NOT NULL,
	Route_Type_Id int NOT NULL,
	City_Id int NOT NULL,
	Route_Time time NOT NULL,
	Route_Name nvarchar(50) NOT NULL,
	Route_Description text NULL,
	Route_Rating_Mark float NOT NULL DEFAULT (0.0),

	CONSTRAINT PK_Route_Id PRIMARY KEY (Id),
	CONSTRAINT FK_Route_City_Id FOREIGN KEY (City_Id) REFERENCES City(Id),
	CONSTRAINT FK_Route_User_Id FOREIGN KEY ([User_Id]) REFERENCES [User](Id),
	CONSTRAINT FK_Route_RouteType_Id FOREIGN KEY (Route_Type_Id) REFERENCES Route_Type(Id)
)

	--CONSTRAINT DF_Route_Route_Rating_Mark DEFAULT (0.0) FOR Route_Rating_Mark
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

CREATE TABLE Raiting
(
	Id int IDENTITY(1, 1),
	Mark float NOT NULL,
	Route_Id int NOT NULL,
	[User_Id] int NOT NULL,

	CONSTRAINT PK_Raiting_Id PRIMARY KEY (Id),
	CONSTRAINT FK_Raiting_Route_Id FOREIGN KEY (Route_Id) REFERENCES [Route](Id),
	CONSTRAINT FK_Raiting_User_Id FOREIGN KEY ([User_Id]) REFERENCES [User](Id),
	CONSTRAINT UQ_Raiting_User_Id UNIQUE ([User_Id])
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
	[User_Id] int NOT NULL UNIQUE,
	Comment_Id  int NOT NULL UNIQUE,

	CONSTRAINT FK_Likes_User_Id FOREIGN KEY ([User_Id]) REFERENCES [User](Id),
	CONSTRAINT FK_Likes_Comment_Id FOREIGN KEY (Comment_Id) REFERENCES Comment(Id)
)

BACKUP DATABASE Turisma_ru
TO DISK = ''
WITH
NAME = 'Dif BackUp',
DESCRIPTION = 'Create Tables',
DIFFERENTIAL

----------------------------------------------------------------------

BULK INSERT [User]
FROM 'C:\TempSQL\Turisma\users.txt'
WITH
(
	FORMATFILE = 'C:\TempSQL\Turisma\userFormat.fmt',
	CODEPAGE = '65001'
)

UPDATE [User]
SET FB = NULL

TRUNCATE TABLE [User]

SELECT *
FROM [User]

DELETE FROM [User]

BULK INSERT [Route]
FROM 'C:\TempSQL\Turisma\routes.txt'
WITH
(
	FORMATFILE = 'C:\TempSQL\Turisma\routeFormat.fmt',
	CODEPAGE = '65001'
)

SELECT *
FROM [Route]

DELETE FROM [Route]

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

DECLARE @index int = 1

WHILE @index != 14
BEGIN
	UPDATE Point
	SET [Index] = @index
	WHERE Id = @index

	SET @index += 1
END

DROP TRIGGER PointInsert

ALTER TABLE Point
ALTER COLUMN [Index] int NOT NULL

SET IDENTITY_INSERT Point OFF

SELECT *
FROM Point

TRUNCATE TABLE Point

SELECT Point.Point_Location.ToString()
FROM Point

--DECLARE @Geo geography
--SET @Geo = geography::Point(47.65100, -122.34900, 4326)  
--PRINT @Geo.ToString();  

BACKUP DATABASE Turisma_ru
TO DISK = ''
WITH
NAME = 'Dif BackUp',
DESCRIPTION = 'Bulk Insert',
DIFFERENTIAL

----------------------------------------------------------------------
/*1. Вывод всех маршрутов указанного города. */

GO

CREATE FUNCTION AllRouteByCity
(@CityName nvarchar(20))
RETURNS TABLE
AS
RETURN
(
	SELECT [Route].Route_Name, [Route].Route_Description, [Route].Route_Time, City.City_Name, [Route].Route_Rating_Mark
	FROM [Route] JOIN City
		ON [Route].City_Id = City.Id
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
	SELECT [Route].Route_Name, [Route].Route_Description, [Route].Route_Time, City.City_Name, Route_Type.Route_Type_Name, [Route].Route_Rating_Mark
	FROM [Route] JOIN City
		ON [Route].City_Id = City.Id
		JOIN Route_Type
		ON [Route].Route_Type_Id = Route_Type.Id
	WHERE City.City_Name = @CityName AND Route_Type.Route_Type_Name = @RouteTypeName
)

/*3. Вывод всех маршрутов указанного города, типа и отсортированным по рейтингу. */

GO

CREATE FUNCTION AllRouteByCityAndRouteTypeOrederByRating
(@CityName nvarchar(20), @RouteTypeName nvarchar(20))
RETURNS TABLE
AS
RETURN
(
	SELECT [Route].Route_Name, [Route].Route_Description, [Route].Route_Time, City.City_Name, Route_Type.Route_Type_Name, [Route].Route_Rating_Mark
	FROM [Route] JOIN City
		ON [Route].City_Id = City.Id
		JOIN Route_Type
		ON [Route].Route_Type_Id = Route_Type.Id
	WHERE City.City_Name = @CityName AND Route_Type.Route_Type_Name = @RouteTypeName
	ORDER BY [Route].Route_Rating_Mark
)

/*4. Вывод всех маршрутов, которые пользователь создал. */

GO

CREATE FUNCTION AllRouteByCityByUser
(@UserId int)
RETURNS TABLE
AS
RETURN
(
	SELECT [Route].Route_Name, [Route].Route_Description, [Route].Route_Time, Route_Type.Route_Type_Name, City.City_Name, [Route].Route_Rating_Mark, [User].First_Name, [User].Last_Name
	FROM [Route] JOIN City
		ON [Route].City_Id = City.Id
		JOIN Route_Type
		ON [Route].Route_Type_Id = Route_Type.Id
		JOIN [User]
		ON [Route].[User_Id] = [User].Id
	WHERE [Route].[User_Id] = @UserId
)

/*5. Вывод информации и описания конкретного маршрута (по Id). */

GO

CREATE FUNCTION InfoAboutRouteById
(@RouteId int)
RETURNS TABLE
AS
RETURN
(
	SELECT [Route].Route_Name, [Route].Route_Description, [Route].Route_Time, Route_Type.Route_Type_Name, City.City_Name, [Route].Route_Rating_Mark
	FROM [Route] JOIN City
		ON [Route].City_Id = City.Id
		JOIN Route_Type
		ON [Route].Route_Type_Id = Route_Type.Id
	WHERE [Route].Id = @RouteId
)

/*6. Вывод всех точек маршрута для отображения их списком. */

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

/*10. Запрос для регистрации пользователя через FB. ? */

GO

CREATE PROCEDURE RegUserByFB
	@FirstName nvarchar(25),
	@LastName nvarchar(25),
	@FB nvarchar(25)
AS
BEGIN
	INSERT INTO [User] (First_Name, Last_Name, FB)
	VALUES (@FirstName, @LastName, @FB)
END

/*11. Запрос для добавления маршрута. */

GO

CREATE PROCEDURE AddRoute
	@UserId int,
	@RouteTypeId int,
	@CityId int,
	@RouteTime time,
	@RouteName nvarchar(50),
	@RouteDesc text
AS
BEGIN
	INSERT INTO [Route] ([User_Id], Route_Type_Id, City_Id, Route_Time, Route_Name, Route_Description)
	VALUES (@UserId, @RouteTypeId, @CityId, @RouteTime, @RouteName, @RouteDesc)
END

/*12. Запрос для добавления точки в маршрут. */

GO

CREATE PROCEDURE AddPoint
	@RouteId int,
	@PointName nvarchar(50),
	@PointDesc text,
	@Index int,
	@PointLocation geography,
	@PicSrc nvarchar(50)
AS
BEGIN
	INSERT INTO Point (Route_Id, Point_Name, Point_Description, [Index], Point_Location, Picture_Src)
	VALUES (@RouteId, @PointName, @PointDesc, @Index, @PointLocation, @PicSrc)
END

/*13. Запрос для добавления комментария маршруту.*/

GO

CREATE PROCEDURE AddComment
	@Date date,
	@Text text,
	@RouteId int
AS
BEGIN
	INSERT INTO Comment ([Date], [Text], Route_Id)
	VALUES (@Date, @Text, @RouteId)
END

/*14. Запрос для оценивания маршрута.*/

GO

CREATE PROCEDURE AddRaiting
	@Mark int,
	@RouteId int,
	@UserId int
AS
BEGIN
	INSERT INTO Raiting (Mark, Route_Id, [User_Id])
	VALUES (@Mark, @RouteId, @UserId)
END

----------------------------------------------------------------------

/*1. Триггер, для пересчета рейтинга маршрута.*/

GO

CREATE TRIGGER ReCalcRatingByRouteId
ON Raiting AFTER INSERT
AS
BEGIN
	DECLARE @SumMark float = 0.0
	SELECT @SumMark = CAST(SUM(inserted.Mark) AS float)
	FROM inserted JOIN [Route]
		ON inserted.Route_Id = [Route].Id

	DECLARE @tempMark float = 0.0;
	SELECT @tempMark = CAST(AVG(@SumMark) AS float)
	FROM inserted JOIN [Route]
		ON inserted.Route_Id = [Route].Id

	DECLARE @RouteId int = 0
	SELECT @RouteId = inserted.Route_Id 
	FROM inserted

	UPDATE [Route]
	SET Route_Rating_Mark = @tempMark
	WHERE [Route].Id = @RouteId
END

INSERT INTO Raiting (Mark, Route_Id, [User_Id])
VALUES (4.0, 1, 2)

SELECT *
FROM [Route]

UPDATE [Route]
SET Route_Rating_Mark = 0
WHERE Id = 1

SELECT *
FROM Raiting

DELETE FROM Raiting

TRUNCATE TABLE Raiting

---------------------------------------------------------------------

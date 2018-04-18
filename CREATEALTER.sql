CREATE DATABASE MiniInsta
GO
USE MiniInsta
GO

CREATE TABLE Users(
	Id int PRIMARY KEY IDENTITY(0, 1),
	[Login] nvarchar(50) NOT NULL UNIQUE,
	Pswd nvarchar(255) NOT NULL,
	FullName nvarchar(100) NULL,
	IsOpen bit NOT NULL DEFAULT(1),
	Birthday datetime2 NULL 
);

CREATE TABLE Posts(
	Id int PRIMARY KEY,
	MediaUrl nvarchar(255) NOT NULL,
	Descrip text NULL,
	DatePost datetime2 NOT NULL,
	Likes int NOT NULL DEFAULT(0),
	IdUser int NOT NULL FOREIGN KEY REFERENCES Users(Id) 
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

CREATE TABLE Tags (
	Id int NOT NULL,
	Tag nvarchar(255) NOT NULL CHECK(LEN(Tag) >= 2),
	CONSTRAINT PK_Tags PRIMARY KEY (Id)
);

CREATE TABLE PostsTags(
	IdPost int NOT NULL,
	IdTag int NOT NULL,
	CONSTRAINT FK_Posts_PostsTags FOREIGN KEY (IdPost) REFERENCES Posts(Id),
	CONSTRAINT FK_Tags_PostsTags FOREIGN KEY (IdTag) REFERENCES Tags(Id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	CONSTRAINT UQ_PostsTags UNIQUE(IdPost, IdTag)
);

GO

ALTER TABLE Users
ADD Descrip nvarchar(500) NULL

ALTER TABLE Users
ALTER COLUMN Descrip nvarchar(300) NULL

EXEC sp_rename N'Users.Descrip', N'About', N'COLUMN'

ALTER TABLE Users
ADD CONSTRAINT CK_Users_About CHECK(LEN(About) > 10)

ALTER TABLE Users
DROP CONSTRAINT CK_Users_About

--DROP DATABASE MiniInsta
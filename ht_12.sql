/*Реализовать триггеры таким образом, чтоб выполнялись следующие требования. 
1. Нельзя было выдавать книгу, которой уже нет в библиотеке (по количеству).
2. При возврате определенной книги, её количество должно увеличиваться. 
3. При выдаче книги, ее количество должно уменьшаться.*/

--CREATE TRIGGER CheckBookGiveStud 
--ON S_Cards AFTER INSERT, UPDATE
--AS
--BEGIN
--	IF UPDATE(DateIn)
--	BEGIN
--		UPDATE Books
--		SET Quantity += 1
--		WHERE Books.Id = ANY (SELECT inserted.Id_Book FROM inserted)
--		RETURN;
--	END
--	ELSE
--	IF UPDATE(DateOut)
--		BEGIN
--		UPDATE Books
--		SET Quantity -= 1
--		WHERE Books.Id = ANY (SELECT inserted.Id_Book FROM inserted)
--		RETURN;
--	END

--	DECLARE @bookQuant int = 0;
--	SELECT @bookQuant = Books.Quantity
--	FROM Books JOIN inserted
--		ON Books.Id = inserted.Id_Book
--	WHERE inserted.Id_Book = Books.Id

--	DECLARE @bookName nvarchar(100);
--	SELECT @bookName = Books.[Name] 
--	FROM Books JOIN inserted 
--		ON Books.Id = inserted.Id_Book 
--	WHERE inserted.Id_Book = Books.Id

--	IF @bookQuant = 0
--	BEGIN
--		PRINT 'No more (' + @bookName + ') left in the library!'
--		ROLLBACK TRAN;
--	END
--	ELSE
--		PRINT 'Take please!'
--END

----------------------------------------------------------------------------

--CREATE TRIGGER CheckBookGiveTeach 
--ON T_Cards AFTER INSERT, UPDATE
--AS
--BEGIN
--	IF UPDATE(DateIn)
--	BEGIN
--		UPDATE Books
--		SET Quantity += 1
--		WHERE Books.Id = ANY (SELECT inserted.Id_Book FROM inserted)
--		RETURN;
--	END
--	ELSE
--	IF UPDATE(DateOut)
--		BEGIN
--		UPDATE Books
--		SET Quantity -= 1
--		WHERE Books.Id = ANY (SELECT inserted.Id_Book FROM inserted)
--		RETURN;
--	END

--	DECLARE @bookQuant int = 0;
--	SELECT @bookQuant = Books.Quantity
--	FROM Books JOIN inserted
--		ON Books.Id = inserted.Id_Book
--	WHERE inserted.Id_Book = Books.Id

--	DECLARE @bookName nvarchar(100);
--	SELECT @bookName = Books.[Name] 
--	FROM Books JOIN inserted 
--		ON Books.Id = inserted.Id_Book 
--	WHERE inserted.Id_Book = Books.Id

--	IF @bookQuant = 0
--	BEGIN
--		PRINT 'No more (' + @bookName + ') left in the library!'
--		ROLLBACK TRAN;
--	END
--	ELSE
--		PRINT 'Take please!'
--END

--INSERT INTO S_Cards (Id, Id_Student, Id_Lib, Id_Book, DateOut, DateIn)
--VALUES (13, 6, 1, 6, GETDATE(), NULL)

--SELECT *
--FROM Books

/*4. Нельзя выдать более трёх книг одному студенту на руки.*/

--CREATE TRIGGER NoMoreThanThree
--ON S_Cards AFTER INSERT
--AS
--BEGIN
--	DECLARE @curStudBookCount int = 0;
--	SELECT @curStudBookCount = COUNT(inserted.Id_Student)
--	FROM inserted JOIN Students
--		ON inserted.Id_Student = Students.Id
--	WHERE Students.Id = inserted.Id_Student

--	IF @curStudBookCount > 3
--	BEGIN
--		PRINT N'You have 3 books no longer issued!'
--		ROLLBACK TRAN
--	END
--	ELSE
--		PRINT N'Take please!'
--END

/*5. Нельзя выдавать новую книгу студенту, если он сейчас читает хоть одну книгу дольше 2 месяцев. */

--CREATE TRIGGER TwoMonthMore
--ON S_Cards AFTER INSERT
--AS
--BEGIN
--	DECLARE @monthCount int = 0;
--	SELECT @monthCount = MONTH(GETDATE()) - (SELECT MONTH(inserted.DateOut) FROM inserted)
--END

--DECLARE @monthCount int = 0;
--SELECT @monthCount = MONTH(GETDATE()) - (SELECT TOP(1) MONTH(S_Cards.DateOut) FROM S_Cards WHERE S_Cards.Id_Student = 2)
--PRINT @monthCount

/*6. При удалении книги, данные о ней должны копироваться в таблицу LibDeleted. */

CREATE TABLE LibDeleted
(
	Id int NOT NULL IDENTITY(1, 1),
	[Name] nvarchar(100) NOT NULL,
	Pages int NOT NULL,
	YearPress int NOT NULL,
	Id_Themes int NOT NULL,
	Id_Category int NOT NULL,
	Id_Author int NOT NULL,
	Id_Press int NOT NULL,
	Comment nvarchar(50) NULL,
	Quantity int NOT NULL
)
GO
CREATE TRIGGER OnDeleteCopy
ON Books AFTER DELETE
AS
BEGIN
	INSERT INTO LibDeleted ([Name], Pages, YearPress, Id_Themes, Id_Category, Id_Author, Id_Press, Comment, Quantity)
	VALUE (deleted.[Name], deleted.Pages, deleted.YearPress, deleted.Id_Themes, deleted.Id_Category, deleted.Id_Author, deleted.Id_Press, deleted.Comment, deleted.Quantity)
END

SELECT *
FROM Books

/*(!) Обратите внимание, что первые 3 пункта относятся к выдаче книг и студентам и учителям.*/

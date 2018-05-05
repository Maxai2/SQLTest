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

CREATE TRIGGER NoMoreThanThree
ON S_Cards AFTER INSERT
AS
BEGIN

	DECLARE @curStudBookCount int = 0;
	SELECT @curStudBookCount = COUNT(inserted.Id_Student)
	FROM inserted JOIN Students
		ON inserted.Id_Student = Students.Id
	WHERE Students.Id = inserted.Id_Student

	IF @curStudBookCount > 3
	BEGIN
		PRINT N''
	END

END

/*5. Нельзя выдавать новую книгу студенту, если он сейчас читает хоть одну книгу дольше 2 месяцев.
6. При удалении книги, данные о ней должны копироваться в таблицу LibDeleted.
(!) Обратите внимание, что первые 3 пункта относятся к выдаче книг и студентам и учителям.*/

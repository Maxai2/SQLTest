/*Реализовать триггеры таким образом, чтоб выполнялись следующие требования. 
1. Нельзя было выдавать книгу, которой уже нет в библиотеке (по количеству). */

CREATE TRIGGER CheckBookGive 
ON S_Cards AFTER INSERT, UPDATE
AS
BEGIN
	DECLARE @bookQuant int = 0;
	SELECT @bookQuant = Books.Quantity
	FROM Books JOIN inserted
		ON Books.Id = inserted.Id_Book
	WHERE inserted.Id_Book = Books.Id

	DECLARE @bookName nvarchar(100);
	SELECT @bookName = Books.[Name] 
	FROM Books JOIN inserted 
		ON Books.Id = inserted.Id_Book 
	WHERE inserted.Id_Book = Books.Id

	UPDATE Books
	SET Quantity += 1
	WHERE inserted.Id_Book = Books.Id

	IF @bookQuant = 0
	BEGIN
		PRINT 'No more (' + @bookName + ') left in the library!'
		ROLLBACK TRAN;
	END
	ELSE
		PRINT 'Take please!'
END

INSERT INTO S_Cards (Id, Id_Student, Id_Lib, Id_Book, DateOut, DateIn)
VALUES (13, 6, 1, 6, GETDATE(), NULL)

SELECT *
FROM Books

/*2. При возврате определенной книги, её количество должно увеличиваться. */

CREATE TRIGGER BookComeBack
ON S_Cards AFTER UPDATE
AS
BEGIN
	UPDATE Books
	SET Quantity += 1
	WHERE inserted.Id_Book = Books.Id
END

/*3. При выдаче книги, ее количество должно уменьшаться.
4. Нельзя выдать более трёх книг одному студенту на руки.
5. Нельзя выдавать новую книгу студенту, если он сейчас читает хоть одну книгу дольше 2 месяцев.
6. При удалении книги, данные о ней должны копироваться в таблицу LibDeleted.

(!) Обратите внимание, что первые 3 пункта относятся к выдаче книг и студентам и учителям.*/

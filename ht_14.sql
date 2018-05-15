/*К БД Library добавить следующие роли:
1. Библиотекарь, старший библиотекарь
2. Учитель
3. Студент
4. Администратор
Представим, что к БД Library будут написаны приложения для библиотекарей,
студентов и учителей. И каждый пользователь логинясь в соответствующее
приложение будет иметь следующие права доступа.

!​ В некоторых случаях стоит создать представления или процедуры и дать права на
них, вместо того чтоб строить сложные или колоночные ограничения на таблицы.
Например:
1. Библиотекарь может изменять только столбец Quantity в таблице Books. Да
можно дать право на 1 столбец в таблице. Но лучше сделать хранимую
процедуру, которая изменяет этот столбец, и дать право запускать эту
процедуру.
2. Пункты 3 и 4 у библиотекаря лучше сделать с помощью представлений. И
библиотекарь будет получать информацию более наглядно и вам меньше
прав выдавать (только на представление).
3. Похожая ситуация у студентов и учителей.
4. Для просмотра задолженностей тоже можно сделать хранимую процедуру.*/

USE [Library_ru]
GO

CREATE ROLE Librarian
CREATE ROLE Senior_Librarian
CREATE ROLE Teacher
CREATE ROLE Student
CREATE ROLE Administrator

-----------------------------------------------------
/*Библиотекарь:
1. Может всячески взаимодействовать с данными в таблицах S_Cards и T_Cards. Но не может изменять или удалять сами таблицы. */

GRANT SELECT, INSERT, UPDATE, DELETE ON S_Cards
TO Librarian

GRANT SELECT, INSERT, UPDATE, DELETE ON T_Cards
TO Librarian

--------------------------------------------------------------------------------------------------

/*2. Может изменять столбец Quantity в таблице Books. Но не может добавлять, изменять или удалять книги из БД. */

GRANT UPDATE ON Books(Quantity)
TO Librarian

--///////////////////////////////////////////////////

CREATE PROCEDURE ChangeColumn
	@BookId int,
	@increase bit
AS
BEGIN
	IF @increase = 1
	BEGIN
		UPDATE Books
		SET Quantity += 1
		WHERE Books.Id = @BookId
	END
	ELSE
	BEGIN
		UPDATE Books
		SET Quantity -= 1
		WHERE Books.Id = @BookId
	END
END

GRANT EXECUTE ON OBJECT :: ChangeColumn
TO Librarian

--------------------------------------------------------------------------------------------------

/*3. Может просматривать информацию о книгах, авторах, издательствах, темах. */

GRANT SELECT ON Books 
TO Librarian

GRANT SELECT ON Authors
TO Librarian

GRANT SELECT ON Press
TO Librarian

GRANT SELECT ON Themes
TO Librarian

--///////////////////////////////////////////////////

CREATE VIEW InfoAboutBooks
AS
SELECT Books.Id, Books.[Name] AS Book_Name, Books.Pages, Books.YearPress, Themes.[Name] AS Themes_Name, 
	Categories.[Name] AS Category_Name, Authors.FirstName, Authors.LastName, 
	Press.[Name] AS Press_Name, Books.Comment, Books.Quantity, Books.Category
FROM Books JOIN Themes
	ON Books.Id_Themes = Themes.Id
	JOIN Categories
	ON Books.Id_Category = Categories.Id
	JOIN Authors
	ON Books.Id_Author = Authors.Id
	JOIN Press
	ON Books.Id_Press = Press.Id

GRANT SELECT ON InfoAboutBooks
TO Librarian

--------------------------------------------------------------------------------------------------

/*4. Может просматривать имена, фамилии и идентификаторы студентов и учителей.*/

GRANT SELECT ON Students(Id, FirstName, LastName)
TO Librarian

GRANT SELECT ON Teachers(Id, FirstName, LastName)
TO Librarian

--///////////////////////////////////////////////////

CREATE VIEW InfoAboutStudTeach
AS
SELECT Students.Id, (Students.FirstName + ' ' + Students.LastName) AS [Name], 'cтудент' AS Team
FROM Students
UNION
SELECT Teachers.Id, (Teachers.FirstName + ' ' + Teachers.LastName) AS [Name], 'учитель' AS Team
FROM Teachers

GRANT SELECT ON InfoAboutStudTeach
TO Librarian

--------------------------------------------------------------------------------------------------

/*Старший библиотекарь:
1. Может добавлять, изменять, удалять книги, авторов, издательства, темы.*/

GRANT INSERT, UPDATE, DELETE ON Books
TO Senior_Librarian

GRANT INSERT, UPDATE, DELETE ON Authors
TO Senior_Librarian

GRANT INSERT, UPDATE, DELETE ON Press
TO Senior_Librarian

GRANT INSERT, UPDATE, DELETE ON Themes
TO Senior_Librarian

------------------------------------------------------------------------------------------------

/*Учитель:
1. Может просматривать информацию о книгах, авторах, издательствах, темах.*/

GRANT SELECT ON Books
TO Teacher

GRANT SELECT ON Authors
TO Teacher

GRANT SELECT ON Press
TO Teacher

GRANT SELECT ON Themes
TO Teacher

--///////////////////////////////////////////////////

GRANT SELECT ON InfoAboutBooks
TO Teacher

------------------------------------------------------------------------------------------------

/*2. Может просматривать список студентов, групп, факультетов. */

GRANT SELECT ON Students
TO Teacher

GRANT SELECT ON Groups
TO Teacher

GRANT SELECT ON Faculties
TO Teacher

--///////////////////////////////////////////////////

CREATE VIEW InfoAboutStud
AS
SELECT Students.Id, Students.FirstName, Students.LastName, Groups.[Name] AS Group_Name, Students.Term, Faculties.[Name] AS Facultie_Name
FROM Students JOIN Groups
	ON Students.Id_Group = Groups.Id
	JOIN Faculties
	ON Groups.Id_Faculty = Faculties.Id

GRANT SELECT ON InfoAboutStud
TO Teacher

------------------------------------------------------------------------------------------------

/*3. Может просматривать свои задолжности по несданным книгам.*/

CREATE PROCEDURE BooksDebtByTeach
	@TeachId int
AS
BEGIN
	SELECT Books.[Name], T_Cards.DateOut
	FROM Books JOIN T_Cards
		ON Books.Id = T_Cards.Id_Book
	WHERE T_Cards.Id_Teacher = @TeachId AND T_Cards.DateIn LIKE NULL
END

GRANT EXECUTE ON OBJECT :: BooksDebtByTeach
TO Teacher

--------------------------------------------------------------------------------------------

/*Студент:
1. Может просматривать информацию о книгах, авторах, издательствах, темах. */

GRANT SELECT ON InfoAboutBooks
TO Student

/*2. Может просматривать свои задолжности по несданным книгам.*/

CREATE PROCEDURE BooksDebtByStud
	@StudId int
AS
BEGIN
	SELECT Books.[Name], S_Cards.DateOut
	FROM Books JOIN S_Cards
		ON Books.Id = S_Cards.Id_Book
	WHERE S_Cards.Id_Student = @StudId AND S_Cards.DateIn LIKE NULL
END

GRANT EXECUTE ON OBJECT :: BooksDebtByStud
TO Student

--------------------------------------------------------------------------------------------

/*Администратор:
1. Может все.*/

GRANT SELECT, INSERT, UPDATE, DELETE ON S_Cards
TO Administrator

GRANT SELECT, INSERT, UPDATE, DELETE ON T_Cards
TO Administrator

GRANT EXECUTE ON OBJECT :: ChangeColumn
TO Administrator

GRANT SELECT ON InfoAboutBooks
TO Administrator

GRANT SELECT ON InfoAboutStudTeach
TO Administrator

GRANT SELECT ON InfoAboutStud
TO Administrator

GRANT EXECUTE ON OBJECT :: BooksDebtByTeach
TO Administrator

GRANT EXECUTE ON OBJECT :: BooksDebtByStud
TO Administrator

--------------------------------------------------------------------------------------------

/*После создания ролей, необходимо добавить пользователей в роли (хотя бы по
одному в каждую роль).
После создания всех ролей, пользователей, предоставления необходимых
привилегий и проверки на работоспособность необходимо удалить вашего
пользователя из этой БД.
*/

--------------------------------------------------------------------------------------------

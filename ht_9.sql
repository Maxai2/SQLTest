/*1. Написать функцию, возвращающую список книг с минимальным количеством страниц, выпущенных тем или иным издательством. */

--CREATE FUNCTION MinPageList()
--RETURNS TABLE
--AS
--RETURN
--(
--	SELECT BookMain.[Name] AS BookName, BookMain.Pages, Press.[Name] AS PressName
--	FROM Books AS BookMain JOIN Press
--		ON BookMain.Id_Press = Press.Id
--	WHERE BookMain.Pages = (SELECT MIN(BookSub.Pages) FROM Books AS BookSub WHERE BookMain.Id_Press = BookSub.Id_Press)
--)

--SELECT *
--FROM MinPageList();

/*2. Написать функцию, возвращающую названия издательств, которые выпустили книги со средним количеством страниц большим N. Среднее число страниц передаётся через параметр. */

--CREATE FUNCTION AVGPagesPress
--(
--	@PagesNum int
--)
--RETURNS TABLE
--AS
--RETURN
--(
--	SELECT Press.[Name] AS PressName, Books.Pages
--	FROM Press JOIN Books
--		ON Press.Id = Books.Id_Press
--	GROUP BY Press.[Name], Books.Pages
--	HAVING AVG(Books.Pages) > @PagesNum
--)

--SELECT *
--FROM AVGPagesPress(200);

/*3. Написать функцию, возвращающую общую сумму страниц всех имеющихся в библиотеке книг, выпущенных указанным издательством. */

--CREATE FUNCTION SUMPages
--(
--	@PressName nvarchar(50)
--)
--RETURNS int
--AS
--BEGIN
--	DECLARE @ComSum int = 0;
--	SELECT @ComSum = SUM(Books.Pages)
--	FROM Books JOIN Press
--	ON Books.Id_Press = Press.Id
--	WHERE Press.[Name] = @PressName
--	RETURN @ComSum
--END

--DECLARE @temp int = 0;
--EXEC @temp = SUMPages N'BHV'
--PRINT @temp

/*4. Написать функцию, возвращающую список имен и фамилий всех студентов, которые брали книги в промежутке между двумя указанными датами. */

--CREATE FUNCTION NameBetTwoDate
--(
--	@BeginDate date,
--	@EndDate date
--)
--RETURNS TABLE
--AS
--RETURN
--(
--	SELECT (Students.FirstName + ' ' + Students.LastName) AS StudName, FORMAT(S_Cards.DateOut, 'dd/MM/yyyy') AS DateOut
--	FROM Students JOIN S_Cards
--		ON Students.Id= S_Cards.Id_Student
--	WHERE @BeginDate <= S_Cards.DateOut AND S_Cards.DateOut <= @EndDate
--)

--SELECT *
--FROM NameBetTwoDate(N'19000101', N'20000101')

/*5. Написать функцию, возвращающую список студентов, кто на данный момент работает с указанной книгой определённого автора. */

--CREATE FUNCTION ListStud
--(
--	@BooksName nvarchar(100)
--)
--RETURNS TABLE 
--AS
--RETURN
--(
--	SELECT (Students.FirstName + ' ' + Students.LastName) AS StudName, Books.[Name] AS BooksName, (Authors.FirstName + ' ' + Authors.LastName) AS AuthorsName
--	FROM Students JOIN S_Cards
--		ON Students.Id = S_Cards.Id_Student
--		JOIN Books
--		ON S_Cards.Id_Book = Books.Id
--		JOIN Authors
--		ON Authors.Id = Books.Id_Author
--	WHERE Books.[Name] = @BooksName AND S_Cards.DateIn IS NULL
--)

--SELECT *
--FROM ListStud(N'HTML 3.2')

--SELECT Books.[Name]
--FROM Books;

/*6. Написать функцию, возвращающую информацию об издательствах, у которых общее количество страниц выпущенных ими книг больше N. */

--CREATE FUNCTION PressInf
--(
--	@Numpages int
--)
--RETURNS TABLE
--AS
--RETURN
--(
--	SELECT Press.[Name]
--	FROM Press JOIN Books AS BookMain
--		ON Press.Id = BookMain.Id_Press
--	WHERE (SELECT SUM(BookSub.Pages) FROM Books AS BookSub WHERE BookMain.Id_Press = BookSub.Id_Press) > @Numpages
--	GROUP BY Press.[Name]
--)

--SELECT *
--FROM PressInf(200)

/*7. Написать функцию, возвращающую информацию о самом популярном авторе среди студентов и о количестве книг этого автора, взятых в библиотеке. */

--CREATE FUNCTION AuthorInf()
--RETURNS TABLE
--AS
--RETURN
--(
--	SELECT TOP (1) with ties (Authors.FirstName + ' ' + Authors.LastName) AS AuthorName, COUNT(Books.Id) AS BooksCount
--	FROM Authors JOIN Books
--		ON Authors.Id = Books.Id_Author
--	GROUP BY Authors.FirstName, Authors.LastName
--	ORDER BY BooksCount DESC
--)

--SELECT *
--FROM AuthorInf()

/*8. Написать функцию, возвращающую список книг, которые брали и преподаватели и студенты. */

--CREATE FUNCTION BooksList()
--RETURNS TABLE
--AS
--RETURN
--(
--	SELECT Books.[Name], N'Студенты' AS Team
--	FROM Books JOIN S_Cards
--		ON Books.Id = S_Cards.Id_Book
--	UNION
--	SELECT Books.[Name], N'Учителя' AS Team
--	FROM Books JOIN T_Cards
--		ON Books.Id = T_Cards.Id_Book
--)

--SELECT *
--FROM BooksList()
--ORDER BY BooksList.Team

/*9. Написать функцию, возвращающую количество студентов, которые не брали книги. */

--ALTER FUNCTION CountOfStudNotTake()
--RETURNS int
--AS
--BEGIN
--	DECLARE @count int = 0;
--	SELECT @count = (SELECT COUNT(*) FROM Students) - (SELECT COUNT(*) FROM S_Cards)

--	RETURN @count
--END

--DECLARE @temp int = 0;
--EXEC @temp = CountOfStudNotTake
--PRINT @temp

/*10. Написать функцию, которая возвращает список библиотекарей и количество выданных каждым из них книг.*/

--CREATE FUNCTION LibsListBooksCount()
--RETURNS TABLE
--AS
--RETURN
--(
--	SELECT *
--	FROM (SELECT (Libs.FirstName + ' ' + Libs.LastName) AS LibsName, COUNT(S_Cards.Id) AS [Count], N'Студентов' AS Team
--	FROM Libs JOIN S_Cards
--		ON Libs.Id = S_Cards.Id_Lib
--	GROUP BY Libs.FirstName, Libs.LastName) AS Stud
--	UNION
--	SELECT *
--	FROM (SELECT (Libs.FirstName + ' ' + Libs.LastName) AS LibsName, COUNT(T_Cards.Id) AS [Count], N'Учителей' AS Team
--	FROM Libs JOIN T_Cards
--		ON Libs.Id = T_Cards.Id_Lib
--	GROUP BY Libs.FirstName, Libs.LastName) AS Teach
--)

--SELECT *
--FROM LibsListBooksCount()
--ORDER BY LibsListBooksCount.Team

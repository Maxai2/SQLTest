-- 1. Отобразить книги с минимальным количеством страниц, выпущен-ные тем или иным издательством.

--SELECT Books.Id, Books.[Name], Books.Pages, Press.[Name] AS PressName
--FROM Press JOIN 
--(
--	SELECT Id_Press, MIN(Books.Pages) AS MinPages
--	FROM Books
--	GROUP BY Id_Press 
--) 
--AS MinPage 
--	ON Press.Id = MinPage.Id_Press
--	JOIN Books
--	ON Books.Pages = MinPage.MinPages

--SELECT B1.Id, B1.[Name], B1.Pages, Press.[Name]
--FROM Books AS B1
--	JOIN Press
--	ON B1.Id_Press = Press.Id
--WHERE Pages = (
--	SELECT MIN(B2.Pages) AS MinPages
--	FROM Books AS B2
--	WHERE B1.Id_Press = B2.Id_Press)

-- 2. Отобразить названия издательств, которые выпустили книги со средним количеством страниц большим 100.

--SELECT Press.[Name], Books.Pages
--FROM Press JOIN Books
--	ON Press.Id = Books.Id_Press
--GROUP BY Press.[Name], Books.Pages
--HAVING AVG(Books.Pages) > 100

/*3. Вывести общую сумму страниц всех имеющихся в библиотеке книг, выпущенных издательствами BHV и БИНОМ.*/

--SELECT SUM(Books.Pages) AS PagesSum, Press.[Name]
--FROM Books JOIN Press
--	ON Books.Id_Press = Press.Id
--GROUP BY Press.[Name]
--HAVING Press.[Name] LIKE N'BHV' OR Press.[Name] LIKE N'БИНОМ'

/*4. Выбрать имена и фамилии всех студентов, которые брали книги в промежутке между 1 Января 2001 года и текущей датой. */

--SELECT Students.FirstName, Students.LastName, S_Cards.DateOut, S_Cards.DateIn
--FROM Students RIGHT JOIN S_Cards
--	ON Students.Id = S_Cards.Id_Student
--WHERE S_Cards.DateOut >= N'20010101' AND (S_Cards.DateIn <= GETDATE() OR S_Cards.DateIn IS NULL)

/*5. Найти всех студентов, кто на данный момент работает с книгой "Реестр Windows 2000" автора Ольга Кокорева.*/

--SELECT Students.FirstName, Students.LastName, Books.[Name]
--FROM Students JOIN S_Cards
--	ON Students.Id = S_Cards.Id_Student
--	JOIN Books
--	ON S_Cards.Id_Book = Books.Id
--	JOIN Authors
--	ON Authors.Id = Books.Id_Author
--WHERE Books.[Name] LIKE N'Реестр Windows 2000' AND Authors.FirstName = N'Ольга' AND Authors.LastName = N'Кокорева'

/*6. Отобразить информацию об авторах, средний объем книг которых (в страницах) более 600 страниц.*/

--SELECT Authors.FirstName, Authors.LastName, Books.Pages
--FROM Authors JOIN Books
--	ON Authors.Id = Books.Id_Author
--GROUP BY Authors.FirstName, Authors.LastName, Books.Pages
--HAVING AVG(Books.Pages) > 600

/*7. Отобразить информацию об издательствах, у которых общее коли-чество страниц выпущенных ими книг больше 700. */

--SELECT Press.[Name], Books.Pages
--FROM Press JOIN Books
--	ON Press.Id = Books.Id_Press
--GROUP BY Press.[Name], Books.Pages
--HAVING AVG(Books.Pages) > 700

/*8. Отобразить всех посетителей библиотеки (и студентов и препода-вателей) и книги, которые они брали. */

--SELECT Students.FirstName, Students.LastName, [Groups].[Name], Books.[Name]
--FROM Students JOIN S_Cards
--	ON Students.Id = S_Cards.Id_Student
--	JOIN Books
--	ON Books.Id = S_Cards.Id_Book
--	JOIN [Groups]
--	ON Students.Id_Group = Groups.Id
--UNION ALL
--SELECT Teachers.FirstName, Teachers.LastName, Departments.[Name], Books.[Name]
--FROM Teachers JOIN T_Cards
--	ON Teachers.Id = T_Cards.Id_Teacher
--	JOIN Books
--	ON Books.Id = T_Cards.Id_Book
--	JOIN Departments
--	ON Departments.Id = Teachers.Id_Dep

/*9. Вывести самого популярного автора(ов) среди студентов и количе-ство книг этого автора, взятых в библиотеке. */

--SELECT TOP (1) with ties Authors.FirstName, Authors.LastName, COUNT(S_Cards.Id) AS TakeCount
--FROM 
--(
--	Authors JOIN Books 
--		ON Authors.Id = Books.Id_Author
--) JOIN S_Cards 
--	ON Books.Id = S_Cards.Id_Book
--GROUP BY Authors.FirstName, Authors.LastName
--ORDER BY COUNT(S_Cards.Id) DESC;

/*10. Вывести самого популярного автора(ов) среди преподавате-лей и количество книг этого автора, взятых в библиотеке. */

--SELECT TOP (1) with ties Authors.FirstName, Authors.LastName, COUNT(T_Cards.Id) AS TakeCount
--FROM 
--(
--	Authors JOIN Books 
--		ON Authors.Id = Books.Id_Author
--) JOIN T_Cards 
--	ON Books.Id = T_Cards.Id_Book
--GROUP BY Authors.FirstName, Authors.LastName
--ORDER BY COUNT(T_Cards.Id) DESC;

/*11. Вывести самую популярную(ые) тематику(и) среди студентов и преподавателей. */

--SELECT Themes.[Name]
--FROM Themes

/*12. Отобразить количество преподавателей и студентов, посетивших библиотеку. ? */

--SELECT COUNT(T_Cards.Id_Lib) AS TeachersCount, COUNT(S_Cards.Id_Lib) AS StudentsCount
--FROM T_Cards JOIN Libs
--	ON T_Cards.Id_Lib = Libs.Id
--	JOIN S_Cards
--	ON S_Cards.Id_Lib = Libs.Id

/*13. Если считать общее количество книг в библиотеке за 100%, то необходимо подсчитать, сколько книг (в процентном отношении) брал каждый факультет. */



/*14. Отобразить самый читающий факультет и самую читающую
кафедру.
15. Показать автора (ов) самых популярных книг среди препода-
вателей и студентов.

16. Отобразить названия самых популярных книг среди препода-
вателей и студентов.
17. Показать всех студентов и преподавателей дизайнеров.
18. Показать всю информацию о студентах и преподавателях,
бравших книги.
19. Показать книги, которые брали и преподаватели и студенты.
20. Показать сколько книг выдал каждый из библиотекарей.*/

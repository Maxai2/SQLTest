/* 1. Отобразить все издательства, которые выпустили новинки после 2000 года. */

--SELECT Publisher, YEAR([Date]) AS [Year]
--FROM Books
--WHERE YEAR([Date]) >= 2000 AND New = 1
--ORDER BY [Year]

/*2. Отобразить книги, у которых количество страниц больше, чем среднее арифметическое число страниц всех книг.*/

--SELECT [Name], Pages
--FROM Books 
--WHERE Pages > 
--(
--SELECT AVG(Pages)
--FROM Books
--)
--ORDER BY Pages

/*3. Отобразить тематики и сумму страниц по тематикам, учитывая при этом только книги с ценой >50. */ 

--SELECT Topic, COUNT(Pages) AS SumCount
--FROM Books
--WHERE Price > 50
--GROUP BY Topic
--ORDER BY SumCount

/*4. Отобразить все темы, у которых не указана категория. */

--SELECT Topic, Category
--FROM Books
--WHERE Category IS NULL

/*5. Отобразить самую дорогую книгу издательства BHV (2 способа). */

--SELECT MAX(Price) AS MaxPrice, Publisher
--FROM Books
--GROUP BY Publisher
--HAVING Publisher LIKE N'BHV%'

/* 6. Отобразить издательство, у которого наибольшее количество страниц (2 способа). */

--SELECT TOP(1) Publisher, MAX(Pages) AS MaxPages 
--FROM Books 
--GROUP BY Publisher
--ORDER BY MaxPages DESC

/* 7. Отобразить издательство, у которого наибольшее количество книг по программированию (2 способа). */

--SELECT Publisher, COUNT(*) AS PublisherCount
--FROM Books
--GROUP BY Publisher, Topic
--HAVING Topic = N'Программирование'
--ORDER BY PublisherCount

/* 8. Определить, сколько издано книг по каждой тематике. */

--SELECT COUNT(*) AS CountOfBooks, Topic
--FROM Books
--GROUP BY Topic
--ORDER BY CountOfBooks

/* 9. Отобразить самую дешевую книгу в каждой из следующих тематик:Программирование, Базы данных клиент-сервер, Мультимедиа. */

--SELECT MIN(Price) AS MinPrice, Topic
--FROM Books
--GROUP BY Topic
--HAVING Topic IN (N'Программирование', N'Базы данных клиент-сервер', N'Мультимедиа')
--ORDER BY MinPrice

/* 10. Показать издательства и самую старую книгу для каждого из них. */


--SELECT Publisher, MIN(YEAR(Date)) AS OldBook
--FROM Books
--GROUP BY Publisher
--ORDER By OldBook DESC

/* 11. Показать количество выпущенных книг-новинок по каждому издательству. */

--SELECT COUNT(*) AS BooksCount, Publisher
--FROM Books
--GROUP BY Publisher, New
--HAVING New = 1

/* 12. Отобразить издательство, у которого наибольшее количество книг-новинок (2 способа). */

--SELECT TOP(1) Publisher, COUNT(New) AS NewBooksCount
--FROM Books
--GROUP BY Publisher
--ORDER BY NewBooksCount DESC

/* 13. Вывести процентный вклад каждой тематики в прайс-листе. */

--SELECT (SUM(Price) / (SELECT SUM(Price) FROM Books) * 100 ) AS TopicPrice, Topic
--FROM Books
--GROUP BY Topic

/* 14. Найти среднюю цену книг, выпущенных издательствами весной 1999 года, для каждого издательства. */

--SELECT AVG(Price) AS AvgPrice, (CONCAT(MONTH([Date]), '/',  YEAR([Date]))) AS [Year], Publisher -- FORMAT([Date], 'mm/yyyy')
--FROM Books
--WHERE YEAR([Date]) = N'1999' AND (MONTH([Date]) BETWEEN 3 AND 6)
--GROUP BY [Date], Publisher
--ORDER BY Publisher

/* 15. Вывести книгу, выпущенную наибольшим тиражом (2 способа). */

--SELECT TOP(1) [Name], MAX(Pressrun) AS MaxPressrun
--FROM Books
--GROUP BY [Name]
--ORDER BY MaxPressrun DESC

/* 16. Вывести издательства, у которых число выпущенных книг превышает 5% от общего числа книг. */

--SELECT COUNT(*) AS PublisherCount, Publisher
--FROM Books
--GROUP BY Publisher
--HAVING COUNT(*) > (SELECT COUNT(*) FROM Books) / 100 * 5
--ORDER BY PublisherCount

/* 17. Вывести книгу, в коде которой присутствуют ровно 2 семерки. */

--SELECT Code, [Name]
--FROM Books
--WHERE Code LIKE N'%2%2%'

/* 18. Вывести издательства, из букв которых можно собрать слово «лак». */

--SELECT Publisher
--FROM Books
--WHERE Publisher LIKE N'%ë%à%ê%' OR Publisher LIKE N'%ê%à%ë%' OR Publisher LIKE N'%ê%ë%à%' OR Publisher LIKE  N'%à%ë%ê%'

/* 19. Вывести книги, названия которых не содержат английских букв, с числом страниц, кратным 2. */

--SELECT [Name], Pages
--FROM Books
--WHERE CAST(Pages AS INT) % 2 = 0 AND [Name] NOT LIKE N'%[A-Z]%' 

/* 20. Вывести количество книг, у которых не указана дата выпуска. */

--SELECT COUNT(*) AS DateCount
--FROM Books
--WHERE [Date] IS NULL

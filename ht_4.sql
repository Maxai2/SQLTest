/* 1. ���������� ��� ������������, ������� ��������� ������� ����� 2000 ����. */

--SELECT Publisher, YEAR([Date]) AS [Year]
--FROM Books
--WHERE YEAR([Date]) >= 2000 AND New = 1
--ORDER BY [Year]

/*2. ���������� �����, � ������� ���������� ������� ������, ��� ������� �������������� ����� ������� ���� ����.*/

--SELECT [Name], Pages
--FROM Books 
--WHERE Pages > 
--(
--SELECT AVG(Pages)
--FROM Books
--)
--ORDER BY Pages

/*3. ���������� �������� � ����� ������� �� ���������, �������� ��� ���� ������ ����� � ����� > 50. */ 

--SELECT Topic, COUNT(Pages) AS SumCount
--FROM Books
--WHERE Price > 50
--GROUP BY Topic
--ORDER BY SumCount

/*4. ���������� ��� ����, � ������� �� ������� ���������. */

--SELECT Topic, Category
--FROM Books
--WHERE Category IS NULL

/*5. ���������� ����� ������� ����� ������������ BHV (2 �������). */

--SELECT MAX(Price) AS MaxPrice, Publisher
--FROM Books
--GROUP BY Publisher
--HAVING Publisher LIKE N'BHV%'

/* 6. ���������� ������������, � �������� ���������� ���������� ������� (2 �������). */

--SELECT TOP(1) Publisher, MAX(Pages) AS MaxPages 
--FROM Books 
--GROUP BY Publisher
--ORDER BY MaxPages DESC

/* 7. ���������� ������������, � �������� ���������� ���������� ���� �� ���������������� (2 �������). */

--SELECT Publisher, COUNT(*) AS PublisherCount
--FROM Books
--GROUP BY Publisher, Topic
--HAVING Topic = N'����������������'
--ORDER BY PublisherCount

/* 8. ����������, ������� ������ ���� �� ������ ��������. */

--SELECT COUNT(*) AS CountOfBooks, Topic
--FROM Books
--GROUP BY Topic
--ORDER BY CountOfBooks

/* 9. ���������� ����� ������� ����� � ������ �� ��������� �������: ����������������, ���� ������ ������-������, �����������. */

--SELECT MIN(Price) AS MinPrice, Topic
--FROM Books
--GROUP BY Topic
--HAVING Topic IN (N'����������������', N'���� ������ ������-������', N'�����������')
--ORDER BY MinPrice

/* 10. �������� ������������ � ����� ������ ����� ��� ������� �� ���. */


--SELECT Publisher, MIN(YEAR(Date)) AS OldBook
--FROM Books
--GROUP BY Publisher
--ORDER By OldBook DESC

/* 11. �������� ���������� ���������� ����-������� �� ������� ������������. */

--SELECT COUNT(*) AS BooksCount, Publisher
--FROM Books
--GROUP BY Publisher, New
--HAVING New = 1

/* 12. ���������� ������������, � �������� ���������� ���������� ����-������� (2 �������). */

--SELECT TOP(1) Publisher, COUNT(New) AS NewBooksCount
--FROM Books
--GROUP BY Publisher
--ORDER BY NewBooksCount DESC

/* 13. ������� ���������� ����� ������ �������� � �����-�����. */

--SELECT (SUM(Price) / (SELECT SUM(Price) FROM Books) * 100 ) AS TopicPrice, Topic
--FROM Books
--GROUP BY Topic

/* 14. ����� ������� ���� ����, ���������� �������������� ������ 1999 ����, ��� ������� ������������. */

--SELECT AVG(Price) AS AvgPrice, (CONCAT(MONTH([Date]), '/',  YEAR([Date]))) AS [Year], Publisher -- FORMAT([Date], 'mm/yyyy')
--FROM Books
--WHERE YEAR([Date]) = N'1999' AND (MONTH([Date]) BETWEEN 3 AND 6)
--GROUP BY [Date], Publisher
--ORDER BY Publisher

/* 15. ������� �����, ���������� ���������� ������� (2 �������). */

--SELECT TOP(1) [Name], MAX(Pressrun) AS MaxPressrun
--FROM Books
--GROUP BY [Name]
--ORDER BY MaxPressrun DESC

/* 16. ������� ������������, � ������� ����� ���������� ���� ��������� 5% �� ������ ����� ����. ? */

--SELECT (SELECT COUNT(*) FROM Books) * COUNT(*) AS PublisherCount, Publisher
--FROM Books
--GROUP BY Publisher
--ORDER BY PublisherCount

/* 17. ������� �����, � ���� ������� ������������ ����� 2 �������.*/

--SELECT Code, [Name]
--FROM Books
--WHERE Code LIKE N'%2%2%'

/* 18. ������� ������������, �� ���� ������� ����� ������� ����� ����. */

--SELECT Publisher
--FROM Books
--WHERE Publisher LIKE N'%�%�%�%' OR Publisher LIKE N'%�%�%�%' OR Publisher LIKE N'%�%�%�%' OR Publisher LIKE  N'%�%�%�%'

/* 19. ������� �����, �������� ������� �� �������� ���������� ����, � ������ �������, ������� 2. */

--SELECT [Name], Pages
--FROM Books
--WHERE CAST(Pages AS INT) % 2 = 0 AND [Name] NOT LIKE N'%[A-Z]%' 

/* 20. ������� ���������� ����, � ������� �� ������� ���� �������. */

--SELECT COUNT(*) AS DateCount
--FROM Books
--WHERE [Date] IS NULL
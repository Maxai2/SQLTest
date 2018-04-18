/* 1. Îòîáðàçèòü âñå èçäàòåëüñòâà, êîòîðûå âûïóñòèëè íîâèíêè ïîñëå 2000 ãîäà. */

--SELECT Publisher, YEAR([Date]) AS [Year]
--FROM Books
--WHERE YEAR([Date]) >= 2000 AND New = 1
--ORDER BY [Year]

/*2. Îòîáðàçèòü êíèãè, ó êîòîðûõ êîëè÷åñòâî ñòðàíèö áîëüøå, ÷åì ñðåäíåå àðèôìåòè÷åñêîå ÷èñëî ñòðàíèö âñåõ êíèã.*/

--SELECT [Name], Pages
--FROM Books 
--WHERE Pages > 
--(
--SELECT AVG(Pages)
--FROM Books
--)
--ORDER BY Pages

/*3. Îòîáðàçèòü òåìàòèêè è ñóììó ñòðàíèö ïî òåìàòèêàì, ó÷èòûâàÿ ïðè ýòîì òîëüêî êíèãè ñ öåíîé > 50. */ 

--SELECT Topic, COUNT(Pages) AS SumCount
--FROM Books
--WHERE Price > 50
--GROUP BY Topic
--ORDER BY SumCount

/*4. Îòîáðàçèòü âñå òåìû, ó êîòîðûõ íå óêàçàíà êàòåãîðèÿ. */

--SELECT Topic, Category
--FROM Books
--WHERE Category IS NULL

/*5. Îòîáðàçèòü ñàìóþ äîðîãóþ êíèãó èçäàòåëüñòâà BHV (2 ñïîñîáà). */

--SELECT MAX(Price) AS MaxPrice, Publisher
--FROM Books
--GROUP BY Publisher
--HAVING Publisher LIKE N'BHV%'

/* 6. Îòîáðàçèòü èçäàòåëüñòâî, ó êîòîðîãî íàèáîëüøåå êîëè÷åñòâî ñòðàíèö (2 ñïîñîáà). */

--SELECT TOP(1) Publisher, MAX(Pages) AS MaxPages 
--FROM Books 
--GROUP BY Publisher
--ORDER BY MaxPages DESC

/* 7. Îòîáðàçèòü èçäàòåëüñòâî, ó êîòîðîãî íàèáîëüøåå êîëè÷åñòâî êíèã ïî ïðîãðàììèðîâàíèþ (2 ñïîñîáà). */

--SELECT Publisher, COUNT(*) AS PublisherCount
--FROM Books
--GROUP BY Publisher, Topic
--HAVING Topic = N'Ïðîãðàììèðîâàíèå'
--ORDER BY PublisherCount

/* 8. Îïðåäåëèòü, ñêîëüêî èçäàíî êíèã ïî êàæäîé òåìàòèêå. */

--SELECT COUNT(*) AS CountOfBooks, Topic
--FROM Books
--GROUP BY Topic
--ORDER BY CountOfBooks

/* 9. Îòîáðàçèòü ñàìóþ äåøåâóþ êíèãó â êàæäîé èç ñëåäóþùèõ òåìàòèê: Ïðîãðàììèðîâàíèå, Áàçû äàííûõ êëèåíò-ñåðâåð, Ìóëüòèìåäèà. */

--SELECT MIN(Price) AS MinPrice, Topic
--FROM Books
--GROUP BY Topic
--HAVING Topic IN (N'Ïðîãðàììèðîâàíèå', N'Áàçû äàííûõ êëèåíò-ñåðâåð', N'Ìóëüòèìåäèà')
--ORDER BY MinPrice

/* 10. Ïîêàçàòü èçäàòåëüñòâà è ñàìóþ ñòàðóþ êíèãó äëÿ êàæäîãî èç íèõ. */


--SELECT Publisher, MIN(YEAR(Date)) AS OldBook
--FROM Books
--GROUP BY Publisher
--ORDER By OldBook DESC

/* 11. Ïîêàçàòü êîëè÷åñòâî âûïóùåííûõ êíèã-íîâèíîê ïî êàæäîìó èçäàòåëüñòâó. */

--SELECT COUNT(*) AS BooksCount, Publisher
--FROM Books
--GROUP BY Publisher, New
--HAVING New = 1

/* 12. Îòîáðàçèòü èçäàòåëüñòâî, ó êîòîðîãî íàèáîëüøåå êîëè÷åñòâî êíèã-íîâèíîê (2 ñïîñîáà). */

--SELECT TOP(1) Publisher, COUNT(New) AS NewBooksCount
--FROM Books
--GROUP BY Publisher
--ORDER BY NewBooksCount DESC

/* 13. Âûâåñòè ïðîöåíòíûé âêëàä êàæäîé òåìàòèêè â ïðàéñ-ëèñòå. */

--SELECT (SUM(Price) / (SELECT SUM(Price) FROM Books) * 100 ) AS TopicPrice, Topic
--FROM Books
--GROUP BY Topic

/* 14. Íàéòè ñðåäíþþ öåíó êíèã, âûïóùåííûõ èçäàòåëüñòâàìè âåñíîé 1999 ãîäà, äëÿ êàæäîãî èçäàòåëüñòâà. */

--SELECT AVG(Price) AS AvgPrice, (CONCAT(MONTH([Date]), '/',  YEAR([Date]))) AS [Year], Publisher -- FORMAT([Date], 'mm/yyyy')
--FROM Books
--WHERE YEAR([Date]) = N'1999' AND (MONTH([Date]) BETWEEN 3 AND 6)
--GROUP BY [Date], Publisher
--ORDER BY Publisher

/* 15. Âûâåñòè êíèãó, âûïóùåííóþ íàèáîëüøèì òèðàæîì (2 ñïîñîáà). */

--SELECT TOP(1) [Name], MAX(Pressrun) AS MaxPressrun
--FROM Books
--GROUP BY [Name]
--ORDER BY MaxPressrun DESC

/* 16. Âûâåñòè èçäàòåëüñòâà, ó êîòîðûõ ÷èñëî âûïóùåííûõ êíèã ïðåâûøàåò 5% îò îáùåãî ÷èñëà êíèã. ? */

--SELECT COUNT(*) AS PublisherCount, Publisher
--FROM Books
--GROUP BY Publisher
--HAVING COUNT(*) > (SELECT COUNT(*) FROM Books) / 100 * 5
--ORDER BY PublisherCount

/* 17. Âûâåñòè êíèãó, â êîäå êîòîðîé ïðèñóòñòâóþò ðîâíî 2 ñåìåðêè.*/

--SELECT Code, [Name]
--FROM Books
--WHERE Code LIKE N'%2%2%'

/* 18. Âûâåñòè èçäàòåëüñòâà, èç áóêâ êîòîðûõ ìîæíî ñîáðàòü ñëîâî «ëàê». */

--SELECT Publisher
--FROM Books
--WHERE Publisher LIKE N'%ë%à%ê%' OR Publisher LIKE N'%ê%à%ë%' OR Publisher LIKE N'%ê%ë%à%' OR Publisher LIKE  N'%à%ë%ê%'

/* 19. Âûâåñòè êíèãè, íàçâàíèÿ êîòîðûõ íå ñîäåðæàò àíãëèéñêèõ áóêâ, ñ ÷èñëîì ñòðàíèö, êðàòíûì 2. */

--SELECT [Name], Pages
--FROM Books
--WHERE CAST(Pages AS INT) % 2 = 0 AND [Name] NOT LIKE N'%[A-Z]%' 

/* 20. Âûâåñòè êîëè÷åñòâî êíèã, ó êîòîðûõ íå óêàçàíà äàòà âûïóñêà. */

--SELECT COUNT(*) AS DateCount
--FROM Books
--WHERE [Date] IS NULL

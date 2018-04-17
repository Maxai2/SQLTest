-- 1. ѕолучить empid, firstname, lastname, country, region, city всех работников из USA.

--SELECT BusinessEntityID AS empid, FirstName, LastName, CountryRegionName, City
--FROM Employees
--WHERE CountryRegionName = 'United States'

-- 2. ѕолучить количество работников по каждой специальности.

--SELECT COUNT(JobTitle) AS CountOfJpbTitle, JobTitle
--FROM Employees
--GROUP BY JobTitle

-- 3. ѕосчитать сколько людей на каждое им€.

--SELECT COUNT(FirstName) AS FirstNameCount, FirstName 
--FROM Employees
--GROUP BY FirstName

-- 4. ѕолучить самое распространенное им€.

--SELECT TOP(1) COUNT(FirstName) AS FirstNameCount, FirstName 
--FROM Employees
--GROUP BY FirstName
--ORDER BY FirstNameCount DESC

-- 5. ѕолучить наименее распространенное им€.

--SELECT TOP(1) WITH TIES FirstName, COUNT(FirstName) AS FirstNameCount, FirstName 
--FROM Employees
--GROUP BY FirstName
--ORDER BY FirstNameCount ASC

-- 6. ѕолучить топ 5 городов, где больше всего работников.

--SELECT TOP(5) COUNT(City) AS CityCount, City, FirstName 
--FROM Employees
--GROUP BY City, FirstName
--ORDER BY CityCount DESC

-- 7. ѕолучить топ 5 городов, в которых больше всего уникальных специальностей.

--SELECT TOP(5) COUNT(*) AS JobCount, JobTitle
--FROM Employees
--GROUP BY JobTitle
--ORDER BY JobCount ASC

-- 8. ¬ыдать почтовые адреса дл€ email-рассылки всем работникам, которые начали работать с 01/01/2012.

--SELECT EmailAddress, StartDate
--FROM Employees
--WHERE StartDate > '2012/01/01'

-- 9. ¬ыдать статистику в каком году сколько работников было нан€то.

--SELECT StartDate, COUNT(*) AS StartDateCount
--FROM Employees
--GROUP BY StartDate
--ORDER BY StartDateCount DESC

-- 10. ¬ыдать статистику в каком году сколько работников по каким странам было нан€то.

--SELECT StartDate, COUNT(*) AS CountOfWorker, City
--FROM Employees 
--GROUP BY StartDate, City

/* 11. ќбновить таблицу Employees добавив данные из таблицы History в колонку EndDate.				  */

--UPDATE Employees
--SET EndDate = History.EndDate
--FROM History
--WHERE Employees.BusinessEntityID = History.BusinessEntityID

/* 12. ¬ыдать статистику сколько работников в какой год уволилось.									  */

--SELECT EndDate, COUNT(*) AS EndDateCountWorker
--FROM Employees
--GROUP BY EndDate

/* 13. ¬ыдать количество работников, которые проработали меньше года.								  */

--SELECT COUNT(*), FirstName
--FROM Employees
--WHERE EndDate < StartDate
--GROUP BY FirstName
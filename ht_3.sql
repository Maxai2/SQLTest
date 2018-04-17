-- 1. �������� empid, firstname, lastname, country, region, city ���� ���������� �� USA.

--SELECT BusinessEntityID AS empid, FirstName, LastName, CountryRegionName, City
--FROM Employees
--WHERE CountryRegionName = 'United States'

-- 2. �������� ���������� ���������� �� ������ �������������.

--SELECT COUNT(JobTitle) AS CountOfJpbTitle, JobTitle
--FROM Employees
--GROUP BY JobTitle

-- 3. ��������� ������� ����� �� ������ ���.

--SELECT COUNT(FirstName) AS FirstNameCount, FirstName 
--FROM Employees
--GROUP BY FirstName

-- 4. �������� ����� ���������������� ���.

--SELECT TOP(1) COUNT(FirstName) AS FirstNameCount, FirstName 
--FROM Employees
--GROUP BY FirstName
--ORDER BY FirstNameCount DESC

-- 5. �������� �������� ���������������� ���.

--SELECT TOP(1) WITH TIES FirstName, COUNT(FirstName) AS FirstNameCount, FirstName 
--FROM Employees
--GROUP BY FirstName
--ORDER BY FirstNameCount ASC

-- 6. �������� ��� 5 �������, ��� ������ ����� ����������.

--SELECT TOP(5) COUNT(City) AS CityCount, City, FirstName 
--FROM Employees
--GROUP BY City, FirstName
--ORDER BY CityCount DESC

-- 7. �������� ��� 5 �������, � ������� ������ ����� ���������� ��������������.

--SELECT TOP(5) COUNT(*) AS JobCount, JobTitle
--FROM Employees
--GROUP BY JobTitle
--ORDER BY JobCount ASC

-- 8. ������ �������� ������ ��� email-�������� ���� ����������, ������� ������ �������� � 01/01/2012.

--SELECT EmailAddress, StartDate
--FROM Employees
--WHERE StartDate > '2012/01/01'

-- 9. ������ ���������� � ����� ���� ������� ���������� ���� ������.

--SELECT StartDate, COUNT(*) AS StartDateCount
--FROM Employees
--GROUP BY StartDate
--ORDER BY StartDateCount DESC

-- 10. ������ ���������� � ����� ���� ������� ���������� �� ����� ������� ���� ������.

--SELECT StartDate, COUNT(*) AS CountOfWorker, City
--FROM Employees 
--GROUP BY StartDate, City

/* 11. �������� ������� Employees ������� ������ �� ������� History � ������� EndDate.				  */

--UPDATE Employees
--SET EndDate = History.EndDate
--FROM History
--WHERE Employees.BusinessEntityID = History.BusinessEntityID

/* 12. ������ ���������� ������� ���������� � ����� ��� ���������.									  */

--SELECT EndDate, COUNT(*) AS EndDateCountWorker
--FROM Employees
--GROUP BY EndDate

/* 13. ������ ���������� ����������, ������� ����������� ������ ����.								  */

--SELECT COUNT(*), FirstName
--FROM Employees
--WHERE EndDate < StartDate
--GROUP BY FirstName
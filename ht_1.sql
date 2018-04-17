-- 1. �������� �������� ���� ����, � ����� ��������� ��������� ����� ������ ������ �� ���� ����.

--SELECT [Name], Price * Pressrun AS PressRunSum
--FROM Books

-- 2. �������� ��������� ���� ����, ������ ���, ����� �������� ��������� �� �����������.

--SELECT DISTINCT Category
--FROM Books

-- 3. �������� ���� ���� ����, ������ ���, ����� �������� ��� �� �����������.\

--SELECT DISTINCT Publisher
--FROM Books

-- 4. �������� ���, �������� ���� � ���� �� 1 ��������.

--SELECT Code, [Name], Pages / Price AS PriceByPage
--FROM Books

-- 1. �������� ��� �����, ���������� ����� ������������� ����� ������������ ������ � ��� ���� ������� 20 �.

--SELECT [Name], Publisher, Price
--FROM Books
--WHERE Publisher != N'�����' AND Price < 20
--ORDER BY Price

-- 2. �������� ��� �����, ���������� ����� ������������� ����� ������������ ������ � ��� ���� � ����� � ��������� �� 20 �� 40 �.

--SELECT [Name], Publisher, Price
--FROM Books
--WHERE Publisher != N'�����' AND Price BETWEEN 20 AND 40
--ORDER BY Price

-- 3. �������� ��� �����, ���������� ����� ������������� ����� ������������ ������ � ��� ���� � ����� ���� � ��������� �� 20 �� 40 �., ���� ����� 10 �.

--SELECT [Name], Publisher, Price
--FROM Books
--WHERE Publisher != N'�����' AND ((Price BETWEEN 20 AND 40) OR (Price < 10))
--ORDER BY Price

--4. �������� ��� �����, ���� ����� �������� ������� ������ 10 ������.

--SELECT [Name], Price
--FROM Books
--WHERE Pages / Price < 10
--ORDER BY Price

-- 5. �������� ��� �����, ������� �������� ���� ����������, ���� ������� �� ���� �C&C++�, � ��� ���� ��������� ���� ������������� ������, ���� ������������� �DiaSoft�.

--SELECT [Name], Publisher, Category
--FROM Books
--WHERE (Category = N'��������' OR [Name] LIKE N'%C++%' OR [Name] LIKE N'%C/C++%') AND (Publisher = N'DiaSoft' OR Publisher = N'�����')
--ORDER BY [Name]

-- 1. �������� ��� �� �����, � ��������� ������� ������������ ����� �Windows�.

--SELECT [Name]
--FROM Books
--WHERE [Name] LIKE N'%Windows%'
--ORDER BY [Name]

-- 2. �������� ��� �� �����, � ��������� ������� ������������ ����� �Windows�, �� �� ������������ ����� �Microsoft�.

--SELECT [Name]
--FROM Books
--WHERE [Name] LIKE N'%Windows%' AND [Name] NOT LIKE N'%Microsoft%'
--ORDER BY [Name]

-- 3. �������� ��� �� �����, � ��������� ������� ������������ ��� ������� ���� �����.

--SELECT [Name]
--FROM Books
--WHERE [Name] LIKE '%[0-9]%'

-- 4. �������� ��� �� �����, � ��������� ������� ������������ ������� ���� ����.

--SELECT [Name]
--FROM Books
--WHERE [Name] LIKE '%[0-9][0-9][0-9]%'

-- 5. �������� � ������� Books ���������� � ����� ������ ����������� ����� ���������������� �++�.

--INSERT INTO Books (New, [Name], Price, Pages, [Format], [Date], Pressrun, Category, Publisher, Topic)
--VALUES (1, '����� ���������� ����� ���������������� �++�', 351.00, 369, '170x240/16', '2015/01/01', 3000, 'C&C++', '�����', '����������������')

--SELECT * 
--FROM Books
--WHERE [Name] = '����� ���������� ����� ���������������� �++�'

-- 6. ������� ��� ����� �� 10 ���������.

--UPDATE Books
--SET Price /= 10 
--WHERE [Name] = '����� ���������� ����� ���������������� �++�'

-- 7. ������� ��� �� �����, � ���� ������� ������������ ����� 6 ��� 7.

--DELETE FROM Books
--WHERE Code LIKE '%6%' OR Code LIKE '%7%'
/*1. �� ����������. �� ��������� ��������� ��������� �����. (5! = 1*2*3*4*5 = 120) (0! = 1) (���������� �������������� ����� �� ����������). */

--CREATE PROCEDURE Fact
--	@num int,
--	@ans int OUTPUT
--AS
--BEGIN
--	DECLARE @temp int = 1;

--	WHILE(@num != 0)
--	BEGIN
--		SET @temp *= @num
--		SET @num -= 1
--	END

--	SET @ans = @temp
--END

--DECLARE @tempIn int = 0;
--EXEC Fact 7, @tempIn OUTPUT
--PRINT @tempIn

/*2. �� �������� ���������. �� ������� ���������, ������� ������� �� ����� ����� � ���������� � ����� �������� �������� ���������� ���������� ���� ���������. */

--CREATE PROCEDURE LazyStud
--	@ans int OUTPUT
--AS
--BEGIN
--	DECLARE @temp int = 0
--	SELECT @temp = (SELECT COUNT(*) FROM Students) - (SELECT COUNT(*) FROM S_Cards)

--	SET @ans = @temp
--END

--DECLARE @tempIn int = 0
--EXEC LazyStud @tempIn OUTPUT
--PRINT @tempIn 

/*3. �� ������ �� ���������. �� ������� ������ ����, ���������� ������ ���������. ��������: ��� ������, ������� ������, ��������, ���������. 
����� ����, ������ ������ ���� ������������ �� ������ �������, ���������� � 5-� ���������, � �����������, ��������� � 6-� ���������. 
�������: 1) ������������� �����, 2) �������� �����, 3) ������� � ��� ������, 4) ����, 5) ���������. */

--CREATE PROCEDURE BooksByParam
--	@AutorFName nvarchar(15),
--	@AutorLName nvarchar(15),
--	@ThemeName nvarchar(15),
--	@CategName nvarchar(15)
--AS
--BEGIN
--	DECLARE @TempTable TABLE(Id int, BookName nvarchar(30), AuthorName nvarchar(30), ThemeName nvarchar(20), CategName nvarchar(20))
	
--	INSERT INTO @TempTable
--	SELECT Books.Id, Books.[Name] AS BookName, (Authors.LastName + ' ' + Authors.FirstName) AS AuthorName, 
--			Themes.[Name] AS ThemeName, Categories.[Name] AS CategName
--	FROM Books JOIN Authors
--		ON Books.Id_Author = Authors.Id
--		JOIN Themes
--		ON Books.Id_Themes = Themes.Id
--		JOIN Categories
--		ON Books.Id_Category = Categories.Id
--	WHERE Authors.FirstName = @AutorFName AND Authors.LastName = @AutorLName 
--		AND Themes.[Name] = @ThemeName AND Categories.[Name] = @CategName
--	ORDER BY Categories.Id

--	SELECT *
--	FROM @TempTable

--END

--DECLARE @TempInTable TABLE(Id int, BookName nvarchar(30), AuthorName nvarchar(30), ThemeName nvarchar(20), CategName nvarchar(20))

--INSERT INTO @TempInTable
--EXEC BooksByParam N'�����', N'������', N'���� ������', N'���� SQL'

--SELECT * 
--FROM @TempInTable

--SELECT Authors.FirstName, Authors.LastName, Themes.[Name] AS ThemeName, Categories.[Name] AS CategName
--FROM Books JOIN Authors
--	ON Books.Id_Author = Authors.Id
--	JOIN Themes
--	ON Books.Id_Themes = Themes.Id
--	JOIN Categories
--	ON Books.Id_Category = Categories.Id
--ORDER BY Themes.Id

/*4. �� ����������� ���������. �� ��������� �������� � ������. �� ��������� ���, ������� �������� � �������� ������. 
���� ������ � ����� ��������� ����������, �� � Id_Group ���������� Id ���� ������. 
���� ������ � ����� ������ �� ����������, �� ������� ��������� ������, � ����� ��������. 
�������� ��������, ��� �������� ����� �������� � ������� ��������, �� ����� �� �����������, 
��� ������������ �������� �������� � ������� ��������. */

CREATE PROCEDURE AddStud
	@StudFName nvarchar(15),
	@StudLName nvarchar(15),
	@GroupName nvarchar(10)
AS
BEGIN
	
	DECLARE @IdGroup int = 0;

	IF (@GroupName = (SELECT Groups.[Name] FROM Groups))
	BEGIN
		SELECT @IdGroup = Groups.Id
		FROM Groups
		WHERE Groups.[Name] = @GroupName
	END
	ELSE
	BEGIN
	END

	INSERT INTO Students (IdFirstName, LastName, Id_Group, Term)
	SELECT @StudFName, @StudLName

END



/*5. �� �������� ���������� ����. �� �������� ���-5 ����� ���������� ���� (�����
��������� � �������������� ������������) � �������� ��� �� 3 ����������
�����.
6. �� ����������� �� ������������ ����. �� �������� ���-5 �� ���������� ���� �
������ �������� ������� �������� ���������.
7. �� �������� ����� �����. �� �������� Id �������� � Id �����, ��������� ����
���������� ���� ������ ����, ����� ������ �������� �����. ��� ������ ��������
����� ���������� ��������� �� ���������� � ����������. ����� ��� ���
�������� ����� ��������� ������� ��� ���� �� ����� � ����� ��������. ���� 3-4
�����, �� ������� ��������������, � ���� ��� 5 ����, �� �� ������ ��� �����
�����.
8. �� �������������� ����� �����.
9. �� �������� ���������� �����. �� �������� Id �������� � Id �����. � �������
S_Cards ��������� ���������� � ����������� �����. ���� ������� ������ �
���� ����� ������ ����, �� ��� ������������ �����.
10.�� �������������� ���������� �����.*/
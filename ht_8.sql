/*1. ХП “Факториал”. ХП вычисляет факториал заданного числа. (5! = 1*2*3*4*5 = 120) (0! = 1) (факториала отрицательного числа не существует). */

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

/*2. ХП “Ленивые студенты”. ХП выводит студентов, которые никогда не брали книги в библиотеке и через выходной параметр возвращает количество этих студентов. */

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

/*3. ХП “Книги по критериям”. ХП выводит список книг, отвечающих набору критериев. Критерии: имя автора, фамилия автора, тематика, категория. 
Кроме того, список должен быть отсортирован по номеру колонки, указанному в 5-м параметре, в направлении, указанном в 6-м параметре. 
Колонки: 1) идентификатор книги, 2) название книги, 3) фамилия и имя автора, 4) тема, 5) категория. */

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
--EXEC BooksByParam N'Борис', N'Карпов', N'Базы данных', N'Язык SQL'

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

/*4. ??? ХП “Добавление студента”. ХП добавляет студента и группу. ХП принимает имя, фамилию студента и название группы. 
Если группа с таким названием существует, то в Id_Group указываете Id этой группы. 
Если группы с таким именем не существует, то сначала добавляем группу, а потом студента. 
Обратите внимание, что названия групп хранятся в верхнем регистре, но никто не гарантирует, 
что пользователь передаст название в верхнем регистре. */

--CREATE PROCEDURE AddStud
--	@StudFName nvarchar(15),
--	@StudLName nvarchar(15),
--	@GroupName nvarchar(10)
--AS
--BEGIN
	
--	DECLARE @IdGroup int = 0;

--	IF (@GroupName = (SELECT Groups.[Name] FROM Groups))
--	BEGIN
--		SELECT @IdGroup = Groups.Id
--		FROM Groups
--		WHERE Groups.[Name] = @GroupName
--	END
--	ELSE
--	BEGIN
--		DECLARE @LastIdGroup int = 0;
--		SELECT TOP(1) @LastIdGroup = Groups.Id + 1
--		FROM Groups
--		ORDER BY Groups.Id DESC

--		INSERT INTO Groups (Id, [Name], Id_Faculty)
--		VALUES (@LastIdGroup, N'18Б', 1)

--	END

--	DECLARE @LastIdStud int = 0;
--	SELECT TOP(1) @LastIdStud = Students.Id + 1
--	FROM Students
--	ORDER BY Students.Id DESC

--	INSERT INTO Students (Id, FirstName, LastName, Id_Group, Term)
--	VALUES (@LastIdStud, @StudFName, @StudLName, @IdGroup, 1)

--END

--EXEC AddStud N'Али', N'Махмудов', N'9П1'

--SELECT * 
--FROM Students

/*5. ХП “Закупка популярных книг”. ХП выбирает топ-5 самых популярных книг (среди студентов и преподавателей одновременно)
 и покупает еще по 3 экземпляра книги. */

ALTER PROCEDURE ByePop5Books
AS
BEGIN
	UPDATE Books
	SET Books.Quantity += 0
	WHERE Books.Id IN
	(
		SELECT TOP(5) *
		FROM (SELECT *
		FROM (SELECT COUNT(S_Cards.Id_Book) AS BooksCount, Books.[Name], Books.Id
		FROM S_Cards JOIN Books
			ON S_Cards.Id_Book = Books.Id
		GROUP BY Books.[Name], Books.Id) AS Stud
		UNION
		SELECT *
		FROM (SELECT COUNT(T_Cards.Id_Book) AS BooksCount, Books.[Name], Books.Id
		FROM T_Cards JOIN Books
			ON T_Cards.Id_Book = Books.Id
		GROUP BY Books.[Name], Books.Id) AS Teach) AS TempTab
		ORDER BY TempTab.BooksCount DESC
	) 
END

SELECT Books.[Name], Books.Quantity
FROM Books
ORDER BY Books.Quantity DESC

/*6. ХП “Избавление от непопулярных книг”. ХП выбирает топ-5 не популярных книг и отдает половину другому учебному заведению. */



/*7. ХП “Студент берет книгу”. ХП получает Id студента и Id книги, проверяет если количество книг больше нуля, 
тогда выдает студенту книгу. При выдаче студенту книги необходимо уменьшать ее количество в библиотеки. Перед тем как
выдавать книгу проверяем сколько уже книг на руках у этого студента. Если 3-4
книги, то выводим предупреждение, а если уже 5 книг, то не выдаем ему новую книгу.



8. ХП “Преподаватель берет книгу”.
9. ХП “Студент возвращает книгу”. ХП получает Id студента и Id книги. В таблицу
S_Cards заносится информация о возвращении книги. Если студент держал у
себя книгу больше года, то ему выписывается штраф.
10.ХП “Преподаватель возвращает книгу”.*/

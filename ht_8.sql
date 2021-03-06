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

--	SELECT Students.FirstName, Students.LastName
--	FROM Students FULL OUTER JOIN S_Cards
--		ON Students.Id = S_Cards.Id_Student
-- 	WHERE Students.Id IS NULL OR S_Cards.Id_Student IS NULL 

--	SELECT @temp = COUNT(*)
--	FROM Students FULL OUTER JOIN S_Cards
--		ON Students.Id = S_Cards.Id_Student
--	WHERE Students.Id IS NULL OR S_Cards.Id_Student IS NULL 

--	SET @ans = @temp
--END

--DECLARE @tempIn int = 0
--EXEC LazyStud @tempIn OUTPUT
--PRINT @tempIn 

/*3. ХП “Книги по критериям”. ХП выводит список книг, отвечающих набору критериев. Критерии: имя автора, фамилия автора, тематика, категория. 
Кроме того, список должен быть отсортирован по номеру колонки, указанному в 5-м параметре, в направлении, указанном в 6-м параметре. 
Колонки: 1) идентификатор книги, 2) название книги, 3) фамилия и имя автора, 4) тема, 5) категория. */

--CREATE PROCEDURE BooksByParam -- нет
--	@AutorFName nvarchar(15),
--	@AutorLName nvarchar(15),
--	@ThemeName nvarchar(15),
--	@CategName nvarchar(15), 
--	@ColumnNumber int,
--	@Direction bit
--AS
--BEGIN
--	DECLARE @TempTable TABLE(Id int, BookName nvarchar(30), AuthorFName nvarchar(30), AuthorLName nvarchar(30), ThemeName nvarchar(20), CategName nvarchar(20))
	
--	DECLARE @OrederBy nvarchar(20)

--	INSERT INTO @TempTable
--	SELECT Books.Id, Books.[Name] AS BookName, Authors.LastName, Authors.FirstName, 
--			Themes.[Name] AS ThemeName, Categories.[Name] AS CategName
--	FROM Books JOIN Authors
--		ON Books.Id_Author = Authors.Id
--		JOIN Themes
--		ON Books.Id_Themes = Themes.Id
--		JOIN Categories
--		ON Books.Id_Category = Categories.Id
--	WHERE Authors.FirstName = @AutorFName AND Authors.LastName = @AutorLName 
--		AND Themes.[Name] = @ThemeName AND Categories.[Name] = @CategName
--	ORDER BY
--	CASE WHEN @ColumnNumber = 1 AND @Direction = 0 THEN Books.Id
--		WHEN @ColumnNumber = 2 AND @Direction = 0 THEN Books.[Name]
--		WHEN @ColumnNumber = 3 AND @Direction = 0 THEN Authors.LastName
--		WHEN @ColumnNumber = 4 AND @Direction = 0 THEN Authors.FirstName
---		WHEN @ColumnNumber = 5 AND @Direction = 0 THEN Themes.[Name]
--		WHEN @ColumnNumber = 6 AND @Direction = 0 THEN Categories.[Name]
--	END ASC,

--	CASE WHEN @ColumnNumber = 1 AND @Direction = 1 THEN Books.Id
--		WHEN @ColumnNumber = 2 AND @Direction = 1 THEN Books.[Name]
--		WHEN @ColumnNumber = 3 AND @Direction = 1 THEN Authors.LastName
--		WHEN @ColumnNumber = 4 AND @Direction = 1 THEN Authors.FirstName
--		WHEN @ColumnNumber = 5 AND @Direction = 1 THEN Themes.[Name]
--		WHEN @ColumnNumber = 6 AND @Direction = 1 THEN Categories.[Name]
--	END DESC

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

/*4. ХП “Добавление студента”. ХП добавляет студента и группу. ХП принимает имя, фамилию студента и название группы. 
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

--	IF (@GroupName = ANY (SELECT Groups.[Name] FROM Groups))
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

--CREATE PROCEDURE ByeTop5Books
--AS
--BEGIN
--	UPDATE Books
--	SET Books.Quantity += 3
--	WHERE Books.Id IN
--	(
--		SELECT TOP(5) Temp.[Name], SUM(Temp.Coun) AS Cou, Temp.Id
--		FROM (SELECT *
--		FROM (SELECT COUNT(S_Cards.Id_Book) AS Coun, Books.[Name], Books.Id
--		FROM S_Cards JOIN Books
--			ON S_Cards.Id_Book = Books.Id
--		GROUP BY Books.[Name], Books.Id
--		UNION
--		SELECT COUNT(T_Cards.Id_Book) AS Coun, Books.[Name], Books.Id
--		FROM T_Cards JOIN Books
--			ON T_Cards.Id_Book = Books.Id
--		GROUP BY Books.[Name], Books.Id) AS Main) AS Temp
--		GROUP BY Temp.[Name], Temp.Id
--		ORDER BY Cou DESC
--	) 
--END

--SELECT Books.[Name], Books.Quantity
--FROM Books
--ORDER BY Books.Quantity DESC

/*6. ХП “Избавление от непопулярных книг”. ХП выбирает топ-5 не популярных книг и отдает половину другому учебному заведению. */

--CREATE PROCEDURE LostNoTop5Books
--AS
--BEGIN
--	UPDATE Books
--	SET Books.Quantity /= 2
--	WHERE Books.Id IN
--	(
--		SELECT TOP(5) Temp.[Name], SUM(Temp.Coun) AS Cou, Temp.Id
--		FROM (SELECT *
--		FROM (SELECT COUNT(S_Cards.Id_Book) AS Coun, Books.[Name], Books.Id
--		FROM S_Cards JOIN Books
--			ON S_Cards.Id_Book = Books.Id
--		GROUP BY Books.[Name], Books.Id
--		UNION
--		SELECT COUNT(T_Cards.Id_Book) AS Coun, Books.[Name], Books.Id
--		FROM T_Cards JOIN Books
--			ON T_Cards.Id_Book = Books.Id
--		GROUP BY Books.[Name], Books.Id) AS Main) AS Temp
--		GROUP BY Temp.[Name], Temp.Id
--		ORDER BY Cou
--	) 
--END

/*7. ХП “Студент берет книгу”. ХП получает Id студента и Id книги, проверяет если количество книг больше нуля, 
тогда выдает студенту книгу. При выдаче студенту книги необходимо уменьшать ее количество в библиотеки. Перед тем как
выдавать книгу проверяем сколько уже книг на руках у этого студента. Если 3-4
книги, то выводим предупреждение, а если уже 5 книг, то не выдаем ему новую книгу. */

--CREATE PROCEDURE StudTakeBook
--	@StudId int,
--	@BookId int
--AS
--BEGIN
--	DECLARE @BookCount int = 0;
--	SELECT @BookCount = Books.Quantity
--	FROM Books
--	WHERE Books.Id = @BookId

--	IF @BookCount > 0
--	BEGIN

--		DECLARE	@StudBookCount int = 0;
--		SELECT @StudBookCount = COUNT(*)
--		FROM S_Cards
--		WHERE S_Cards.Id_Student = @StudId
		
--		DECLARE @StudName nvarchar(60);
--		SELECT @StudName = Students.FirstName + ' ' + Students.LastName 
--		FROM Students

--		DECLARE @BookName nvarchar(100)
--		SELECT @BookName = Books.[Name] 
--		FROM Books 
--		WHERE Books.Id = @BookId

--		IF (1 <= @StudBookCount) OR (@StudBookCount <= 4)
--		BEGIN
--			IF (@StudBookCount = 3) OR (@StudBookCount = 4)
--				PRINT @StudName + N' has ' + @StudBookCount + N' books.'

--			DECLARE @LastIdS_Card int = 0;
--			SELECT TOP(1) @LastIdS_Card = S_Cards.Id + 1
--			FROM S_Cards
--			ORDER BY S_Cards.Id DESC

--			INSERT INTO S_Cards (Id, Id_Student, Id_Book, DateOut, DateIn, Id_Lib)
--			VALUES (@LastIdS_Card, @StudId, @BookId, GETDATE(), NULL, 1)

--			UPDATE Books
--			SET Books.Quantity -= 1
--			WHERE Books.Id = @BookId
--		END
--		ELSE
--		IF @StudBookCount >= 5
--			PRINT @StudName + N' has ' + @StudBookCount + N' books. You exceeded the limit.'
--	END
--	ELSE
--		PRINT N'No more ' + @BookName + N' book.'
--END

--EXEC StudTakeBook 2, 6


--SELECT Books.Id, Books.[Name]
--FROM Books

--SELECT Students.Id, Students.FirstName
--FROM Students

/*8. ХП “Преподаватель берет книгу”. */

--CREATE PROCEDURE TeachTakeBook
--	@TeachId int,
--	@BookId int
--AS
--BEGIN
--	DECLARE @BookCount int = 0;
--	SELECT @BookCount = Books.Quantity
--	FROM Books
--	WHERE Books.Id = @BookId

--	IF @BookCount > 0
--	BEGIN

--		DECLARE	@TeachBookCount int = 0;
--		SELECT @TeachBookCount = COUNT(*)
--		FROM T_Cards
--		WHERE T_Cards.Id_Teacher = @TeachId
		
--		DECLARE @TeachName nvarchar(60);
--		SELECT @TeachName = Teachers.FirstName + ' ' + Teachers.LastName 
--		FROM Teachers

--		DECLARE @BookName nvarchar(100)
--		SELECT @BookName = Books.[Name] 
--		FROM Books 
--		WHERE Books.Id = @BookId

--		IF (1 <= @TeachBookCount) OR (@TeachBookCount <= 4)
--		BEGIN
--			IF (@TeachBookCount = 3) OR (@TeachBookCount = 4)
--				PRINT @TeachName + N' has ' + @TeachBookCount + N' books.'

--			DECLARE @LastIdT_Card int = 0;
--			SELECT TOP(1) @LastIdT_Card = T_Cards.Id + 1
--			FROM T_Cards
--			ORDER BY T_Cards.Id DESC

--			INSERT INTO T_Cards (Id, Id_Teacher, Id_Book, DateOut, DateIn, Id_Lib)
--			VALUES (@LastIdT_Card, @TeachId, @BookId, GETDATE(), NULL, 1)

--			UPDATE Books
--			SET Books.Quantity -= 1
--			WHERE Books.Id = @BookId
--		END
--		ELSE
--		IF @TeachBookCount >= 5
--			PRINT @TeachName + N' has ' + @TeachBookCount + N' books. You exceeded the limit.'
--	END
--	ELSE
--		PRINT N'No more ' + @BookName + N' book.'
--END


/*9. ХП “Студент возвращает книгу”. ХП получает Id студента и Id книги. В таблицу
S_Cards заносится информация о возвращении книги. Если студент держал у
себя книгу больше года, то ему выписывается штраф. */

--CREATE PROCEDURE StudBooksBack
--	@StudId int, 
--	@BookId int
--AS
--BEGIN
--	UPDATE S_Cards
--	SET S_Cards.DateIn = GETDATE()
--	WHERE S_Cards.Id_Book = @BookId AND S_Cards.Id_Student = @StudId

--	DECLARE @DateInBook int = 0;
--	SELECT @DateInBook = FORMAT(S_Cards.DateIn, N'yyyy')
--	FROM S_Cards
--	WHERE S_Cards.Id_Book = @BookId AND S_Cards.Id_Student = @StudId

--	DECLARE @DateOutBook int = 0;
--	SELECT @DateOutBook = FORMAT(S_Cards.DateOut, N'yyyy')
--	FROM S_Cards
--	WHERE S_Cards.Id_Book = @BookId AND S_Cards.Id_Student = @StudId

--	IF @DateOutBook - @DateInBook > 1
--		PRINT N'You exceeded the limit of book use by' + (@DateOutBook - @DateInBook) + N' years.'

--END

/*10.ХП “Преподаватель возвращает книгу”. */

--CREATE PROCEDURE TeachBooksBack
--	@StudId int, 
--	@BookId int
--AS
--BEGIN
--	UPDATE T_Cards
--	SET T_Cards.DateIn = GETDATE()
--	WHERE T_Cards.Id_Book = @BookId AND T_Cards.Id_Teacher = @StudId

--	DECLARE @DateInBook int = 0;
--	SELECT @DateInBook = FORMAT(T_Cards.DateIn, N'yyyy')
--	FROM T_Cards
--	WHERE T_Cards.Id_Book = @BookId AND T_Cards.Id_Teacher = @StudId

--	DECLARE @DateOutBook int = 0;
--	SELECT @DateOutBook = FORMAT(T_Cards.DateOut, N'yyyy')
--	FROM T_Cards
--	WHERE T_Cards.Id_Book = @BookId AND T_Cards.Id_Teacher = @StudId

--	IF @DateOutBook - @DateInBook > 1
--		PRINT N'You exceeded the limit of book use by' + (@DateOutBook - @DateInBook) + N' years.'

--END

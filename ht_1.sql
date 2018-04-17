-- 1. Показать названия всех книг, а также суммарную стоимость всего тиража каждой из этих книг.

--SELECT [Name], Price * Pressrun AS PressRunSum
--FROM Books

-- 2. Показать категории всех книг, причем так, чтобы названия категорий не повторялись.

--SELECT DISTINCT Category
--FROM Books

-- 3. Показать темы всех книг, причем так, чтобы названия тем не повторялись.\

--SELECT DISTINCT Publisher
--FROM Books

-- 4. Показать код, название книг и цену за 1 страницу.

--SELECT Code, [Name], Pages / Price AS PriceByPage
--FROM Books

-- 1. Показать все книги, выпущенные любым издательством кроме издательства «Питер» и при этом дешевле 20 р.

--SELECT [Name], Publisher, Price
--FROM Books
--WHERE Publisher != N'Питер' AND Price < 20
--ORDER BY Price

-- 2. Показать все книги, выпущенные любым издательством кроме издательства «Питер» и при этом с ценой в диапазоне от 20 до 40 р.

--SELECT [Name], Publisher, Price
--FROM Books
--WHERE Publisher != N'Питер' AND Price BETWEEN 20 AND 40
--ORDER BY Price

-- 3. Показать все книги, выпущенные любым издательством кроме издательства «Питер» и при этом с ценой либо в диапазоне от 20 до 40 р., либо менее 10 р.

--SELECT [Name], Publisher, Price
--FROM Books
--WHERE Publisher != N'Питер' AND ((Price BETWEEN 20 AND 40) OR (Price < 10))
--ORDER BY Price

--4. Показать все книги, цена одной страницы которых меньше 10 копеек.

--SELECT [Name], Price
--FROM Books
--WHERE Pages / Price < 10
--ORDER BY Price

-- 5. Показать все книги, которые являются либо учебниками, либо книгами по теме «C&C++», и при этом изданными либо издательством «Питер», либо издательством «DiaSoft».

--SELECT [Name], Publisher, Category
--FROM Books
--WHERE (Category = N'Учебники' OR [Name] LIKE N'%C++%' OR [Name] LIKE N'%C/C++%') AND (Publisher = N'DiaSoft' OR Publisher = N'Питер')
--ORDER BY [Name]

-- 1. Получить все те книги, в названиях которых присутствует слово «Windows».

--SELECT [Name]
--FROM Books
--WHERE [Name] LIKE N'%Windows%'
--ORDER BY [Name]

-- 2. Получить все те книги, в названиях которых присутствует слово «Windows», но не присутствует слово «Microsoft».

--SELECT [Name]
--FROM Books
--WHERE [Name] LIKE N'%Windows%' AND [Name] NOT LIKE N'%Microsoft%'
--ORDER BY [Name]

-- 3. Получить все те книги, в названиях которых присутствует как минимум одна цифра.

--SELECT [Name]
--FROM Books
--WHERE [Name] LIKE '%[0-9]%'

-- 4. Получить все те книги, в названиях которых присутствует неменее трех цифр.

--SELECT [Name]
--FROM Books
--WHERE [Name] LIKE '%[0-9][0-9][0-9]%'

-- 5. Добавить в таблицу Books информацию о книге Бъярна Страуструпа «Язык программирования С++».

--INSERT INTO Books (New, [Name], Price, Pages, [Format], [Date], Pressrun, Category, Publisher, Topic)
--VALUES (1, 'Бъярн Страуструп «Язык программирования С++»', 351.00, 369, '170x240/16', '2015/01/01', 3000, 'C&C++', 'Бином', 'Программирование')

--SELECT * 
--FROM Books
--WHERE [Name] = 'Бъярн Страуструп «Язык программирования С++»'

-- 6. Уценить все книги на 10 процентов.

--UPDATE Books
--SET Price /= 10 
--WHERE [Name] = 'Бъярн Страуструп «Язык программирования С++»'

-- 7. Удалить все те книги, в коде которых присутствует цифры 6 или 7.

--DELETE FROM Books
--WHERE Code LIKE '%6%' OR Code LIKE '%7%'
/*К БД Library добавить следующие роли:
1. Библиотекарь, старший библиотекарь
2. Учитель
3. Студент
4. Администратор
Представим, что к БД Library будут написаны приложения для библиотекарей,
студентов и учителей. И каждый пользователь логинясь в соответствующее
приложение будет иметь следующие права доступа.

Студент:
1. Может просматривать информацию о книгах, авторах, издательствах, темах.
2. Может просматривать свои задолжности по несданным книгам.
Администратор:
1. Может все.


После создания ролей, необходимо добавить пользователей в роли (хотя бы по
одному в каждую роль).

После создания всех ролей, пользователей, предоставления необходимых
привилегий и проверки на работоспособность необходимо удалить вашего
пользователя из этой БД.

!​ В некоторых случаях стоит создать представления или процедуры и дать права на
них, вместо того чтоб строить сложные или колоночные ограничения на таблицы.
Например:
1. Библиотекарь может изменять только столбец Quantity в таблице Books. Да
можно дать право на 1 столбец в таблице. Но лучше сделать хранимую
процедуру, которая изменяет этот столбец, и дать право запускать эту
процедуру.
2. Пункты 3 и 4 у библиотекаря лучше сделать с помощью представлений. И
библиотекарь будет получать информацию более наглядно и вам меньше
прав выдавать (только на представление).
3. Похожая ситуация у студентов и учителей.
4. Для просмотра задолженностей тоже можно сделать хранимую процедуру.*/

USE [Library_ru]
GO

CREATE ROLE Librarian
CREATE ROLE Senior_Librarian
CREATE ROLE Teacher
CREATE ROLE Student
CREATE ROLE Administrator

-----------------------------------------------------
/*Библиотекарь:
1. Может всячески взаимодействовать с данными в таблицах S_Cards и T_Cards. Но не может изменять или удалять сами таблицы. */

GRANT SELECT, INSERT, UPDATE, DELETE ON S_Cards
TO Librarian

GRANT SELECT, INSERT, UPDATE, DELETE ON T_Cards
TO Librarian

/*2. Может изменять столбец Quantity в таблице Books. Но не может добавлять, изменять или удалять книги из БД. */

GRANT UPDATE ON Books(Quantity)
TO Librarian

CREATE PROCEDURE 

/*3. Может просматривать информацию о книгах, авторах, издательствах, темах. */

GRANT SELECT ON Books 
TO Librarian

GRANT SELECT ON Authors
TO Librarian

GRANT SELECT ON Press
TO Librarian

GRANT SELECT ON Themes
TO Librarian

/*4. Может просматривать имена, фамилии и идентификаторы студентов и учителей.*/

GRANT SELECT ON Students(Id, FirstName, LastName)
TO Librarian

GRANT SELECT ON Teachers(Id, FirstName, LastName)
TO Librarian

--------------------------------------------------------------------------------------------------

/*Старший библиотекарь:
1. Может добавлять, изменять, удалять книги, авторов, издательства, темы.*/

GRANT INSERT, UPDATE, DELETE ON Books
TO Senior_Librarian

GRANT INSERT, UPDATE, DELETE ON Authors
TO Senior_Librarian

GRANT INSERT, UPDATE, DELETE ON Press
TO Senior_Librarian

GRANT INSERT, UPDATE, DELETE ON Themes
TO Senior_Librarian

------------------------------------------------------------------------------------------------

/*Учитель:
1. Может просматривать информацию о книгах, авторах, издательствах, темах.*/

GRANT SELECT ON Books
TO Teacher

GRANT SELECT ON Authors
TO Teacher

GRANT SELECT ON Books
TO Teacher

GRANT SELECT ON Books
TO Teacher

/*2. Может просматривать список студентов, групп, факультетов. */

GRANT SELECT ON Students
TO Teacher

GRANT SELECT ON Groups
TO Teacher

GRANT SELECT ON Faculties
TO Teacher

/*3. Может просматривать свои задолжности по несданным книгам.*/


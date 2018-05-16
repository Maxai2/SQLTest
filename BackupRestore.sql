BACKUP DATABASE Library_ru
TO DISK = 'C:\TempSQL\Lib_ru.bak'
WITH
NAME = 'Full backup',
DESCRIPTION = 'First backup of Library_ru'

RESTORE HEADERONLY
FROM DISK = 'C:\TempSQL\Lib_ru.bak'

DROP DATABASE Library_ru

RESTORE DATABASE Library_ru
FROM DISK = 'C:\TempSQL\Lib_ru.bak'

CREATE TABLE MyTable
(
	Id int PRIMARY KEY IDENTITY(1, 1),
	SomeText nvarchar(50) NOT NULL
)
GO
INSERT INTO MyTable (SomeText)
VALUES (N'qwerqwer'),
	(N'asdfasdf'),
	(N'asgergdfgasdfgf'),
	(N'asdfgdfg')

SELECT *
FROM MyTable

USE [master]
GO
BACKUP DATABASE Library_ru
TO DISK = 'C:\TempSQL\Lib_ru.bak'
WITH
NAME = 'Differential backup',
DESCRIPTION = 'Second backup of Library_ru',
DIFFERENTIAL

RESTORE DATABASE Library_ru
FROM DISK = 'C:\TempSQL\Lib_ru.bak'
WITH
NORECOVERY

RESTORE DATABASE Library_ru
FROM DISK = 'C:\TempSQL\Lib_ru.bak'
WITH
FILE = 2,
RECOVERY

USE Library_ru
GO
SELECT * 
FROM MyTable
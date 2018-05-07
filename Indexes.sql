CREATE DATABASE FSDM_1711

USE FSDM_1711

CREATE TABLE dbo.TableInHeap ( 
	Id INT NOT NULL,
	Filler1 CHAR(36) NOT NULL,
	Filler2 CHAR(216) NOT NULL 
)

CREATE PROCEDURE ShowInfo_TableInHeap
AS
BEGIN
	SELECT OBJECT_NAME([object_id]) AS table_name, [name] AS index_name, [type], [type_desc]
		FROM sys.indexes
		WHERE [object_id] = OBJECT_ID(N'dbo.TableInHeap');

	SELECT index_type_desc, page_count, record_count, avg_page_space_used_in_percent
		FROM sys.dm_db_index_physical_stats (DB_ID(N'FSDM_1711'), OBJECT_ID(N'TableInHeap'), NULL, NULL , 'DETAILED');

	EXEC dbo.sp_spaceused N'TableInHeap'; 
END

DECLARE @i AS int = 1;
WHILE @i < 30
BEGIN
	SET @i = @i + 1;
	INSERT INTO TableInHeap (Id, Filler1, Filler2)
	VALUES (@i, 'a', 'b');
END

INSERT INTO TableInHeap (Id, Filler1, Filler2)
VALUES (31, 'a', 'b'); 

DECLARE @i AS int = 31;
WHILE @i < 3000000
BEGIN
	SET @i = @i + 1;
	INSERT INTO TableInHeap (Id, Filler1, Filler2)
	VALUES (@i, 'a', 'b');
END; 

SELECT *
FROM TableInHeap

EXEC ShowInfo_TableInHeap;
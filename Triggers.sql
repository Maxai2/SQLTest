--CREATE TABLE MyLogs(
--	Id int PRIMARY KEY IDENTITY(1, 1),
--	LoginName nvarchar(50) NOT NULL,
--	PostDate datetime2 NOT NULL,
--	EventType nvarchar(50) NOT NULL,
--	ObjectName nvarchar(50) NULL,
--	ObjectType nvarchar(50) NULL,
--	CommandText nvarchar(max) NULL
--);

DROP TRIGGER DB_Actions ON DATABASE

--ALTER TRIGGER DB_Actions
--ON DATABASE
--AFTER DDL_TABLE_VIEW_EVENTS, DDL_TRIGGER_EVENTS, DDL_PROCEDURE_EVENTS, DDL_FUNCTION_EVENTS
--AS
--BEGIN

--	DECLARE @data AS xml;
--	SET @data = EVENTDATA(); -- информация о событии


--	DECLARE @login AS nvarchar(50);
--	DECLARE @event_type AS nvarchar(50), 
--	@object_name AS nvarchar(50),
--	@object_type AS nvarchar(50),
--	@command_text AS nvarchar(max),
--	@post_time AS datetime2;

--	-- получение данных из xml
--	SET @login = @data.value('(/EVENT_INSTANCE/LoginName)[1]', 'nvarchar(50)');
--	SET @event_type = @data.value('(/EVENT_INSTANCE/EventType)[1]', 'nvarchar(50)');
--	SET @object_name = @data.value('(/EVENT_INSTANCE/ObjectName)[1]', 'nvarchar(50)');
--	SET @object_type = @data.value('(/EVENT_INSTANCE/ObjectType)[1]', 'nvarchar(50)');
--	SET @command_text = @data.value('(/EVENT_INSTANCE/TSQLCommand/CommandText)[1]', 'nvarchar(50)');
--	SET @post_time = @data.value('(/EVENT_INSTANCE/PostTime)[1]', 'nvarchar(50)');
	
--	SET NOCOUNT ON;

--	IF NOT(@event_type = N'DROP_TABLE' AND @object_name = N'MyLogs')
--	BEGIN
--		INSERT INTO MyLogs (LoginName, PostDate, EventType, ObjectName, ObjectType, CommandText)
--		VALUES (@login, @post_time, @event_type, @object_name, @object_type, @command_text);
--	END
--END

--ALTER VIEW Test1
--AS
--SELECT *
--FROM Students

--SELECT *
--FROM MyLogs

CREATE TRIGGER DB_LogOn
ON ALL SERVER
AFTER LOGON
AS
BEGIN	
	SET NOCOUNT ON;
	INSERT INTO [Library_ru].dbo.MyLogs (LoginName, PostDate, EventType)
	VALUES (ORIGINAL_LOGIN(), SYSDATETIME(), N'LOGON');
END

DROP TRIGGER DB_LogOn
ON ALL SERVER

SELECT *
FROM MyLogs

DELETE FROM MyLogs
WHERE 20 <= Mylogs.Id AND Mylogs.Id <= 25
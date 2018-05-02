CREATE PROCEDURE AddStudWithTran
	@Fname nvarchar(max),
	@Lname nvarchar(max),
	@Gname nvarchar(max)
AS
BEGIN
	BEGIN TRAN AddStudTran

	DECLARE @groupid int = 0;

	IF EXISTS (SELECT * FROM Groups WHERE Groups.[Name] = @Gname)
	BEGIN
		SELECT @groupid = Groups.Id
		FROM Groups
		WHERE Groups.[Name] = @Gname
	END
	ELSE
	BEGIN
		SELECT @groupid = MAX(Groups.Id) + 1
		FROM Groups

		INSERT INTO Groups (Id, [Name], Id_Faculty)
		VALUES (@groupid, @Gname, 1)

		IF @@ERROR != 0
		BEGIN
			PRINT 'error in insert into groups';

			ROLLBACK TRAN AddStudTran
			RETURN;
		END
	END

	DECLARE @studid int = 0;
	
	SELECT @studid = MAX(Students.Id) + 1
	FROM Students

	INSERT INTO Students (Id, FirstName, LastName, Id_Group, Term)
	VALUES (@studid, @Fname, @Lname, @groupid, 1)

	IF @@ERROR != 0
	BEGIN
		PRINT 'error in insert into students';

		ROLLBACK TRAN AddStudTran
		RETURN;
	END

	COMMIT TRAN AddStudTran

END

EXEC AddStudWithTran 'Alisa', 'Melnik', 'GR10';

EXEC AddStudWithTran 'Alex', 'Melnik', 'GR1000000000000000';

EXEC AddStudWithTran 'Alexxxxxxxxxxxxxxxxxxxx', 'Melnik', 'GR10';

SELECT * FROM Groups;
SELECT * FROM Students;
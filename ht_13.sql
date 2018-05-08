/*Реализовать хранимые процедуры для выставления оценок комментариям и постам.*/
/*Учтите, что когда комментарию ставится оценка, то необходимо пересчитать рейтинг комментария и рейтинг пользователя, 
написавшего этот комментарий.*/
/*Аналогично с постами. Когда ставится оценка посту, то необходимо пересчитать рейтинг поста и рейтинг пользователя, 
который написал этот пост.*/
/*Так как одна хранимая процедура будет содержать внутри несколько логически связанных между собой действий, 
то их необходимо объединить в одну транзакцию.*/

CREATE PROCEDURE PostMark
	@idPost int,
	@idUser int,
	@mark int
AS
BEGIN
	BEGIN TRAN PostMarkTran

	INSERT PostRating
	SET PostRating.Mark = @mark
	WHERE PostRating.IdPost = @idPost AND PostRating.IdUser = @idUser
	
	IF	@@ERROR != 0
	BEGIN
		PRINT N'Error when set mark for Post Rating!';
		ROLLBACK TRAN PostMarkTran
		RETURN
	END

	DECLARE @UserRating int = 0;
	SELECT @UserRating = AVG(@mark + Users.Rating)
	FROM Users
	WHERE Users.Id = @idUser

	UPDATE Users
	SET Rating = @UserRating
	WHERE Users.Id = @idUser

	IF	@@ERROR != 0
	BEGIN
		PRINT N'Error when set rating for Users!';
		ROLLBACK TRAN PostMarkTran
		RETURN
	END

	DECLARE @PostRating int = 0;
	SELECT @PostRating = AVG(@mark + Posts.Rating)
	FROM Posts
	WHERE Posts.Id = @idPost

	UPDATE Posts
	SET Rating = @PostRating
	WHERE Posts.Id = @idPost

	IF	@@ERROR != 0
	BEGIN
		PRINT N'Error when set rating for Posts!';
		ROLLBACK TRAN PostMarkTran
		RETURN
	END

	COMMIT TRAN PostMarkTran
END

-----------------------------------------------------------------------------------

CREATE PROCEDURE CommentMark
	@idComment int,
	@idUser int,
	@mark int
AS
BEGIN
	BEGIN TRAN CommentMarkTran

	UPDATE CommentRating
	SET CommentRating.Mark = @mark
	WHERE CommentRating.IdComment = @idComment AND CommentRating.IdUser = @idUser
	
	IF	@@ERROR != 0
	BEGIN
		PRINT N'Error when set mark for Post Rating!';
		ROLLBACK TRAN CommentMarkTran
		RETURN
	END

	DECLARE @UserRating int = 0;
	SELECT @UserRating = AVG(@mark + Users.Rating)
	FROM Users
	WHERE Users.Id = @idUser

	UPDATE Users
	SET Rating = @UserRating
	WHERE Users.Id = @idUser

	IF	@@ERROR != 0
	BEGIN
		PRINT N'Error when set rating for Users!';
		ROLLBACK TRAN CommentMarkTran
		RETURN
	END

	DECLARE @PostRating int = 0;
	SELECT @PostRating = AVG(@mark + Posts.Rating)
	FROM Posts
	WHERE Posts.Id = (SELECT Comments.IdPost FROM Comments WHERE Comments.Id = @idComment)

	UPDATE Posts
	SET Rating = @PostRating
	WHERE Posts.Id = (SELECT Comments.IdPost FROM Comments WHERE Comments.Id = @idComment)

	IF	@@ERROR != 0
	BEGIN
		PRINT N'Error when set rating for Posts!';
		ROLLBACK TRAN CommentMarkTran
		RETURN
	END

	DECLARE @CommentRating int = 0;
	SELECT @CommentRating = AVG(@mark + Comments.Rating)
	FROM Comments
	WHERE Comments.Id = @idComment

	UPDATE Comments
	SET Rating = @CommentRating
	WHERE Comments.Id = @idComment

	IF	@@ERROR != 0
	BEGIN
		PRINT N'Error when set rating for Comment!';
		ROLLBACK TRAN CommentMarkTran
		RETURN
	END

	COMMIT TRAN PostMarkTran
END

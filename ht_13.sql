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

	UPDATE PostRating
	SET PostRating.Mark = @mark
	WHERE PostRating.IdPost = @idPost AND PostRating.IdUser = @idUser

	UPDATE Users
	SET Users.Rating = 

	COMMIT TRAN PostMarkTran
END

SELECT *


--CREATE PROCEDURE PostMark
--	@idPost int,
--	@idUser int,
--	@mark int
--AS
--BEGIN
--	UPDATE PostRating
--	SET PostRating.Mark = @mark
--	WHERE PostRating.IdPost = @idPost AND PostRating.IdUser = @idUser
--END

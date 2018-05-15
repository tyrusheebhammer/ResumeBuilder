USE [ResumeBuilder]
GO
/****** Object:  StoredProcedure [dbo].[AddPosition]    Script Date: 5/4/2018 8:35:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[AddPosition]
	@Cid int,
	@Salary varchar(50) null,
	@Name varchar(50),
	@Location varchar(50),
	@StartDate varchar(50) = null,
	@Description varchar(50) = null
	As
	IF @Name is null or @Name = ''

Begin try
Begin transaction
	BEGIN
		PRINT 'ERROR: Position name cannot be null or empty';
		Rollback Transaction
		RETURN (1)
	END
	IF @Location is null or @Location = ''
	BEGIN
		PRINT 'ERROR: Position Location cannot be null or empty';
		Rollback Transaction
		RETURN (2)
	END
	IF @Cid is null or @Cid = 0
	Begin
		PRINT 'ERROR: Company ID cannot be null or empty';
		Rollback Transaction
		RETURN (3)
	End
	IF (Select Count(*) From company where @Cid = CID) = 0
	Begin
		Print 'ERROR: Company does not exist'
		Rollback transaction
		Return (4)
	End
	
	Declare @PosIDT table (
		PosID int)

	Begin 
		INSERT INTO Position(Salary, [Name], [Location], [StartDate], [Description])
	
		Output Inserted.PosID
			Into @PosIDT
		VALUES(@Salary, @Name, @Location, @StartDate, @Description);
	End

	Declare @PosID int
	set @PosID = (select PosID from @PosIDT)

	Insert Into Offers(CID, PosID)
	Values(@Cid, @PosID)
	Commit Transaction
End Try
Begin Catch
	Print 'Unknown Error'
	Return (5)
	Rollback Transaction
End Catch

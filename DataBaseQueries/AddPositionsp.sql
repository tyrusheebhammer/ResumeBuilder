USE [ResumeBuilder]
GO
/****** Object:  StoredProcedure [dbo].[AddPosition]    Script Date: 5/4/2018 8:35:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

if exists (SELECT * FROM sysobjects WHERE name = 'AddPosition')drop procedure [AddPosition]
GO
Create PROCEDURE [dbo].[AddPosition]
	@CompanyName varchar(50),
	@Salary Money null,
	@Name varchar(50),
	@Location varchar(50),
	@StartDate date = null,
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
	IF @CompanyName is null or @CompanyName = ''
	Begin
		PRINT 'ERROR: Company ID cannot be null or empty';
		Rollback Transaction
		RETURN (3)
	End
	IF (Select Count(*) From company where @CompanyName = Name) = 0
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

	Insert Into Offers(Name, PosID)
	Values(@CompanyName, @PosID)
	Commit Transaction
End Try
Begin Catch
	Print 'Unknown Error'
	Return (5)
	Rollback Transaction
End Catch

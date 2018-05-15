Use ResumeBuilder
Go
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

if exists (SELECT * FROM sysobjects WHERE name = 'AddExperiencesp') drop procedure [AddExperiencesp]
Go

CREATE PROCEDURE [dbo].[AddExperiencesp]
(	@StudentID nvarchar(8),
	@Name nvarchar(50),
	@Description nvarchar(max),
	@StartDate date,
	@EndDate date null

	)
AS
--Checking that the values are valid
Begin Try
BEGIN TRANSACTION
	
	
	IF @Name is null or @Name = ''
	BEGIN
		PRINT 'ERROR: Experience Name cannot be null or empty';
		Rollback transaction
		RETURN (1)
	END
	
	IF @Description is null or @Description = ''
	BEGIN
		PRINT 'ERROR: Description cannot be null or empty';
		Rollback transaction
		RETURN (2)
	END
	
	IF @StartDate is null or @StartDate = ''
	BEGIN
		PRINT 'ERROR: Start Date cannot be null or empty';
		Rollback transaction
		RETURN (3)
	END
	
	IF @StudentID is null or @StudentID = ''
	Begin
		Print 'ERROR: StudentID cannot be null'
		Rollback transaction
		Return (4)
	End

	--This may cause some issues in the future
	IF (Select Count(*) From student where @StudentID = StudentID) = 0
	Begin
		Print 'ERROR: Student does not exist'
		Rollback transaction
		Return (5)
	End
	
	Declare @TodaysDate date
	Set @TodaysDate = (Select GETDATE())

	IF(@StartDate > @EndDate and @EndDate is not null)
	Begin 
		Print 'ERROR: Start Date is after end date'
		Rollback transaction
		Return (6)
	End

	Declare @ExpIDT table (
		ExpID int)

	Begin 
		Insert Into Experience(Name,Description,StartDate,EndDate)
		Output Inserted.ExpID
			Into @ExpIDT
		Values(@Name, @Description, @StartDate, @EndDate)
	End

	Declare @ExpID int
	Set @ExpID = (Select ExpID from @ExpIDT)

	Begin 
		Insert Into HasExperience(ExpID, StudentID)
		Values(@ExpID, @StudentID)
	End

	
	Commit Transaction
	return(0)
End Try
Begin Catch
	RollBack Transaction
	Return (8)
End Catch
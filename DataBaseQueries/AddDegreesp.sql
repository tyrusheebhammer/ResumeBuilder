Use resumebuilder
Go
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

if exists (SELECT * FROM sysobjects WHERE name = 'AddDegreesp') drop procedure [AddDegreesp]
Go

Create Procedure dbo.AddDegreesp
(	@StudentID nvarchar(8),
	@Name nvarchar(50),
	@GradYear int,
	@Type nvarchar(50),
	@Field nvarchar(50)
)
As
Begin Try
BEGIN TRANSACTION
	IF @Name is null or @Name = ''
	BEGIN
		PRINT 'ERROR: Experience Name cannot be null or empty';
		Rollback transaction
		RETURN (1)
	END
	
	IF @Type is null or @Type = ''
	BEGIN
		PRINT 'ERROR: Description cannot be null or empty';
		Rollback transaction
		RETURN (2)
	END
	
	IF @Field is null or @Field = ''
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

	IF @Field is null or @Field = ''
	Begin
		Print 'ERROR: Field cannot be null'
		Rollback transaction
		Return (5)
	End

		--This may cause some issues in the future
	IF (Select Count(*) From student where @StudentID = StudentID) = 0
	Begin
		Print 'ERROR: Student does not exist'
		Rollback transaction
		Return (6)
	End

	IF( @GradYear < 1900 or @GradYear > 2024)
	Begin
		Print 'ERROR: Invalid Graduation Year'
		Rollback transaction
		Return (7)
	End


	Declare @DegrIDT table (
		DegrID int)

	Begin 
		Insert Into Degree(Name,GradYear,Type,Field)
		Output Inserted.DegrID
			Into @DegrIDT
		Values(@Name, @GradYear, @Type, @Field)
	End

	Declare @DegrID int
	Set @DegrID = (Select DegrID from @DegrIDT)

	Begin 
		Insert Into HasDegree(DegrID, StudentID)
		Values(@DegrID, @StudentID)
	End

	Begin
		Commit Transaction
	End
End Try
Begin Catch
	Rollback transaction
	Return(8)
End Catch
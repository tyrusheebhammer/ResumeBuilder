Use resumebuilder
Go
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

if exists (SELECT * FROM sysobjects WHERE name = 'AddExperiencesp')drop procedure [AddExperiencesp]
Go

CREATE PROCEDURE [dbo].[AddExperiencesp]
(	@StudentID nvarchar(8) not null,
	@Name nvarchar(50),
	@Description nvarchar(max),
	@StartDate date,
	@EndDate date null
	)
AS
--Checking that the values are valid
BEGIN TRANSACTION
	IF @Name is null or @Name = ''
	BEGIN
		PRINT 'ERROR: Experience Name cannot be null or empty';
		RETURN (1)
	END
	IF @Description is null or @Description = ''
	BEGIN
		PRINT 'ERROR: Description cannot be null or empty';
		RETURN (2)
	END
	IF @StartDate is null or @StartDate = ''
	BEGIN
		PRINT 'ERROR: Start Date cannot be null or empty';
		RETURN (3)
	END
	IF @StudentID is null or @StudentID = ''
	Begin
		Print 'ERROR: StudentID cannot be null'
		Return (4)

	-- I need the resultant OrderID from the table because I'm assuming the table automatically generates the ID incrementally
	Declare @CredIDT table (
		CredID int)

	Begin 
		Insert Into Credential([Type])
		Output Inserted.CredID
			Into @CredIDT
		Values('Experience')
	End

	Declare @CredID int
	Set @CredID = (Select CredID from @CredIDT)

	Begin
		Insert Into Experience([CredID],[Name], [Description], [StartDate], [EndDate])
		Values(@CredID,@Name,@Description,@StartDate,@EndDate)
	End
	
	
	 
	COMMIT TRANSACTION
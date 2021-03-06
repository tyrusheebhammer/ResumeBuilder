USE [ResumeBuilder]
Go
if exists (SELECT * FROM sysobjects WHERE name = 'AddCompany')drop procedure [AddCompany]
Go

--***************************************************************************************************
Go
if exists (SELECT * FROM sysobjects WHERE name = 'AddCourse') drop procedure [AddCourse]
Go

CREATE PROCEDURE [dbo].[AddCourse]
	@CourseID varchar(50),
	@Subject varchar(50)
AS
BEGIN
	If @CourseID is null or @CourseID = ''
	BEGIN
		PRINT 'ERROR: CourseID cannot be null or empty';
		RETURN (1)
	END
	If @Subject is null or @Subject = ''
	BEGIN
		PRINT 'ERROR: Subject cannot be null or empty';
		RETURN (2)
	END
	IF(SELECT COUNT(*) FROM Course 
		Where [CourseID] = @CourseID) = 1
	BEGIN
		PRINT 'ERROR: Course Already Exists';
		RETURN (3)
	END
	INSERT INTO Course(CourseID, [Subject])
	VALUES(@CourseID, @Subject);
END

--***************************************************************************************************
GO

if exists (SELECT * FROM sysobjects WHERE name = 'AddSkill') drop procedure [AddSkill]
Go

Create Procedure AddSkill(
	@SkillID nvarchar(50),
	@Subject nvarchar(50),
	@Description nvarchar(max)
)
As
	If @SkillID is null or @SkillID = ''
	BEGIN
		PRINT 'ERROR: SkillID cannot be null or empty';
		RETURN (1)
	END

	If @Subject is null or @Subject = ''
	BEGIN
		PRINT 'ERROR: subject cannot be null or empty';
		RETURN (2)
	END

	If @Description is null or @Description = ''
	BEGIN
		PRINT 'ERROR: description cannot be null or empty';
		RETURN (3)
	END
	IF(SELECT COUNT(*) FROM Skill 
		Where [SkillID] = @SkillID) = 1
	BEGIN
		PRINT 'ERROR: Skill Already Exists';
		RETURN (4)
	END
	Insert Into Skill(SkillID, Subject, Description)
		Values(@SkillID,@Subject,@Description)
	return (0)

--***************************************************************************************************
GO


if exists (SELECT * FROM sysobjects WHERE name = 'AddDegree') drop procedure [AddDegree]
Go

Create Procedure dbo.AddDegree
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
GO

--***************************************************************************************************
GO

if exists (SELECT * FROM sysobjects WHERE name = 'AddExperience') drop procedure [AddExperience]
Go

CREATE PROCEDURE [dbo].[AddExperience]
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
--***************************************************************************************************
GO

if exists (SELECT * FROM sysobjects WHERE name = 'AddGivesSkill')drop procedure [AddGivesSkill]
Go

CREATE PROCEDURE [AddGivesSkill]
	@SkillID nvarchar(50),
	@CourseID nvarchar(50)
	
AS
BEGIN
	IF @CourseID is null or @CourseID = ''
	BEGIN
		PRINT 'ERROR: Course ID cannot be null or empty';
		RETURN (1)
	END
	IF @SkillID is null or @SkillID = ''
	BEGIN
		PRINT 'ERROR: Skill ID cannot be null or empty';
		RETURN (2)
	END
	IF(SELECT COUNT(*) FROM GivesSkill 
		Where [CourseID] = @CourseID And [SkillID] = @SkillID) = 1
	BEGIN
		PRINT 'ERROR: Course already offers this skill';
		RETURN (3)
	END
	IF(SELECT COUNT(*) FROM Skill 
		Where [SkillID] = @SkillID) = 0
	BEGIN
		PRINT 'Skill Does not exist';
		RETURN (4)
	END

	IF(SELECT COUNT(*) FROM Course 
		Where [CourseID] = @CourseID) = 0
	BEGIN
		PRINT 'ERROR: Course does not exist';
		RETURN (5)
	END
	INSERT INTO GivesSkill(SkillID, CourseID)
	VALUES(@SkillID, @CourseID);
END
--***************************************************************************************************

Go
if exists (SELECT * FROM sysobjects WHERE name = 'AddPosition')drop procedure [AddPosition]
GO
Create PROCEDURE [dbo].[AddPosition]
	@Salary float null,
	@Name varchar(50),
	@Location varchar(50),
	@Description varchar(50) null,
	@Company varchar(50)
	As
--Begin try
Begin Transaction
	IF @Location is null or @Location = ''
	BEGIN
		PRINT 'ERROR: Position Location cannot be null or empty';
		Rollback Transaction
		RETURN (2)
	END

	Declare @PosTable table(
		PosID int
	)
	INSERT INTO Position(Salary, [Name], [Location], [Description], [Company])
	OUTPUT Inserted.PosID into @PosTable
	VALUES(@Salary, @Name, @Location, @Description, @Company);
	
	Select PosID From @PosTable
	Commit Transaction
--End Try
--Begin Catch
--	Print 'Unknown Error'
--	Return (5)
--	Rollback Transaction
--End Catch
--***************************************************************************************************
Go
if exists (SELECT * FROM sysobjects WHERE name = 'AddRequires') drop procedure [AddRequires]
Go

CREATE PROCEDURE AddRequires
	@SkillID int,
	@PosID int
AS
	IF @PosID is null or @PosID = ''
	BEGIN
		PRINT 'ERROR: PosID cannot be null or empty';
		RETURN (1)
	END
	IF @SkillID is null or @SkillID = ''
	BEGIN
		PRINT 'ERROR: SkillID cannot be null or empty';
		RETURN (2)
	END
	IF(SELECT COUNT(*) FROM Requires 
		Where [SkillID] = @SkillID AND [PosID] = @PosID) = 1
	BEGIN
		PRINT 'Position already requires this skill';
		RETURN (3)
	END
	IF(SELECT Count(*) FROM Position
		Where PosID = @PosID) = 0
	Begin
		Print 'Position does not exist'
		Return (4)
	End
	IF(SELECT Count(*) FROM Skill
		Where SkillID = @SkillID) = 0
	Begin
		Print 'SKILLID does not exist'
		Return (5)
	End
	Insert into Requires(SkillID,PosID)
	Values(@SkillID, @PosID)
--***************************************************************************************************
GO

if exists (SELECT * FROM sysobjects WHERE name = 'AddStudent') drop procedure [AddStudent]
Go

Create PROCEDURE [dbo].[AddStudent]
	@sid nvarchar(8),
	@FirstName nvarchar(50),
	@MInit nvarchar(5) = null,
	@LastName nvarchar(50), 
	@addr nvarchar(100) = null,
	@phone numeric = null,
	@pass nvarchar(50)
AS
BEGIN

	IF @FirstName is null or @FirstName = ''
	BEGIN
		PRINT 'ERROR: Experience Name cannot be null or empty';
		RETURN (1)
	END
	
	IF @sid is null or @sid = ''
	BEGIN
		PRINT 'ERROR: StudentID cannot be null or empty';
		RETURN (2)
	END
	
	IF @LastName is null or @LastName = ''
	BEGIN
		PRINT 'ERROR: Last name cannot be null or empty';
		RETURN (3)
	END
	
	IF @pass is null or @pass = ''
	Begin
		Print 'ERROR: password cannot be null'
		Return (4)
	End


		--This may cause some issues in the future
	IF (Select Count(*) From student where @sid = StudentID) = 1
	Begin
		Print 'ERROR: Student alrready exists'
		Return (5)
	End



	INSERT INTO Student(StudentID,FirstName,MInit,LastName,[Address],Phone,[Password])
	VALUES(@sid, @FirstName, @MInit, @LastName, @addr, @phone, @pass);
END

--***************************************************************************************************
Go
if exists (SELECT * FROM sysobjects WHERE name = 'FilterPositions') drop procedure [FilterPositions]
Go
CREATE PROCEDURE [dbo].[FilterPositions] 
	@sID nvarchar(8),
	@salary money null,
	@location nvarchar(255) null,
	@company nvarchar(255) null,
	@qualified bit null
AS 
PRINT 'in the right sp'
--Declaring tables to be joined later 
Declare @SalaryTable table(PositionID int, PositionName nvarchar(255), PositionDescription nvarchar(255))
Declare @LocationTable table(PositionID int, PositionName nvarchar(255), PositionDescription nvarchar(255))
Declare @CompanyTable table(PositionID int, PositionName nvarchar(255), PositionDescription nvarchar(255))
Declare @QualifiedTable table(PositionID int, PositionName nvarchar(255), PositionDescription nvarchar(255))
DECLARE @ReturnTable table(PositionID int, PositionName nvarchar(255), PositionDescription nvarchar(255))
Declare @TempTable table(PositionID int, PositionName nvarchar(255), PositionDescription nvarchar(255))
PRINT '1'
Insert Into @ReturnTable 
	Select PosID, Name, Description
	From Position
PRINT '2'
-- Base case all positions with no filters 
Declare @TodaysDate date
set @TodaysDate = GETDATE()

	

--Builds a table of all positions qualified for
IF (@qualified = 1)
	BEGIN 
		PRINT 'qualified is true'
		INSERT INTO @QualifiedTable
			SELECT Position.PosID, Position.Name, Position.Description
			FROM	HasTaken	
				JOIN GivesSkill 
				on HasTaken.CourseID = GivesSkill.CourseID
				JOIN Requires
				on GivesSkill.SkillID = Requires.SkillID 
				JOIN Position
				on Requires.PosID = Position.PosID
			Where HasTaken.StudentID = @sID

		Insert Into @TempTable
			Select* From @ReturnTable	
			INTERSECT 
			Select* From @QualifiedTable;
			
		DELETE FROM @ReturnTable
		INSERT INTO @ReturnTable
			Select* From @TempTable
		
		DELETE FROM @TempTable
	END
PRINT '3'
--Filtering Salary 
IF @salary  is not null 
	BEGIN 
		PRINT 'salary  case'
		INSERT Into @SalaryTable
			SELECT Position.PosID, Position.Name, Position.Description
				FROM Position
				WHERE Position.Salary >= @salary

		Insert Into @TempTable
			Select* From @ReturnTable	
			INTERSECT 
			Select* From @SalaryTable;
			
		DELETE FROM @ReturnTable
		INSERT INTO @ReturnTable
			Select* From @TempTable
		
		DELETE FROM @TempTable
		
	END 
PRINT '4'
--Filtering location 
IF (@location is not null) 

	BEGIN 
	PRINT 'location  case'
		INSERT Into @LocationTable
			SELECT Position.PosID, Position.Name, Position.Description
				FROM Position
				WHERE Position.location = @location

	Insert Into @TempTable
			Select* From @ReturnTable	
			INTERSECT 
			Select* From @LocationTable;
			
		DELETE FROM @ReturnTable
		INSERT INTO @ReturnTable
			Select* From @TempTable
		
		DELETE FROM @TempTable

	END 
PRINT '6'
--Filtering company 
	IF (@company is not null) 

	BEGIN 
		PRINT 'company  case'
		INSERT Into @CompanyTable
			SELECT Position.PosID, Position.Name, Position.Description
				From Position
				Where [Company] = @company

		Insert Into @TempTable
			Select* From @ReturnTable	
			INTERSECT 
			Select* From @CompanyTable;
			
		DELETE FROM @ReturnTable
		INSERT INTO @ReturnTable
			Select* From @TempTable
		
		DELETE FROM @TempTable
	END
PRINT '7'

	SELECT Position.Name 'Position Name', [Description], Salary, 
		 [Location], [Company]
		FROM Position, @ReturnTable
		Where Position.PosID = PositionID
Return(0)

--***************************************************************************************************
GO

if exists (SELECT * FROM sysobjects WHERE name = 'GetDegreeByStudent') drop procedure [GetDegreeByStudent]
Go

Create Proc [dbo].[GetDegreeByStudent]
	@sID nvarchar(8)
As	
BEGIN 
SELECT	Degree.Name, Degree.GradYear, Degree.Field
FROM	Student Join HasDegree
		on Student.StudentID = HasDegree.StudentID
		JOIN Degree
		on HasDegree.DegrID = Degree.DegrID
WHERE	Student.StudentID = @sID
END 

--***************************************************************************************************
GO

if exists (SELECT * FROM sysobjects WHERE name = 'GetExperiencesByStudent') drop procedure [GetExperiencesByStudent]
Go

CREATE Proc [dbo].[GetExperiencesByStudent]
	@sID nvarchar(8)
As	
BEGIN 
SELECT	Experience.Description
FROM	Student Join HasExperience
		on Student.StudentID = HasExperience.StudentID
		JOIN Experience
		on HasExperience.ExpID = Experience.ExpID
WHERE	Student.StudentID = @sID
END 
--***************************************************************************************************
GO
if exists (SELECT * FROM sysobjects WHERE name = 'GetPositionByStudentSkills') drop procedure [GetPositionByStudentSkills]
Go

CREATE PROC [dbo].[GetPositionByStudentSkills]
	@sID nvarchar(8) 
	AS
	PRINT @sID

Begin 
SELECT Position.PosID, Position.Name, Position.Description
FROM	HasTaken	
		 JOIN GivesSkill 
		 on HasTaken.CourseID = GivesSkill.CourseID
		 JOIN Requires
		 on GivesSkill.SkillID = Requires.SkillID 
		 JOIN Position
		 on Requires.PosID = Position.PosID
Where HasTaken.StudentID = @sID
end 
--***************************************************************************************************
Go
if exists (SELECT * FROM sysobjects WHERE name = 'GetSkillsByStudent') drop procedure [GetSkillsByStudent]
Go

Create Procedure [dbo].[GetSkillsByStudent]
	@sID nvarchar(8)
As	
BEGIN 
SELECT	skill.Description
FROM	Student Join HasTaken 
		on Student.StudentID = HasTaken.StudentID
		JOIN GivesSkill 
		on HasTaken.CourseID = GivesSkill.CourseID
		JOIN Skill
		on GivesSkill.SkillID = skill.SkillID
WHERE	Student.StudentID = @sID
END 
--***************************************************************************************************
Go
if exists (SELECT * FROM sysobjects WHERE name = 'GetStudentByID') drop procedure [GetStudentByID]
Go

CREATE Proc [dbo].[GetStudentByID]
	@sID nvarchar(8)
As	
BEGIN 
SELECT	Student.FirstName, Student.MInit, Student.LastName, Student.Address, Student.Phone
FROM	Student 
WHERE	Student.StudentID = @sID
END 


--***************************************************************************************************
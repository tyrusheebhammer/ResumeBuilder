USE [ResumeBuilder]
GO
/****** Object:  StoredProcedure [dbo].[FilterPositions]    Script Date: 5/11/2018 11:34:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
if exists (SELECT * FROM sysobjects WHERE name = 'FilterPositions') drop procedure [FilterPositions]
Go
CREATE PROCEDURE [dbo].[FilterPositions] 
	@sID nvarchar(8),
	@salary money null,
	@startDate date null,
	@location nvarchar(255) null,
	@company nvarchar(255) null,
	@qualified bit null
AS 
PRINT 'in the right sp'
--Declaring tables to be joined later 
Declare @SalaryTable table(PositionID int, PositionName nvarchar(255), PositionDescription nvarchar(255))
Declare @StartDateTable table(PositionID int, PositionName nvarchar(255), PositionDescription nvarchar(255))
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
--Filtering SatatrtDate
	IF (@startDate is not null)	
	BEGIN
	if(@TodaysDate < @startDate)
		Print 'Invalid StartDate'
		Return (1)

	
		PRINT 'start date  case'
		INSERT Into @startDateTable
			SELECT Position.PosID, Position.Name, Position.Description
				FROM Position
				WHERE Position.startDate = @startDate

		Insert Into @TempTable
			Select* From @ReturnTable	
			INTERSECT 
			Select* From @startDateTable;
			
		DELETE FROM @ReturnTable
		INSERT INTO @ReturnTable
			Select* From @TempTable
		
		DELETE FROM @TempTable
	END 
PRINT '5'
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
--Filtering comapany 
	IF (@company is not null) 

	BEGIN 
		PRINT 'company  case'
		INSERT Into @CompanyTable
			SELECT Position.PosID, Position.Name, Position.Description
				FROM Offers JOIN Position
				on Offers.PosID = Position.PosID 
				JOIN Company
				on Offers.CID = Company.CID
				WHERE @company = Company.Name

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

	SELECT Position.Name 'Position Name', Position.Description, Position.Salary, Position.StartDate 'Start Date', 
		   Position.Location, Company.Name 'Company Name'
		FROM Position, @ReturnTable, Offers, Company
		Where Position.PosID = PositionID AND Position.PosID = Offers.PosID AND Company.CID = Offers.CID
Return(0)

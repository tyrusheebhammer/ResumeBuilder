USE [ResumeBuilder]
GO
/****** Object:  StoredProcedure [dbo].[AddCompany]    Script Date: 5/2/2018 8:58:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
	INSERT INTO GivesSkill(SkillID, CourseID)
	VALUES(@SkillID, @CourseID);
END
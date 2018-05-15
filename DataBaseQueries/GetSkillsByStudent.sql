USE [ResumeBuilder]
GO
/****** Object:  StoredProcedure [dbo].[GetSkillsByStudent]    Script Date: 5/12/2018 3:57:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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
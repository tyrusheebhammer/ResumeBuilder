USE [ResumeBuilder]
GO
/****** Object:  StoredProcedure [dbo].[GetPositionByStudentSkills]    Script Date: 5/12/2018 3:59:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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

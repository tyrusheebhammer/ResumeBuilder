USE [ResumeBuilder]
GO
/****** Object:  StoredProcedure [dbo].[GetExperiencesByStudent]    Script Date: 5/12/2018 4:00:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
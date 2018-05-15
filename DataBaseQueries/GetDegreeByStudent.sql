USE [ResumeBuilder]
GO
/****** Object:  StoredProcedure [dbo].[GetDegreeByStudent]    Script Date: 5/12/2018 4:01:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
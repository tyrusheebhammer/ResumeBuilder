USE [ResumeBuilder]
GO
/****** Object:  StoredProcedure [dbo].[GetStudentByID]    Script Date: 5/12/2018 4:02:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


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
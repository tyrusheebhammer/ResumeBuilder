USE [ResumeBuilder]
GO

/****** Object:  StoredProcedure [dbo].[AddRestaurant]    Script Date: 4/26/2018 10:35:58 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

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
GO
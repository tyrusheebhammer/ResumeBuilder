USE [ResumeBuilder]
GO

/****** Object:  StoredProcedure [dbo].[AddRestaurant]    Script Date: 4/26/2018 10:35:58 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AddCourse]
	@CourseID varchar(50),
	@Skill varchar(50)
AS
BEGIN
	INSERT INTO Course(CourseID, [Skill])
	VALUES(@CourseID, @Skill);
END
GO
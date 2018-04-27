USE [ResumeBuilder]
GO

/****** Object:  StoredProcedure [dbo].[AddRestaurant]    Script Date: 4/26/2018 10:35:58 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AddStudent]
	@sid nvarchar(8),
	@FirstName nvarchar(50),
	@MInit nvarchar(5) = null,
	@LastName nvarchar(50), 
	@addr nvarchar(100) = null,
	@phone int = null,
	@pass nvarchar(50)
AS
BEGIN
	INSERT INTO Student(StudentID,FirstName,MInit,LastName,[Address],Phone,[Password])
	VALUES(@sid, @FirstName, @MInit, @LastName, @addr, @phone, @pass);
END
GO
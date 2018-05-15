USE [ResumeBuilder]
GO
/****** Object:  StoredProcedure [dbo].[AddStudent]    Script Date: 5/4/2018 8:03:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

if exists (SELECT * FROM sysobjects WHERE name = 'AddStudent') drop procedure [AddStudent]
Go

Create PROCEDURE [dbo].[AddStudent]
	@sid nvarchar(8),
	@FirstName nvarchar(50),
	@MInit nvarchar(5) = null,
	@LastName nvarchar(50), 
	@addr nvarchar(100) = null,
	@phone int = null,
	@pass nvarchar(50)
AS
BEGIN

	IF @FirstName is null or @FirstName = ''
	BEGIN
		PRINT 'ERROR: Experience Name cannot be null or empty';
		Rollback transaction
		RETURN (1)
	END
	
	IF @sid is null or @sid = ''
	BEGIN
		PRINT 'ERROR: StudentID cannot be null or empty';
		Rollback transaction
		RETURN (2)
	END
	
	IF @LastName is null or @LastName = ''
	BEGIN
		PRINT 'ERROR: Last name cannot be null or empty';
		Rollback transaction
		RETURN (3)
	END
	
	IF @pass is null or @pass = ''
	Begin
		Print 'ERROR: password cannot be null'
		Rollback transaction
		Return (4)
	End


		--This may cause some issues in the future
	IF (Select Count(*) From student where @sid = StudentID) = 1
	Begin
		Print 'ERROR: Student alrready exists'
		Rollback transaction
		Return (5)
	End



	INSERT INTO Student(StudentID,FirstName,MInit,LastName,[Address],Phone,[Password])
	VALUES(@sid, @FirstName, @MInit, @LastName, @addr, @phone, @pass);
END

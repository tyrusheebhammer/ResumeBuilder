USE [ResumeBuilder]
GO
/****** Object:  StoredProcedure [dbo].[AddCompany]    Script Date: 5/2/2018 8:58:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

if exists (SELECT * FROM sysobjects WHERE name = 'AddCompany')drop procedure [AddCompany]
Go

CREATE PROCEDURE [AddCompany]
	@Name varchar(50)
AS
BEGIN
	IF @Name is null or @Name = ''
	BEGIN
		PRINT 'ERROR: Name cannot be null or empty';
		RETURN (2)
	END
	IF(SELECT COUNT(*) FROM Company 
		Where [Name] = @Name) = 1
	BEGIN
		PRINT 'ERROR: Company Already Exists';
		RETURN (3)
	END
	INSERT INTO Company([Name])
	VALUES(@Name);
END
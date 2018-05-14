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
	@CID varchar(50),
	@Name varchar(50)
AS
BEGIN
	IF @CID is null or @CID = ''
	BEGIN
		PRINT 'ERROR: Company ID cannot be null or empty';
		RETURN (1)
	END
	IF @Name is null or @Name = ''
	BEGIN
		PRINT 'ERROR: Company ID cannot be null or empty';
		RETURN (2)
	END
	IF(SELECT COUNT(*) FROM Company 
		Where [Name] = @Name) = 1
	BEGIN
		PRINT 'ERROR: Company Already Exists';
		RETURN (3)
	END
	INSERT INTO Company(CID, [Name])
	VALUES(@CID, @Name);
END
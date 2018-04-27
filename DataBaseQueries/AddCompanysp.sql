USE [ResumeBuilder]
GO

/****** Object:  StoredProcedure [dbo].[AddRestaurant]    Script Date: 4/26/2018 10:35:58 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AddCompany]
	@CID varchar(50),
	@Name varchar(50)
AS
BEGIN
	INSERT INTO Company(CID, [Name])
	VALUES(@CID, @Name);
END
GO
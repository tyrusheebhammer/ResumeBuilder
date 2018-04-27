USE [ResumeBuilder]
GO

/****** Object:  StoredProcedure [dbo].[AddRestaurant]    Script Date: 4/26/2018 10:35:58 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AddPosition]
	@PosID varchar(50),
	@Salary varchar(50) = null,
	@Name varchar(50) = null,
	@Location varchar(50) = null,
	@StartDate varchar(50) = null,
	@Description varchar(50) = null
AS
BEGIN
	INSERT INTO Position(PosId, Salary, [Name], [Location], [StartDate], [Description])
	VALUES(@PosID, @Salary, @Name, @Location, @StartDate, @Description);
END
GO
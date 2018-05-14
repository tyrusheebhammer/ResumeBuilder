USE [ResumeBuilder]
GO

/****** Object:  Table [dbo].[Course]    Script Date: 4/27/2018 12:14:03 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

if exists (SELECT * FROM sysobjects WHERE name = 'Course')drop Table [Course]
Go
CREATE TABLE [dbo].[Course](
	[CourseID] [varchar](50),
	[Subject] [varchar](50) NOT NULL
	PRIMARY KEY (CourseID)
)
GO



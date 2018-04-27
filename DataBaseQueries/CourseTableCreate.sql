USE [ResumeBuilder]
GO
DROP TABLE Course
/****** Object:  Table [dbo].[Course]    Script Date: 4/27/2018 12:14:03 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Course](
	[CourseID] [varchar](50),
	[Skill] [varchar](50)
	PRIMARY KEY (CourseID)
)
GO



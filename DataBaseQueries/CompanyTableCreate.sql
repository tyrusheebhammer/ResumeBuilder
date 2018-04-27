USE [ResumeBuilder]
GO
Drop Table Company
/****** Object:  Table [dbo].[Company]    Script Date: 4/27/2018 12:10:49 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Company](
	[CID] [varchar](50),
	[Name] [varchar](50) NOT NULL
	PRIMARY KEY(CID)
)
GO



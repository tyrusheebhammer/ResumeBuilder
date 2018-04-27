USE [ResumeBuilder]
GO

/****** Object:  Table [dbo].[HasTaken]    Script Date: 4/26/2018 9:39:44 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[HasTaken](
	[CourseID] [nvarchar](10) NULL,
	[StudentID] [nvarchar](8) NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[HasTaken]  WITH CHECK ADD  CONSTRAINT [FK__HasTaken__Studen__2E1BDC42] FOREIGN KEY([StudentID])
REFERENCES [dbo].[Student] ([StudentID])
GO

ALTER TABLE [dbo].[HasTaken] CHECK CONSTRAINT [FK__HasTaken__Studen__2E1BDC42]
GO



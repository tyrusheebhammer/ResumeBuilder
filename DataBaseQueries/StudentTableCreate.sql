USE [ResumeBuilder]
GO

/****** Object:  Table [dbo].[Student]    Script Date: 4/26/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Student](
	[StudentID] [nvarchar](8) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[MInit] [nvarchar](5) NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[Address] [nvarchar](100) NULL,
	[Phone] [int] NULL,
	[Password] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK__Student__32C52A79441B2866] PRIMARY KEY CLUSTERED 
(
	[StudentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO



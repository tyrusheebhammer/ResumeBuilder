Use ResumeBuilder
Go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS begin dbo.opAppliesFor end
CREATE TABLE [dbo].[AppliesFor](
	[StudentID] [nvarchar](8) NULL,
	[PosID] [nvarchar](50) NULL
) ON [PRIMARY]
GO


DROP TABLE IF EXISTS dbo.Company
Create Table Company(
	CID int,
	Name nvarchar(100) not null,
	Prestige int,
	Num_Employees int,
	Primary Key(CID)
)
Go


DROP TABLE IF EXISTS dbo.Course
CREATE TABLE [dbo].[Course](
	[Course] [varchar](50) NULL,
	[Skill] [varchar](50) NULL
) ON [PRIMARY]
GO


DROP TABLE IF EXISTS dbo.[Credential]
Create Table Credential(
	CredID int
	Primary Key (CredID)
	)
Go


DROP TABLE IF EXISTS dbo.Degree
Create Table Degree(
	CredID int,
	Name nvarchar(50) not null,
	Description nvarchar(max) not null,
	Field nvarchar(50) not null
	FOREIGN KEY (CredID) REFERENCES Credential(CredID)
)
Go


DROP TABLE IF EXISTS dbo.Experience
Create Table Experience(
	CredID int,
	Name nvarchar(50) not null,
	Description nvarchar(max) not null,
	StartDate date not null,
	EndDate date,
	FOREIGN KEY (CredID) REFERENCES Credential(CredID)

) 
Go


DROP TABLE IF EXISTS dbo.HasTaken
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



DROP TABLE IF EXISTS dbo.Offers
CREATE TABLE [dbo].[Offers](
	[CID] [nvarchar](50) NULL,
	[PosID] [nvarchar](50) NULL
) ON [PRIMARY]
GO


DROP TABLE IF EXISTS dbo.Position
Create Table Position(
	PosID int,
	Salary money,
	Name nvarchar(50) not null,
	Location nvarchar(100),
	StartDate date not null, 
	Description nvarchar(max) not null
	PRIMARY KEY (PosID)
)
Go

DROP TABLE IF EXISTS dbo.Requires
CREATE TABLE [dbo].[Requires](
	[CredID] [nvarchar](50) NULL,
	[PosID] [nvarchar](50) NULL
) ON [PRIMARY]
GO


DROP TABLE IF EXISTS dbo.Skill
Create Table Skill(
	CredID int,
	Name nvarchar(50) not null,
	Description nvarchar(max) not null,
	FOREIGN KEY (CredID) REFERENCES Credential(CredID)
) 
Go


DROP TABLE IF EXISTS dbo.Student
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

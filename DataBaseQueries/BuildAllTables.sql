USE [ResumeBuilder]
GO

/****** Object:  Table [dbo].[Student]    Script Date: 4/26/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO

if exists (SELECT * FROM sysobjects WHERE name = 'Requires') drop table [Requires]

if exists (SELECT * FROM sysobjects WHERE name = 'Degree') drop table [Degree]

if exists (SELECT * FROM sysobjects WHERE name = 'GivesSkill')drop Table [GivesSkill]

if exists (SELECT * FROM sysobjects WHERE name = 'hasTaken') drop Table [HasTaken]

if exists (SELECT * FROM sysobjects WHERE name = 'AppliesFor')drop table [AppliesFor]

if exists (SELECT * FROM sysobjects WHERE name = 'HasCredential') drop table [HasCredential]

if exists (SELECT * FROM sysobjects WHERE name = 'Experience')drop table [Experience]

if exists (SELECT * FROM sysobjects WHERE name = 'Offers') drop table [Offers]

if exists (SELECT * FROM sysobjects WHERE name = 'Student') drop table [Student]

if exists (SELECT * FROM sysobjects WHERE name = 'Position') drop table [Position]

if exists (SELECT * FROM sysobjects WHERE name = 'Course') drop Table [Course]

if exists (SELECT * FROM sysobjects WHERE name = 'Skill')drop Table [Skill]

if exists (SELECT * FROM sysobjects WHERE name = 'Credential') drop table [Credential]

if exists (SELECT * FROM sysobjects WHERE name = 'Company') drop table [Company]


Go

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
	Primary Key(StudentID))

Go

Create Table [Credential](
	CredID int IDENTITY(1,1) Primary Key,
	[Type] nvarchar(50) not null
	)

Go

CREATE TABLE [dbo].[Company](
	[CID] [nvarchar](50),
	[Name] [nvarchar](50) NOT NULL
	PRIMARY KEY(CID)
)
GO

Create Table Skill(
	SkillID int NOT NULL,
	Subject nvarchar(50) not null,
	Name nvarchar(50) not null,
	Description nvarchar(max) not null,
	PRIMARY KEY(SkillID)
)

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

CREATE TABLE [dbo].[Course](
	CourseID nvarchar(10),
	[Subject] nvarchar(50) NOT NULL
	PRIMARY KEY (CourseID)
)
GO

CREATE TABLE [dbo].[AppliesFor](
	[StudentID] [nvarchar](8),
	[PosID] int, 
	Foreign Key(StudentID) references Student(studentID),
	Foreign Key(PosID) references Position(PosID)
) 

Go

CREATE TABLE [dbo].[HasTaken](
	[CourseID] [nvarchar](10),
	[StudentID] [nvarchar](8),
	Foreign Key(CourseID) References Course(CourseID),
	Foreign Key(StudentID) References Student(StudentID)
)  
GO

Create Table Experience(
	CredID int,
	Name nvarchar(50) not null,
	Description nvarchar(max) not null,
	StartDate date not null,
	EndDate date,
	FOREIGN KEY (CredID) REFERENCES Credential(CredID))

Go

Create Table Degree(
	CredID int,
	Name nvarchar(50) not null,
	Description nvarchar(max) not null,
	Field nvarchar(50) not null
	FOREIGN KEY (CredID) REFERENCES Credential(CredID)
) 
Go

Create Table HasCredential(
	CredID int,
	StudentID nvarchar(8),
	Foreign Key(CredID) references [Credential](CredID),
	Foreign Key(StudentID) references student(StudentID))

Go

Create Table GivesSkill(
	SkillID int,
	CourseID nvarchar(10),
	Foreign Key(SkillID) References Skill(SkillID),
	Foreign Key(CourseID) References Course(CourseID)
)
Go

CREATE TABLE [dbo].[Offers](
	[CID] [nvarchar](50),
	[PosID] int 
	Foreign Key(CID) references Company(CID),
	Foreign Key(PosID) references Position(PosID)
)
Go

CREATE TABLE [dbo].[Requires](
	[SkillID] int,
	[PosID] int,
	Foreign Key(SkillID) References Skill(SkillID),
	Foreign Key(PosID) References Position(PosID)
) ON [PRIMARY]
GO
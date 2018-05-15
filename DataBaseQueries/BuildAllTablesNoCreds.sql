USE [ResumeBuilder]
GO

/****** Object:  Table [dbo].[Student]    Script Date: 4/26/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO

if exists (SELECT * FROM sysobjects WHERE name = 'HasExperience') drop table [HasExperience]

if exists (SELECT * FROM sysobjects WHERE name = 'HasDegree') drop table [HasDegree]

if exists (SELECT * FROM sysobjects WHERE name = 'Requires') drop table [Requires]

if exists (SELECT * FROM sysobjects WHERE name = 'Degree') drop table [Degree]

if exists (SELECT * FROM sysobjects WHERE name = 'GivesSkill')drop Table [GivesSkill]

if exists (SELECT * FROM sysobjects WHERE name = 'hasTaken') drop Table [HasTaken]

if exists (SELECT * FROM sysobjects WHERE name = 'Experience')drop table [Experience]

if exists (SELECT * FROM sysobjects WHERE name = 'Student') drop table [Student]

if exists (SELECT * FROM sysobjects WHERE name = 'Position') drop table [Position]

if exists (SELECT * FROM sysobjects WHERE name = 'Course') drop Table [Course]

if exists (SELECT * FROM sysobjects WHERE name = 'Skill')drop Table [Skill]

Go

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Student](
	[StudentID] [nvarchar](8) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[MInit] [nvarchar](5) NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[Address] [nvarchar](100) NULL,
	[Phone] [numeric] NULL,
	[Password] [nvarchar](50) NOT NULL,
	Primary Key(StudentID))

Go


--CREATE TABLE [dbo].[Company](
--	[Name] [nvarchar](50) Primary Key
--)
--GO

Create Table Skill(
	SkillID nvarchar(50) primary key,
	Subject nvarchar(50) not null,
	Description nvarchar(max) not null
)

Create Table Position(
	PosID int Identity(1,1) primary key,
	Salary float,
	Name nvarchar(50) not null,
	Location nvarchar(100),
	Description nvarchar(max) not null,
	Company nvarchar(50)
)

Go

CREATE TABLE [dbo].[Course](
	CourseID nvarchar(10),
	[Subject] nvarchar(50) NOT NULL
	PRIMARY KEY (CourseID)
)

Go

CREATE TABLE [dbo].[HasTaken](
	[CourseID] [nvarchar](10),
	[StudentID] [nvarchar](8),
	Foreign Key(CourseID) References Course(CourseID) ON DELETE CASCADE ON UPDATE CASCADE ,
	Foreign Key(StudentID) References Student(StudentID) ON DELETE CASCADE ON UPDATE CASCADE 
)  
GO

Create Table Experience(
	ExpID int IDENTITY(1,1) Primary Key,
	Name nvarchar(50) not null,
	Description nvarchar(max) not null,
	StartDate date not null,
	EndDate date
	)
Go

Create Table Degree(
	DegrID int IDENTITY(1,1) Primary Key,
	Name nvarchar(50) not null,
	GradYear int,
	Type nvarchar(50) not null,
	Field nvarchar(50) not null
) 
Go

Create Table HasExperience(
	ExpID int,
	StudentID nvarchar(8),
	Foreign Key(ExpID) references [Experience](ExpID) ON DELETE CASCADE ON UPDATE CASCADE ,
	Foreign Key(StudentID) references student(StudentID) ON DELETE CASCADE ON UPDATE CASCADE 
	) 

Go

Create Table HasDegree(
	DegrID int,
	StudentID nvarchar(8),
	Foreign Key(DegrID) references [Degree](DegrID) ON DELETE CASCADE ON UPDATE CASCADE ,
	Foreign Key(StudentID) references student(StudentID) ON DELETE CASCADE ON UPDATE CASCADE 
	) 

Go


Create Table GivesSkill(
	SkillID nvarchar(50),
	CourseID nvarchar(10),
	Foreign Key(SkillID) References Skill(SkillID) ON DELETE CASCADE ON UPDATE CASCADE ,
	Foreign Key(CourseID) References Course(CourseID) ON DELETE CASCADE ON UPDATE CASCADE 
)
Go


CREATE TABLE [dbo].[Requires](
	[SkillID] nvarchar(50),
	[PosID] int,
	Foreign Key(SkillID) References Skill(SkillID) ON DELETE CASCADE ON UPDATE CASCADE ,
	Foreign Key(PosID) References Position(PosID) ON DELETE CASCADE ON UPDATE CASCADE 
) ON [PRIMARY]
GO

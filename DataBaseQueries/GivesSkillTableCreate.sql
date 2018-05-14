Use ResumeBuilder
Go
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

if exists (SELECT * FROM sysobjects WHERE name = 'GivesSkill')drop Table [GivesSkill]
Go
Create Table GivesSkill(
	SkillID int NOT NULL,
	CourseID nvarchar(50) not null,
	Foreign Key(SkillID) References Skill(SkillID),
	Foreign Key(CourseID) References Course(CourseID)
) ;
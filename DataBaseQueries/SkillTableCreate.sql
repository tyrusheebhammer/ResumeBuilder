Use ResumeBuilder
Go
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

if exists (SELECT * FROM sysobjects WHERE name = 'Skill')drop Table [Skill]
Go
Create Table Skill(
	SkillID int NOT NULL,
	Subject nvarchar(50) not null,
	Name nvarchar(50) not null,
	Description nvarchar(max) not null,
	PRIMARY KEY(SkillID)
) ;
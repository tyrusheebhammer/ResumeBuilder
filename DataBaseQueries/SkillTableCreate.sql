Use ResumeBuilder
Go
Create Table Skill(
	CredID int,
	Name nvarchar(50) not null,
	Description nvarchar(max) not null,
	FOREIGN KEY (CredID) REFERENCES Credential(CredID)
) 
Use ResumeBuilder
Go
Create Table Degree(
	CredID int,
	Name nvarchar(50) not null,
	Description nvarchar(max) not null,
	Field nvarchar(50) not null
	FOREIGN KEY (CredID) REFERENCES Credential(CredID)
) 
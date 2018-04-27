Use ResumeBuilder
Go
Create Table Experience(
	CredID int,
	Name nvarchar(50) not null,
	Description nvarchar(max) not null,
	StartDate date not null,
	EndDate date,
	FOREIGN KEY (CredID) REFERENCES Credential(CredID)

) 
USe	ResumeBuilder
Go
Create Table Position(
	PosID int,
	Salary money,
	Name nvarchar(50) not null,
	Location nvarchar(100),
	StartDate date not null, 
	Description nvarchar(max) not null
	PRIMARY KEY (PosID)
)
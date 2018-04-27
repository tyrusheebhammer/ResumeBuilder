Use	ResumeBuilder
Go
BULK INSERT Course
FROM 'C:\Users\sonnebtb\Desktop\DataBaseQueries\Course.csv'
WITH
(
    FIRSTROW = 0,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n'   --Use to shift the control to next row
)
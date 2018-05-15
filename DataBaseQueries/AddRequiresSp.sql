USE [ResumeBuilder]
Go
if exists (SELECT * FROM sysobjects WHERE name = 'AddRequires') drop procedure [AddRequires]
Go

CREATE PROCEDURE AddRequires
	@SkillID int,
	@PosID int
AS
	IF @PosID is null or @PosID = ''
	BEGIN
		PRINT 'ERROR: PosID cannot be null or empty';
		RETURN (1)
	END
	IF @SkillID is null or @SkillID = ''
	BEGIN
		PRINT 'ERROR: SkillID cannot be null or empty';
		RETURN (2)
	END
	IF(SELECT COUNT(*) FROM Requires 
		Where [SkillID] = @SkillID AND [PosID] = @PosID) = 1
	BEGIN
		PRINT 'Position already requires this skill';
		RETURN (3)
	END
	IF(SELECT Count(*) FROM Position
		Where PosID = @PosID) = 0
	Begin
		Print 'Position does not exist'
		Return (4)
	End
	IF(SELECT Count(*) FROM Skill
		Where SkillID = @SkillID) = 0
	Begin
		Print 'SKILLID does not exist'
		Return (5)
	End
	Insert into Requires(SkillID,PosID)
	Values(@SkillID, @PosID)
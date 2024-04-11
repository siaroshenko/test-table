CREATE PROCEDURE dbo.usp_MakeFamilyPurchase
  @FamilySurName VARCHAR(255)
AS
BEGIN
  DECLARE @FamilyID INT;
  
  SELECT @FamilyID = ID FROM dbo.Family
  WHERE SurName = @FamilySurName;
  
  IF @FamilyID IS NULL
    RAISERROR('Family with SurName "%s" not found.', 16, 1, @FamilySurName);
  ELSE
    UPDATE dbo.Family
    SET BudgetValue = (SELECT SUM(Value) FROM dbo.Basket WHERE ID_Family = @FamilyID)
    WHERE ID = @FamilyID;
  
END;
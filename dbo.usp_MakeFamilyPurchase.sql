CREATE PROCEDURE dbo.usp_MakeFamilyPurchase
    @FamilySurName NVARCHAR(255)
AS
BEGIN
    -- Check family with that surname for exists 
    IF NOT EXISTS (SELECT 1 FROM dbo.Family WHERE SurName = @FamilySurName)
    BEGIN
        RAISERROR(N'Family with that surname %s is not exists.', 16, 1, @FamilySurName)
        RETURN
    END

    -- Refresh value from BudgetValue field at family
    UPDATE dbo.Family
    SET BudgetValue = BudgetValue - (SELECT SUM(Value) FROM dbo.Basket WHERE ID_Family = (SELECT ID FROM dbo.Family WHERE SurName = @FamilySurName))
    WHERE SurName = @FamilySurName
END

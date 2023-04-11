CREATE PROCEDURE dbo.usp_MakeFamilyPurchase
    @FamilySurName NVARCHAR(255)
AS
BEGIN
    -- Check family with that surname for exists 
    IF NOT EXISTS (SELECT 1 FROM dbo.Family WHERE SurName = @FamilySurName)
    BEGIN
        RAISERROR(N'Family with that surname %s is not exists.', 16, 1, @FamilySurName)
        RETURN
    END;

    -- Refresh value from BudgetValue field at family
    WITH cte_basket AS (
        SELECT ID_Family, SUM(Value) AS TotalValue
        FROM dbo.Basket
        GROUP BY ID_Family
    )
    UPDATE f
    SET f.BudgetValue = f.BudgetValue - b.TotalValue
    FROM dbo.Family f
    INNER JOIN cte_basket b ON f.ID = b.ID_Family
    WHERE f.SurName = @FamilySurName
END

CREATE PROCEDURE dbo.usp_MakeFamilyPurchase
    @FamilySurName NVARCHAR(255)
AS
BEGIN
    -- Проверяем, существует ли семья с такой фамилией
    IF NOT EXISTS (SELECT 1 FROM dbo.Family WHERE SurName = @FamilySurName)
    BEGIN
        RAISERROR('Семьи с фамилией %s не существует.', 16, 1, @FamilySurName)
        RETURN
    END

    -- Обновляем значение поля BudgetValue у семьи
    UPDATE dbo.Family
    SET BudgetValue = BudgetValue - (SELECT SUM(Value) FROM dbo.Basket WHERE ID_Family = (SELECT ID FROM dbo.Family WHERE SurName = @FamilySurName))
    WHERE SurName = @FamilySurName
END

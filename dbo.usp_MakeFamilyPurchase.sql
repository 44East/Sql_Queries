CREATE PROCEDURE dbo.usp_MakeFamilyPurchase
    @FamilySurName NVARCHAR(255)
AS
BEGIN
    -- ���������, ���������� �� ����� � ����� ��������
    IF NOT EXISTS (SELECT 1 FROM dbo.Family WHERE SurName = @FamilySurName)
    BEGIN
        RAISERROR('����� � �������� %s �� ����������.', 16, 1, @FamilySurName)
        RETURN
    END

    -- ��������� �������� ���� BudgetValue � �����
    UPDATE dbo.Family
    SET BudgetValue = BudgetValue - (SELECT SUM(Value) FROM dbo.Basket WHERE ID_Family = (SELECT ID FROM dbo.Family WHERE SurName = @FamilySurName))
    WHERE SurName = @FamilySurName
END

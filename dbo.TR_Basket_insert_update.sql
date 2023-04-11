CREATE TRIGGER dbo.TR_Basket_insert_update
ON dbo.Basket
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    WITH sku_counts AS (
        SELECT ID_SKU, COUNT(*) AS Count
        FROM inserted
        GROUP BY ID_SKU
    )
    UPDATE b
    SET DiscountValue = CASE 
                          WHEN c.Count > 1 THEN b.Value * 0.05 
                          ELSE 0 
                        END
    FROM dbo.Basket AS b
    INNER JOIN sku_counts AS c ON b.ID_SKU = c.ID_SKU
    INNER JOIN dbo.SKU AS s ON s.ID = b.ID_SKU;
END;
GO

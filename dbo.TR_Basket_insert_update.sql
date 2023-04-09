CREATE TRIGGER dbo.TR_Basket_insert_update
ON dbo.Basket
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- calculating DiscountValue for each ID_SKU
    UPDATE b
    SET DiscountValue = CASE 
                          WHEN sku_counts.Count > 1 THEN b.Value * 0.05 
                          ELSE 0 
                        END
    FROM dbo.Basket AS b
    INNER JOIN (
      SELECT ID_SKU, COUNT(*) AS Count
      FROM inserted
      GROUP BY ID_SKU
    ) AS sku_counts ON b.ID_SKU = sku_counts.ID_SKU
    INNER JOIN dbo.SKU AS s ON s.ID = b.ID_SKU;
END;
GO

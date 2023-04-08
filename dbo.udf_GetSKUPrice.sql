CREATE FUNCTION dbo.udf_GetSKUPrice
    (@ID_SKU INT)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    DECLARE @TotalValue DECIMAL(18, 2)
    DECLARE @TotalQuantity DECIMAL(18, 3)
    DECLARE @Price DECIMAL(18, 2)
    
    SELECT @TotalValue = SUM(Value), @TotalQuantity = SUM(Quantity)
    FROM dbo.Basket
    WHERE ID_SKU = @ID_SKU
    
    IF @TotalQuantity > 0
        SET @Price = @TotalValue / @TotalQuantity
    ELSE
        SET @Price = 0
    
    RETURN @Price
END

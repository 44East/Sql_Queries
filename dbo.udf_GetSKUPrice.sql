CREATE FUNCTION dbo.udf_GetSKUPrice
    (@ID_SKU INT)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    RETURN (
        SELECT SUM(Value) / NULLIF(SUM(Quantity), 0) -- If Quantity == 0 then the right operand returns NULL, 
        FROM dbo.Basket								 -- because dividing on zero prohibitted and then the full expression returns null
        WHERE ID_SKU = @ID_SKU
    )
END

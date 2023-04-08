CREATE VIEW dbo.vw_SKUPrice
AS
SELECT 
    s.ID,
    s.Code,
    s.Name,
    dbo.udf_GetSKUPrice(s.ID) AS Price
FROM dbo.SKU s

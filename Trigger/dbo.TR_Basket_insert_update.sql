CREATE TRIGGER dbo.TR_Basket_insert_update
ON dbo.Basket
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE b
    SET DiscountValue = CASE
                            WHEN i.Quantity > 1 THEN i.Value * 0.05
                            ELSE 0
                        END
    FROM dbo.Basket b
    INNER JOIN inserted i ON b.ID = i.ID
    WHERE b.ID_SKU IN (SELECT ID_SKU FROM inserted i2 GROUP BY ID_SKU HAVING COUNT(*) > 1);
END;
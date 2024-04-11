create trigger dbo.TR_Basket_insert_update
on dbo.Basket
after insert, update
as
begin
	set nocount on;

	update b
	set DiscountValue = case
		when i.Quantity > 1 
			then i.Value * 0.05
		else 0
	end
	from dbo.Basket b
	inner join (
        select ID_SKU, sum(Quantity) as Quantity, sum(Value) as Value
        from inserted
        group by ID_SKU
    ) i on b.ID_SKU = i.ID_SKU
    where b.ID in (select ID from inserted)
          or b.ID in (select ID from deleted);
end;
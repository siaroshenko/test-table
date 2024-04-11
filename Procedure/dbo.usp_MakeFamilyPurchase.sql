create procedure dbo.usp_MakeFamilyPurchase
	@FamilySurName varchar(255)
as
begin
	declare @FamileID int;

	if not exists (select * from dbo.Family where SurName = @FamilySurName)
	begin
		raiserror('Family with SurName "%s" not found.', 16, 1, @FamilySurName);

		return;
	end

	update dbo.Family
	set BudgetValue = (select sum(Value) from dbo.Basket where ID_Family = Family.ID)
	from dbo.Family
	where Family.Surname = @FamilySurName;
  
end;
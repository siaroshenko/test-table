create table dbo.SKU (
  ID int identity(1, 1) primary key,
  Code as ('s' + cast(ID as nvarchar(255))) persisted,
  Name nvarchar(255),
  unique (Code)
);

create table dbo.Family (
  ID int identity(1, 1) primary key,
  SurName nvarchar(255),
  BudgetValue decimal(18, 2)
);

create table dbo.Basket (
  ID int identity(1, 1) primary key,
  ID_SKU int,
  ID_Family int,
  Quantity int check (Quantity >= 0),
  Value decimal(18, 2) check (Value >= 0),
  PurchaseDate date default getdate(),
  DiscountValue decimal(18, 2),
  foreign key (ID_SKU) references dbo.SKU(ID),
  foreign key (ID_Family) references dbo.Family(ID)
);
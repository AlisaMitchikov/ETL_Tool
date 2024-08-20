use [Northwind - DWH]																		
											-- create tables --
									-----------------------------
truncate table [ODS_Order Details]
-- orders, order details, employees, exchange, products			


-- ODS --
---------



--[Orders]
CREATE TABLE [Northwind - DWH].[dbo].[ODS_Orders]
(
	[OrderID] [int] ,
	[CustomerID] [nchar](5) ,
	[EmployeeID] [int] ,
	[OrderDate] [datetime2] ,
	[RequiredDate] [datetime2] ,
	[ShippedDate] [datetime2] ,
	[ShipVia] [int] ,
	[Freight] [money] ,
	[ShipName] [nvarchar](40) ,
	[ShipAddress] [nvarchar](60) ,
	[ShipCity] [nvarchar](15) ,
	[ShipRegion] [nvarchar](15) ,
	[ShipPostalCode] [nvarchar](10) ,
	[ShipCountry] [nvarchar](15)
)
;
drop table [Northwind - DWH].[dbo].[ODS_Orders];
truncate table [Northwind - DWH].[dbo].[ODS_Orders];
SELECT
       [OrderID]
      ,[CustomerID]
      ,[EmployeeID]
      ,[OrderDate]
      ,[RequiredDate]
      ,[ShippedDate]
      ,[ShipVia]
      ,[Freight]
      ,[ShipName]
      ,[ShipAddress]
      ,[ShipCity]
      ,[ShipRegion]
      ,[ShipPostalCode]
      ,[ShipCountry]
FROM [Northwind - DWH].[dbo].[ODS_Orders]
;



--[Order Details]
CREATE TABLE [Northwind - DWH].[dbo].[ODS_Order Details](
	[OrderID] [int],
	[ProductID] [int],
	[UnitPrice_USD] [money],
	[Quantity] [smallint],
	[Discount] [real]
)
;
drop table [Northwind - DWH].[dbo].[ODS_Order Details];
truncate table [Northwind - DWH].[dbo].[ODS_Order Details];
select * from [Northwind - DWH].[dbo].[ODS_Order Details];



--[Employees]
CREATE TABLE [Northwind - DWH].[dbo].[ODS_Employees](
	[EmployeeID] [int] ,
	[LastName] [nvarchar](20) ,
	[FirstName] [nvarchar](10) ,
	[Title] [nvarchar](30) ,
	[TitleOfCourtesy] [nvarchar](25) ,
	[BirthDate] [datetime] ,
	[HireDate] [datetime] ,
	[Address] [nvarchar](60) ,
	[City] [nvarchar](15) ,
	[Region] [nvarchar](15) ,
	[PostalCode] [nvarchar](10) ,
	[Country] [nvarchar](15) ,
	[HomePhone] [nvarchar](24) ,
	[Extension] [nvarchar](4) ,
	[Photo] [image] ,
	[Notes] [ntext] ,
	[ReportsTo] [int] ,
	[PhotoPath] [nvarchar](255)
    )
;

CREATE TABLE [Northwind - DWH].[dbo].[ODS_Employees](
	[EmployeeID] [nvarchar](20) ,
	[LastName] [nvarchar](20) ,
	[FirstName] [nvarchar](10) ,
	[Title] [nvarchar](30) ,
	[TitleOfCourtesy] [nvarchar](25) ,
	[BirthDate] [datetime] ,
	[HireDate] [datetime] ,
	[Address] [nvarchar](60) ,
	[City] [nvarchar](15) ,
	[Region] [nvarchar](15) ,
	[PostalCode] [nvarchar](10) ,
	[Country] [nvarchar](15) ,
	[HomePhone] [nvarchar](24) ,
	[Extension] [nvarchar](4) ,
	[Photo] [image] ,
	[Notes] [nvarchar](255) ,
	[ReportsTo] [nvarchar](20) ,
	[PhotoPath] [nvarchar](255)
    )
;

drop table [Northwind - DWH].[dbo].[ODS_Employees];
truncate table [Northwind - DWH].[dbo].[ODS_Employees];
select * from [Northwind - DWH].[dbo].[ODS_Employees];



-- [Exchange Rate]
CREATE TABLE [Northwind - DWH].[dbo].[ODS_Exchange_Rate](
	[result] varchar(100),
	[documentation] varchar(100),
	[terms_of_use] varchar(100),
	[time_last_update_unix] varchar(100),
	[time_last_update_utc] varchar(100),
	[time_next_update_unix] varchar(100),
	[time_next_update_utc] varchar(100),
	[base_code] varchar(100),
	[conversion_rates] varchar(100),
	[index1] varchar(100)
	)
;
drop table [Northwind - DWH].[dbo].[ODS_Exchange_Rate];
truncate table [Northwind - DWH].[dbo].[ODS_Exchange_Rate];
select * from [Northwind - DWH].[dbo].[ODS_Exchange_Rate];


 -- [products]
CREATE TABLE [Northwind - DWH].[dbo].[ODS_Products](
	[ProductID] [int],
	[ProductName] [nvarchar](40) ,
	[SupplierID] [int] ,
	[CategoryID] [int] ,
	[QuantityPerUnit] [nvarchar](20) ,
	[UnitPrice] [money] ,
	[UnitsInStock] [smallint] ,
	[UnitsOnOrder] [smallint] ,
	[ReorderLevel] [smallint] ,
	[Discontinued] [bit]  
)
;
drop table [Northwind - DWH].[dbo].[ODS_Products];
select * from [Northwind - DWH].[dbo].[ODS_Products];
truncate table [Northwind - DWH].[dbo].[ODS_Products];


use [Northwind - DWH]																		
											-- create tables --
											-------------------

-- ODS --
---------

-- [Customers]
drop table [Northwind - DWH].[dbo].[ODS_Customers];
CREATE TABLE [Northwind - DWH].[dbo].[ODS_Customers]
(
	[CustomerID] [nchar](5) ,
	[CompanyName] [nvarchar](40) ,
	[ContactName] [nvarchar](30) ,
	[ContactTitle] [nvarchar](30) ,
	[Address] [nvarchar](60) ,
	[City] [nvarchar](15) ,
	[Region] [nvarchar](15) ,
	[PostalCode] [nvarchar](10) ,
	[Country] [nvarchar](15) ,
	[Phone] [nvarchar](24) ,
	[Fax] [nvarchar](24)
)
;
--truncate table [Northwind - DWH].[dbo].[ODS_Customers];
SELECT 
	   [CustomerID]
      ,[CompanyName]
      ,[ContactName]
      ,[ContactTitle]
      ,[Address]
      ,[City]
      ,[Region]
      ,[PostalCode]
      ,[Country]
      ,[Phone]
      ,[Fax]
FROM [Northwind - DWH].[dbo].[ODS_Customers]
;


--[Orders]
drop table [Northwind - DWH].[dbo].[ODS_Orders];
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
--truncate table [Northwind - DWH].[dbo].[ODS_Orders];
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

--[Region]
drop table [Northwind - DWH].[dbo].[ODS_Region];
CREATE TABLE [Northwind - DWH].[dbo].[ODS_Region](
	[RegionID] [varchar](10) ,
	[RegionDescription] [varchar](10) 
)
;
select * from [Northwind - DWH].[dbo].[ODS_Region];
truncate table [Northwind - DWH].[dbo].[ODS_Region];



-- [Exchange Rate]
CREATE TABLE [Northwind - DWH].[dbo].[ODS_Exchange_Rate](
--	[index] varchar(100),
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
select * from [Northwind - DWH].[dbo].[ODS_Exchange_Rate];



----------------------------------------------------------------------

-- STG --
---------

-- [STG_Fact_Customers_KPIs]
CREATE TABLE [Northwind - DWH].[dbo].[STG_Fact_Customers_KPIs]
(
	[CustomerID] [nchar](5) ,
	[#_orders] [int]
)
;
truncate table [Northwind - DWH].[dbo].[STG_Fact_Customers_KPIs];
select * from [Northwind - DWH].[dbo].[STG_Fact_Customers_KPIs];

----------------------------------------------------------------------

-- DWH --
---------

-- [STG_Fact_Customers_KPIs]
CREATE TABLE [Northwind - DWH].[dbo].[DWH_Fact_Customers_KPIs]
(
	[CustomerID] [nchar](5) ,
	[#_orders] [int]
)
;
truncate table [Northwind - DWH].[dbo].[DWH_Fact_Customers_KPIs];
select * from [Northwind - DWH].[dbo].[DWH_Fact_Customers_KPIs];


-------------

create table [Northwind - DWH].[dbo].[bla]
(
RegionID varchar(10),
RegionDescription varchar(10)
)
;
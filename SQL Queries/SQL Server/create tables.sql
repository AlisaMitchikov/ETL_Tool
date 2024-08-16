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




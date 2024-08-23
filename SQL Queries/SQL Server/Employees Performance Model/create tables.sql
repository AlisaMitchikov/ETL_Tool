use [Northwind - DWH]																		
											-- create tables --
									  -----------------------------

------------------------------------------------ ODS ------------------------------------------------
-----------------------------------------------------------------------------------------------------

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

------------------------------------------------------------------

--[Order Details]
CREATE TABLE [Northwind - DWH].[dbo].[ODS_Order Details](
	[OrderID] [int],
	[ProductID] [int],
	[UnitPrice] [money],
	[Quantity] [smallint],
	[Discount] [real]
)
;
drop table [Northwind - DWH].[dbo].[ODS_Order Details];
truncate table [Northwind - DWH].[dbo].[ODS_Order Details];
select * from [Northwind - DWH].[dbo].[ODS_Order Details];

------------------------------------------------------------------

--[Employees]
CREATE TABLE [dbo].[ODS_Employees]
(
	[EmployeeID] [nvarchar](20) NULL,
	[LastName] [nvarchar](20) NULL,
	[FirstName] [nvarchar](10) NULL,
	[Title] [nvarchar](30) NULL,
	[TitleOfCourtesy] [nvarchar](25) NULL,
	[BirthDate] [datetime] NULL,
	[HireDate] [datetime] NULL,
	[Address] [nvarchar](60) NULL,
	[City] [nvarchar](15) NULL,
	[Region] [nvarchar](15) NULL,
	[PostalCode] [nvarchar](10) NULL,
	[Country] [nvarchar](15) NULL,
	[HomePhone] [nvarchar](24) NULL,
	[Extension] [nvarchar](4) NULL,
	[Photo] [image] NULL,
	[Notes] [nvarchar](1000) NULL,
	[ReportsTo] [nvarchar](20) NULL,
	[PhotoPath] [nvarchar](255) NULL
) 
;
drop table [Northwind - DWH].[dbo].[ODS_Employees];
truncate table [Northwind - DWH].[dbo].[ODS_Employees];
select * from [Northwind - DWH].[dbo].[ODS_Employees];

------------------------------------------------------------------

-- [products]
 CREATE TABLE [dbo].[ODS_Products](
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

------------------------------------------------------------------

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


------------------------------------------------ STG ------------------------------------------------
-----------------------------------------------------------------------------------------------------
-- [Orders + Order Details]
CREATE TABLE [Northwind - DWH].[dbo].[STG_Fact_Orders]
(
	[OrderID] [int] NULL,
	[CustomerID] [nchar](5) NULL,
	[EmployeeID] [int] NULL,
	[OrderDate] [datetime2](7) NULL,
	[RequiredDate] [datetime2](7) NULL,
	[ShippedDate] [datetime2](7) NULL,
	[ShipVia] [int] NULL,
	[Freight] [money] NULL,
	[ShipName] [nvarchar](40) NULL,
	[ShipAddress] [nvarchar](60) NULL,
	[ShipCity] [nvarchar](15) NULL,
	[ShipRegion] [nvarchar](15) NULL,
	[ShipPostalCode] [nvarchar](10) NULL,
	[ShipCountry] [nvarchar](15) NULL,
	[ProductID] [int] NULL,
	[UnitPrice] [money] NULL,
	[Quantity] [smallint] NULL,
	[Discount] [real] NULL
) 
;
drop table [Northwind - DWH].[dbo].[STG_Fact_Orders]
select * from [Northwind - DWH].[dbo].[STG_Fact_Orders];
truncate table [Northwind - DWH].[dbo].[STG_Fact_Orders];



--[Employees]
CREATE TABLE [dbo].[STG_DIM_Employees]
(
	[EmployeeID] [nvarchar](20) NULL,
	[LastName] [nvarchar](20) NULL,
	[FirstName] [nvarchar](10) NULL,
	[Title] [nvarchar](30) NULL,
	[TitleOfCourtesy] [nvarchar](25) NULL,
	[BirthDate] [datetime] NULL,
	[HireDate] [datetime] NULL,
	[Address] [nvarchar](60) NULL,
	[City] [nvarchar](15) NULL,
	[Region] [nvarchar](15) NULL,
	[PostalCode] [nvarchar](10) NULL,
	[Country] [nvarchar](15) NULL,
	[HomePhone] [nvarchar](24) NULL,
	[Extension] [nvarchar](4) NULL,
	[Photo] [image] NULL,
	[Notes] [nvarchar](1000) NULL,
	[ReportsTo] [nvarchar](20) NULL,
	[PhotoPath] [nvarchar](255) NULL
) 
;
drop table [Northwind - DWH].[dbo].[STG_DIM_Employees];
truncate table [Northwind - DWH].[dbo].[STG_DIM_Employees];
select * from [Northwind - DWH].[dbo].[STG_DIM_Employees];


-- [products]
 CREATE TABLE [dbo].[STG_DIM_Products](
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
drop table [Northwind - DWH].[dbo].[STG_DIM_Products];
select * from [Northwind - DWH].[dbo].[STG_DIM_Products];
truncate table [Northwind - DWH].[dbo].[STG_DIM_Products];


-- [Exchange Rate]
CREATE TABLE [Northwind - DWH].[dbo].[STG_DIM_Exchange_Rate](
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
drop table [Northwind - DWH].[dbo].[STG_DIM_Exchange_Rate];
truncate table [Northwind - DWH].[dbo].[STG_DIM_Exchange_Rate];
select * from [Northwind - DWH].[dbo].[STG_DIM_Exchange_Rate];


------------------------------------------------ DWH ------------------------------------------------
-----------------------------------------------------------------------------------------------------

-- [Orders + Order Details]
CREATE TABLE [Northwind - DWH].[dbo].[DWH_Fact_Orders]
(
	[OrderID] [int] NULL,
	[CustomerID] [nchar](5) NULL,
	[EmployeeID] [int] NULL,
	[OrderDate] [datetime2](7) NULL,
	[RequiredDate] [datetime2](7) NULL,
	[ShippedDate] [datetime2](7) NULL,
	[ShipVia] [int] NULL,
	[Freight] [money] NULL,
	[ShipName] [nvarchar](40) NULL,
	[ShipAddress] [nvarchar](60) NULL,
	[ShipCity] [nvarchar](15) NULL,
	[ShipRegion] [nvarchar](15) NULL,
	[ShipPostalCode] [nvarchar](10) NULL,
	[ShipCountry] [nvarchar](15) NULL,
	[ProductID] [int] NULL,
	[UnitPrice] [money] NULL,
	[Quantity] [smallint] NULL,
	[Discount] [real] NULL
) 
;
drop table [Northwind - DWH].[dbo].[DWH_Fact_Orders]
select * from [Northwind - DWH].[dbo].[DWH_Fact_Orders];
truncate table [Northwind - DWH].[dbo].[DWH_Fact_Orders];


--[Employees]
CREATE TABLE [dbo].[DWH_DIM_Employees]
(
	[EmployeeID] [nvarchar](20) NULL,
	[LastName] [nvarchar](20) NULL,
	[FirstName] [nvarchar](10) NULL,
	[Title] [nvarchar](30) NULL,
	[TitleOfCourtesy] [nvarchar](25) NULL,
	[BirthDate] [datetime] NULL,
	[HireDate] [datetime] NULL,
	[Address] [nvarchar](60) NULL,
	[City] [nvarchar](15) NULL,
	[Region] [nvarchar](15) NULL,
	[PostalCode] [nvarchar](10) NULL,
	[Country] [nvarchar](15) NULL,
	[HomePhone] [nvarchar](24) NULL,
	[Extension] [nvarchar](4) NULL,
	[Photo] [image] NULL,
	[Notes] [nvarchar](1000) NULL,
	[ReportsTo] [nvarchar](20) NULL,
	[PhotoPath] [nvarchar](255) NULL
) 
;
drop table [Northwind - DWH].[dbo].[DWH_DIM_Employees];
truncate table [Northwind - DWH].[dbo].[DWH_DIM_Employees];
select * from [Northwind - DWH].[dbo].[DWH_DIM_Employees];


-- [products]
CREATE TABLE [dbo].[DWH_DIM_Products](
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
drop table [Northwind - DWH].[dbo].[DWH_DIM_Products];
select * from [Northwind - DWH].[dbo].[DWH_DIM_Products];
truncate table [Northwind - DWH].[dbo].[DWH_DIM_Products];


-- [Exchange Rate]
CREATE TABLE [Northwind - DWH].[dbo].[DWH_DIM_Exchange_Rate](
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
drop table [Northwind - DWH].[dbo].[DWH_DIM_Exchange_Rate];
truncate table [Northwind - DWH].[dbo].[DWH_DIM_Exchange_Rate];
select * from [Northwind - DWH].[dbo].[DWH_DIM_Exchange_Rate];


--[Employye Performance]
CREATE TABLE [dbo].[DWH_Fact_Employee_Performance]
(
	[EmployeeID] [int] NULL,
	[EmployeeName] [nvarchar](31) NULL,
	[OrderDate] [date] NULL,
	[USDTotalSales] [money] NULL,
	[EURTotalSales] [money] NOT NULL,
	[UnqCountProducts] [int] NULL,
	[CumulativeUSDTotalSales] [money] NULL,
	[MovingAverageUSDSales] [money] NULL,
	[DailySalesRank] [bigint] NULL
) 
;
drop table [Northwind - DWH].[dbo].[DWH_Fact_Employee_Performance];
truncate table [Northwind - DWH].[dbo].[DWH_Fact_Employee_Performance];
select * from [Northwind - DWH].[dbo].[DWH_Fact_Employee_Performance];


------------------------------------------------------------------------------------------------------------------------------------------------------------------------
											-- insert tables --
									  -----------------------------
-- [Exchange Rate]
insert into [Northwind - DWH].[dbo].[DWH_DIM_Exchange_Rate] values
('success',	'https://www.exchangerate-api.com/docs',	'https://www.exchangerate-api.com/terms',	1724198401,	'Tue, 20 Aug 2024 00:00:01 +0000',	1724284801,	'Wed, 21 Aug 2024 00:00:01 +0000','USD',	0.9002,	'EUR'),
('success',	'https://www.exchangerate-api.com/docs',	'https://www.exchangerate-api.com/terms',	1724198401,	'Mon, 19 Aug 2024 00:00:01 +0000',	1724284801,	'Tue, 20 Aug 2024 00:00:01 +0000','USD',	0.9002,	'EUR'),
('success',	'https://www.exchangerate-api.com/docs',	'https://www.exchangerate-api.com/terms',	1724198401,	'Sun, 18 Aug 2024 00:00:01 +0000',	1724284801,	'Mon, 19 Aug 2024 00:00:01 +0000','USD',	0.9002,	'EUR'),
('success',	'https://www.exchangerate-api.com/docs',	'https://www.exchangerate-api.com/terms',	1724198401,	'Sat, 17 Aug 2024 00:00:01 +0000',	1724284801,	'Sun, 18 Aug 2024 00:00:01 +0000','USD',	0.9002,	'EUR'),
('success',	'https://www.exchangerate-api.com/docs',	'https://www.exchangerate-api.com/terms',	1724198401,	'Fri, 16 Aug 2024 00:00:01 +0000',	1724284801,	'Sat, 17 Aug 2024 00:00:01 +0000','USD',	0.9002,	'EUR'),
('success',	'https://www.exchangerate-api.com/docs',	'https://www.exchangerate-api.com/terms',	1724198401,	'Thu, 15 Aug 2024 00:00:01 +0000',	1724284801,	'Fri, 16 Aug 2024 00:00:01 +0000','USD',	0.9002,	'EUR')
;

use [Northwind - DWH]										
										-- build etl queries --
										-----------------------

-- create logic --
------------------

-- [ODS]
use [Northwind - OPR]	
-- [Customers]
truncate table [Northwind - DWH].[dbo].[ODS_Customers];

insert into [Northwind - DWH].[dbo].[ODS_Customers] ([CustomerID],[CompanyName],[ContactName],[ContactTitle],[Address],[City],[Region],[PostalCode],[Country],[Phone],[Fax])
select 
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
from [Northwind - OPR].[dbo].[Customers]
;


--[Orders]
truncate table [Northwind - DWH].[dbo].[ODS_Orders];

insert into [Northwind - DWH].[dbo].[ODS_Orders] ([OrderID],[CustomerID],[EmployeeID],[OrderDate],[RequiredDate],[ShippedDate],[ShipVia],[Freight],[ShipName],[ShipAddress],[ShipCity],[ShipRegion],[ShipPostalCode],[ShipCountry])
select 
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
from [Northwind - OPR].[dbo].[Orders]
;


-- [STG]
truncate table [Northwind - DWH].[dbo].[STG_Fact_Customers_KPIs];

insert into [Northwind - DWH].[dbo].[STG_Fact_Customers_KPIs] ([CustomerID],[#_orders])
select 
	   c.[CustomerID],
       count(o.OrderID) as #_orders
from [Northwind - DWH].[dbo].[ODS_Customers] c
left join [Northwind - DWH].[dbo].[ODS_Orders] o on c.CustomerID = o.CustomerID
group by c.[CustomerID]
order by #_orders desc
;

-- [DWH]
delete from [Northwind - DWH].[dbo].[DWH_Fact_Customers_KPIs] 
where exists (select 1
              from [Northwind - DWH].[dbo].[STG_Fact_Customers_KPIs] s
			  where s.[CustomerID] = [Northwind - DWH].[dbo].[DWH_Fact_Customers_KPIs].[CustomerID])

insert into [Northwind - DWH].[dbo].[DWH_Fact_Customers_KPIs] ([CustomerID],[#_orders])
select [CustomerID],[#_orders] from [Northwind - DWH].[dbo].[STG_Fact_Customers_KPIs]
;



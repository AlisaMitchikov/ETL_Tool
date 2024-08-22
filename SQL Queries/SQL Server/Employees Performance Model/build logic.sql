use [Northwind - DWH]																		
											-- build logic --
									  -----------------------------

select conversion_rates as EUR_conversion_rate, 
       [time_last_update_utc] as date,
       CAST(CONVERT(DATE, TRIM(SUBSTRING([time_last_update_utc],(CHARINDEX(',', [time_last_update_utc])+1),((select len([time_last_update_utc]))-(SELECT CHARINDEX('00', [time_last_update_utc]))))), 113) AS DATE) as date
from [ODS_Exchange_Rate]
where index1 = 'EUR'
;



SELECT 

	-- select employee, date, sum sales 
    SD.EmployeeID,
    SD.OrderDate,
    SD.USDTotalSales,
    SD.EURTotalSales,
	SD.UnqCountProducts,

    -- cumulative sum sales
    SUM(SD.USDTotalSales) OVER (PARTITION BY SD.EmployeeID ORDER BY SD.OrderDate) AS CumulativeUSDTotalSales,

    -- cumulative avg sum sales
    AVG(SD.USDTotalSales) OVER (
        PARTITION BY SD.EmployeeID 
        ORDER BY SD.OrderDate 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS MovingAverageUSDSales,

    -- Rank of Employees by Total Sales per Day
    RANK() OVER (
        PARTITION BY SD.OrderDate 
        ORDER BY SD.USDTotalSales DESC
    ) AS DailySalesRank

FROM
(
    -- group by employee, date --> sum sales
    SELECT 
        O.EmployeeID,
        CONVERT(DATE, O.OrderDate) AS OrderDate,
        SUM(OD.Quantity * OD.UnitPrice_USD) AS USDTotalSales,
        isnull(SUM(OD.Quantity * OD.UnitPrice_USD * e.conversion_rates),-1) AS EURTotalSales,
		count(distinct ProductID) as UnqCountProducts
    FROM 
        Orders O
    LEFT JOIN 
        [Order Details] OD ON O.OrderID = OD.OrderID
	LEFT JOIN 
		[ODS_Exchange_Rate] e 
			ON CAST(CONVERT(DATE, TRIM(SUBSTRING([time_last_update_utc],(CHARINDEX(',', [time_last_update_utc])+1),((select len([time_last_update_utc]))-(SELECT CHARINDEX('00', [time_last_update_utc]))))), 113) AS DATE) = CONVERT(DATE, O.OrderDate)
    GROUP BY 
        O.EmployeeID, O.OrderDate
) SD
	
order by EmployeeID, OrderDate
;


-------------------------------------------------TABLES-------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------


------------------------------------------------ [Orders] ------------------------------------------------
----------------------------------------------------------------------------------------------------------
-- select from tables --
select * from [Northwind - DWH].[dbo].[ODS_Orders];
select * from [Northwind - DWH].[dbo].[ODS_Order Details];
select * from [Northwind - DWH].[dbo].[STG_Fact_Orders];
select * from [Northwind - DWH].[dbo].[DWH_Fact_Orders];

-- STG --
truncate table [Northwind - DWH].[dbo].[STG_Fact_Orders];
insert into [Northwind - DWH].[dbo].[STG_Fact_Orders] 
select 
	   o.[OrderID]
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
      ,[ProductID]
      ,[UnitPrice]
      ,[Quantity]
      ,[Discount]
from [ODS_Orders] o
left join [ODS_Order Details] od on o.OrderID = od.OrderID
;

-- DWH
delete from [Northwind - DWH].[dbo].[DWH_Fact_Orders]
where exists (select 1
			  from [Northwind - DWH].[dbo].[STG_Fact_Orders] s
			  where s.[OrderID] = [Northwind - DWH].[dbo].[DWH_Fact_Orders].[OrderID]
			  and  s.[OrderID] = [Northwind - DWH].[dbo].[DWH_Fact_Orders].[OrderID])
;
insert into [Northwind - DWH].[dbo].[DWH_Fact_Orders]
select * from [Northwind - DWH].[dbo].[STG_Fact_Orders]
;

------------------------------------------------ [Employees] ------------------------------------------------
-------------------------------------------------------------------------------------------------------------

-- select from tables --
select * from [Northwind - DWH].[dbo].[ODS_Employees];
select * from [Northwind - DWH].[dbo].[STG_DIM_Employees];
select * from [Northwind - DWH].[dbo].[DWH_DIM_Employees];

-- STG --
truncate table [Northwind - DWH].[dbo].[STG_DIM_Employees];
insert into [Northwind - DWH].[dbo].[STG_DIM_Employees]
select * from [ODS_Employees];

-- DWH --
truncate table [Northwind - DWH].[dbo].[DWH_DIM_Employees];
insert into [Northwind - DWH].[dbo].[DWH_DIM_Employees]
select * from [STG_DIM_Employees];


------------------------------------------------ [products] ------------------------------------------------
------------------------------------------------------------------------------------------------------------

-- select from tables --
select * from [Northwind - DWH].[dbo].[ODS_Products];
select * from [Northwind - DWH].[dbo].[STG_DIM_Products];
select * from [Northwind - DWH].[dbo].[DWH_DIM_Products];

-- STG --
truncate table [Northwind - DWH].[dbo].[STG_DIM_Products];
insert into [Northwind - DWH].[dbo].[STG_DIM_Products]
select * from [ODS_Products];

-- DWH --
truncate table [Northwind - DWH].[dbo].[DWH_DIM_Products];
insert into [Northwind - DWH].[dbo].[DWH_DIM_Products]
select * from [STG_DIM_Products];


------------------------------------------------ [Exchange Rate] ------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

-- select from tables --
select * from [Northwind - DWH].[dbo].[ODS_Exchange_Rate];
select * from [Northwind - DWH].[dbo].[STG_DIM_Exchange_Rate];
select * from [Northwind - DWH].[dbo].[DWH_DIM_Exchange_Rate];

-- STG
insert into [Northwind - DWH].[dbo].[STG_DIM_Exchange_Rate]
select * from [Northwind - DWH].[dbo].[ODS_Exchange_Rate] where index1 = 'EUR'
;

-- DWH
delete from [Northwind - DWH].[dbo].[DWH_DIM_Exchange_Rate]
where exists (select 1
			  from [Northwind - DWH].[dbo].[STG_DIM_Exchange_Rate] s
			  where s.time_last_update_utc = [Northwind - DWH].[dbo].[DWH_DIM_Exchange_Rate].time_last_update_utc)
;
insert into [Northwind - DWH].[dbo].[DWH_DIM_Exchange_Rate]
select * from [Northwind - DWH].[dbo].[STG_DIM_Exchange_Rate]
;


-------------------------------------------------VIEWS-------------------------------------------------
-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------

create view [Vw_Fact_Employee_Performance]
as
SELECT 

	-- select employee, date, sum sales 
    SD.EmployeeID,
    SD.OrderDate,
    SD.USDTotalSales,
    SD.EURTotalSales,
	SD.UnqCountProducts,

    -- cumulative sum sales
    SUM(SD.USDTotalSales) OVER (PARTITION BY SD.EmployeeID ORDER BY SD.OrderDate) AS CumulativeUSDTotalSales,

    -- cumulative avg sum sales
    AVG(SD.USDTotalSales) OVER (
        PARTITION BY SD.EmployeeID 
        ORDER BY SD.OrderDate 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS MovingAverageUSDSales,

    -- Rank of Employees by Total Sales per Day
    RANK() OVER (
        PARTITION BY SD.OrderDate 
        ORDER BY SD.USDTotalSales DESC
    ) AS DailySalesRank

FROM
(
    -- group by employee, date --> sum sales
    SELECT 
        o.EmployeeID,
        CONVERT(DATE, o.OrderDate) AS OrderDate,
        SUM(o.Quantity * o.UnitPrice) AS USDTotalSales,
        isnull(SUM(o.Quantity * o.UnitPrice * e.conversion_rates),-1) AS EURTotalSales,
		count(distinct ProductID) as UnqCountProducts
    FROM [DWH_Fact_Orders] o
	LEFT JOIN [DWH_DIM_Exchange_Rate] e 
	   ON CAST(CONVERT(DATE, TRIM(SUBSTRING([time_last_update_utc],(CHARINDEX(',', [time_last_update_utc])+1),((select len([time_last_update_utc]))-(SELECT CHARINDEX('00', [time_last_update_utc]))))), 113) AS DATE) = CONVERT(DATE, o.OrderDate)
    GROUP BY 
        o.EmployeeID, o.OrderDate
) SD

;

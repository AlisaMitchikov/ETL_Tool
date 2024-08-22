from functions import ETL

# --------OPR----------


# OPR SQL Server tables
OPR_to_ODS_tables_list_SQL = ['Orders','Order Details','Employees']
# OPR_to_ODS_tables_list_SQL = []

# OPR MySQL tables
OPR_to_ODS_tables_list_MySQL = ['products']
# OPR_to_ODS_tables_list_MySQL = []

# OPR CSV
OPR_to_ODS_tables_list_CSV = {}

# OPR API
OPR_to_ODS_tables_list_API = {'ODS_Exchange_Rate':r'https://v6.exchangerate-api.com/v6/12566f6fc3a965b80afd4734/latest/USD'}

# --------STG + DWH----------

# ETL queries 
DWH_queries_dict = {
    # TABLES
        'Orders_STG' : """truncate table [Northwind - DWH].[dbo].[STG_Fact_Orders];
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
                            ;""",
        'Orders_DWH' : """delete from [Northwind - DWH].[dbo].[DWH_Fact_Orders]
                            where exists (select 1
                                        from [Northwind - DWH].[dbo].[STG_Fact_Orders] s
                                        where s.[OrderID] = [Northwind - DWH].[dbo].[DWH_Fact_Orders].[OrderID]
                                        and  s.[OrderID] = [Northwind - DWH].[dbo].[DWH_Fact_Orders].[OrderID])
                            ;
                            insert into [Northwind - DWH].[dbo].[DWH_Fact_Orders]
                            select * from [Northwind - DWH].[dbo].[STG_Fact_Orders]
                            ;""",
        'Employees_STG' : """truncate table [Northwind - DWH].[dbo].[STG_DIM_Employees];
                                insert into [Northwind - DWH].[dbo].[STG_DIM_Employees]
                                select * from [ODS_Employees];""",
        'Employees_DWH' : """truncate table [Northwind - DWH].[dbo].[DWH_DIM_Employees];
                                insert into [Northwind - DWH].[dbo].[DWH_DIM_Employees]
                                select * from [STG_DIM_Employees];""",
        'products_STG' : """truncate table [Northwind - DWH].[dbo].[STG_DIM_Products];
                                insert into [Northwind - DWH].[dbo].[STG_DIM_Products]
                                select * from [ODS_Products];""",
        'products_DWH' : """truncate table [Northwind - DWH].[dbo].[DWH_DIM_Products];
                                insert into [Northwind - DWH].[dbo].[DWH_DIM_Products]
                                select * from [STG_DIM_Products];""",
        'Exchange Rate_STG' : """delete from [Northwind - DWH].[dbo].[STG_DIM_Exchange_Rate];
                                    insert into [Northwind - DWH].[dbo].[STG_DIM_Exchange_Rate]
                                    select * from [Northwind - DWH].[dbo].[ODS_Exchange_Rate] where index1 = 'EUR'
                                    ;""",
        'Exchange Rate_DWH' : """delete from [Northwind - DWH].[dbo].[DWH_DIM_Exchange_Rate]
                                    where exists (select 1
                                                from [Northwind - DWH].[dbo].[STG_DIM_Exchange_Rate] s
                                                where s.time_last_update_utc = [Northwind - DWH].[dbo].[DWH_DIM_Exchange_Rate].time_last_update_utc)
                                    ;
                                    insert into [Northwind - DWH].[dbo].[DWH_DIM_Exchange_Rate]
                                    select * from [Northwind - DWH].[dbo].[STG_DIM_Exchange_Rate]
                                    ;""",                            
        'Employee Performance' : """truncate table [Northwind - DWH].[dbo].[DWH_Fact_Employee_Performance];
                                        insert into [Northwind - DWH].[dbo].[DWH_Fact_Employee_Performance]
                                        SELECT 
                                            -- select employee, date, sum sales 
                                            SD.EmployeeID,
                                            SD.EmployeeName,
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
                                                (em.[LastName]+' '+em.[FirstName]) as EmployeeName,
                                                CONVERT(DATE, o.OrderDate) AS OrderDate,
                                                SUM(o.Quantity * o.UnitPrice) AS USDTotalSales,
                                                isnull(SUM(o.Quantity * o.UnitPrice * e.conversion_rates),-1) AS EURTotalSales,
                                                count(distinct ProductID) as UnqCountProducts
                                            FROM [DWH_Fact_Orders] o
                                            LEFT JOIN [DWH_DIM_Exchange_Rate] e 
                                            ON CAST(CONVERT(DATE, TRIM(SUBSTRING([time_last_update_utc],(CHARINDEX(',', [time_last_update_utc])+1),((select len([time_last_update_utc]))-(SELECT CHARINDEX('00', [time_last_update_utc]))))), 113) AS DATE) = CONVERT(DATE, o.OrderDate)
                                            LEFT JOIN [Northwind - DWH].[dbo].[DWH_DIM_Employees] em 
                                            ON em.EmployeeID = o.EmployeeID
                                            GROUP BY 
                                                o.EmployeeID, (em.[LastName]+' '+em.[FirstName]) ,o.OrderDate
                                        ) SD
                                        ;"""
}

# ----------------------------RUN------------------------------

# ETL proccess
ETL(OPR_to_ODS_tables_list_SQL,OPR_to_ODS_tables_list_MySQL,OPR_to_ODS_tables_list_CSV,OPR_to_ODS_tables_list_API,DWH_queries_dict)






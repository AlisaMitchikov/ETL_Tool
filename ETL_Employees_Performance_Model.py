from functions import ETL

# --------------------------------------------------------------- Source & Target Connections ---------------------------------------------------------------

# Source - SQL Server --> {'DRIVER':'{}','SERVER': '', 'DATABASE': '', 'Trusted_Connection': ''}
SQL_server_source_connect_details = {'DRIVER': '{ODBC Driver 17 for SQL Server}',
                                    'SERVER': 'ALISAM-LAPTOP',
                                    'DATABASE': 'Northwind - OPR',
                                    'Trusted_Connection': 'yes'}

# Source - MySQL --> {'host': '', 'user': '', 'password': '', 'database': ''}
MySQL_source_connect_details = {'host': 'localhost', 'user': 'root', 'password': '', 'database': 'northwind - opr'}

# Target - SQL Server --> {'DRIVER':'{}','SERVER': '', 'DATABASE': '', 'Trusted_Connection': ''}
SQL_server_target_connect_details = {'DRIVER': '{ODBC Driver 17 for SQL Server}',
                                    'SERVER': 'ALISAM-LAPTOP',
                                    'DATABASE': 'Northwind - DWH',
                                    'Trusted_Connection': 'yes'}

# ------------------------------------------------------------------------ OPR to ODS ------------------------------------------------------------------------

# OPR SQL Server tables --> {'source_table_1' : query, 'source_table_2' : query, ...} * if not needed, leave empty list
OPR_to_ODS_tables_list_SQL = {'Orders' : """select * from [Orders] 
                                            where cast(OrderDate as date) >= cast((getdate()-5) as date);""",
                              'Order Details' : """select * from [Order Details];""",
                              'Employees'  : """select * from [Employees];"""}

# OPR MySQL tables --> {'source_table_1' : query, 'source_table_2' : query, ...} * if not needed, leave empty list
OPR_to_ODS_tables_list_MySQL = {'products' : """select * from products"""}

# OPR CSV --> {'target_table_1' : 'CSV_path', ...} * if not needed, leave empty dictionary
OPR_to_ODS_tables_list_CSV = {'shippers': r"E:\קריירה\הכנה 2024\פרוייקטים\etl pipeline\app\sources\CSV\shippers.csv"}

# OPR API --> {'target_table_1' : 'API_url', ...} * if not needed, leave empty dictionary
OPR_to_ODS_tables_list_API = {'ODS_Exchange_Rate':r'https://v6.exchangerate-api.com/v6/12566f6fc3a965b80afd4734/latest/USD'}

# --------------------------------------------------------------------- ODS to DWH & DWH ---------------------------------------------------------------------

# ETL queries --> {'query_#1_description' : 'query', 'query_#2_description' : 'query', ...}
DWH_queries_dict = {
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
        'shippers_STG' : """truncate table [Northwind - DWH].[dbo].[STG_DIM_Shippers];
                                insert into [Northwind - DWH].[dbo].[STG_DIM_Shippers]
                                select * from [ODS_Shippers];""",
        'shippers_DWH' : """truncate table [Northwind - DWH].[dbo].[DWH_DIM_Shippers];
                                insert into [Northwind - DWH].[dbo].[DWH_DIM_Shippers]
                                select * from [STG_DIM_Shippers];""",
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

# -------------------------------------------------------------------------- Run ETL --------------------------------------------------------------------------

# ETL proccess
try:
    ETL(SQL_server_source_connect_details,
        MySQL_source_connect_details,
        SQL_server_target_connect_details,
        OPR_to_ODS_tables_list_SQL,
        OPR_to_ODS_tables_list_MySQL,
        OPR_to_ODS_tables_list_CSV,
        OPR_to_ODS_tables_list_API,
        DWH_queries_dict)
except Exception as err:
    print(err)




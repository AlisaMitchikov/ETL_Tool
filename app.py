# from functions import OPR_to_ODS_SQL, DWH, OPR_to_ODS_CSV
from functions import ETL

# --------OPR----------

# OPR SQL Server tables
OPR_to_ODS_tables_list_SQL = ['Customers', 'Orders']

# OPR MySQL tables
OPR_to_ODS_tables_list_MySQL = ['products', 'suppliers']


# OPR CSV
OPR_to_ODS_tables_list_CSV = {'ODS_Region':r"E:\קריירה\הכנה 2024\פרוייקטים\etl pipeline\app\sources\CSV\Region.csv"}

# OPR API
OPR_to_ODS_tables_list_API = {'ODS_Exchange_Rate':r'https://v6.exchangerate-api.com/v6/12566f6fc3a965b80afd4734/latest/USD'}

# --------STG + DWH----------

# ETL queries 
DWH_queries_dict = {
    'truncate STG' : """truncate table [Northwind - DWH].[dbo].[STG_Fact_Customers_KPIs];""",
    'insert into STG' : """insert into [Northwind - DWH].[dbo].[STG_Fact_Customers_KPIs] ([CustomerID],[#_orders])
                           select 
                                c.[CustomerID],
                                count(o.OrderID) as #_orders
                           from [Northwind - DWH].[dbo].[ODS_Customers] c
                           left join [Northwind - DWH].[dbo].[ODS_Orders] o on c.CustomerID = o.CustomerID
                           group by c.[CustomerID]
                           order by #_orders desc""",
    'delete from DWH' : """delete from [Northwind - DWH].[dbo].[DWH_Fact_Customers_KPIs]
                           where exists (select 1
                                         from [Northwind - DWH].[dbo].[STG_Fact_Customers_KPIs] s
                                         where s.[CustomerID] = [Northwind - DWH].[dbo].[DWH_Fact_Customers_KPIs].[CustomerID])
                           ;""",
    'insert into DWH' : """insert into [Northwind - DWH].[dbo].[DWH_Fact_Customers_KPIs] ([CustomerID],[#_orders])
                           select [CustomerID],[#_orders] from [Northwind - DWH].[dbo].[STG_Fact_Customers_KPIs]
                           ;"""

}

# ----------------------------RUN------------------------------

# ETL proccess
ETL(OPR_to_ODS_tables_list_SQL,OPR_to_ODS_tables_list_MySQL,OPR_to_ODS_tables_list_CSV,OPR_to_ODS_tables_list_API,DWH_queries_dict)





# OPR_to_ODS_CSV(OPR_to_ODS_tables_list_CSV)
# OPR_to_ODS_SQL(OPR_to_ODS_tables_list_SQL)
# DWH(DWH_queries_dict)

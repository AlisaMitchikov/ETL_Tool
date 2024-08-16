# from functions import OPR_to_ODS, DWH
from functions import ETL

# specify OPRs table name --> OPR table + it's data will be inserted to it
OPR_to_ODS_tables_list = ['Customers', 'Orders']

# OPR_to_ODS(OPR_to_ODS_tables_list)

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

# DWH(DWH_queries_dict)

ETL(OPR_to_ODS_tables_list,DWH_queries_dict)

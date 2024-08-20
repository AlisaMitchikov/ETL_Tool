from functions import ETL

# --------OPR----------


# OPR SQL Server tables
OPR_to_ODS_tables_list_SQL = ['Orders','Order Details','Employees']

# OPR MySQL tables
OPR_to_ODS_tables_list_MySQL = ['products']

# OPR CSV
OPR_to_ODS_tables_list_CSV = {}

# OPR API
OPR_to_ODS_tables_list_API = {'ODS_Exchange_Rate':r'https://v6.exchangerate-api.com/v6/12566f6fc3a965b80afd4734/latest/USD'}

# --------STG + DWH----------

# ETL queries 
DWH_queries_dict = {

}

# ----------------------------RUN------------------------------

# ETL proccess
ETL(OPR_to_ODS_tables_list_SQL,OPR_to_ODS_tables_list_MySQL,OPR_to_ODS_tables_list_CSV,OPR_to_ODS_tables_list_API,DWH_queries_dict)






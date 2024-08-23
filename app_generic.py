# from functions import OPR_to_ODS_SQL, DWH, OPR_to_ODS_CSV
from functions_generic import ETL

# --------OPR----------

# OPR SQL Server tables
# ['source_table_1', 'source_table_2', ....]
# OPR_to_ODS_tables_list_SQL = ['Customers', 'Orders']
SQL_connect_details = {'DRIVER': '{ODBC Driver 17 for SQL Server}',
                       'SERVER': 'ALISAM-LAPTOP',
                       'DATABASE': 'Northwind - OPR',
                       'Trusted_Connection': 'yes'}
# OPR_to_ODS_tables_list_SQL = ['Customers']
OPR_to_ODS_tables_list_SQL = []



# OPR MySQL tables
# ['source_table_1', 'source_table_2', ....]
# OPR_to_ODS_tables_list_MySQL = ['products', 'suppliers']
OPR_to_ODS_tables_list_MySQL = []

# OPR CSV
# {'target_table_1' : 'CSV_path', ...}
# OPR_to_ODS_tables_list_CSV = {'ODS_Region':r"E:\קריירה\הכנה 2024\פרוייקטים\etl pipeline\app\sources\CSV\Region.csv"}
OPR_to_ODS_tables_list_CSV = {}

# OPR API
# {'target_table_1' : 'API_url', ...}
# OPR_to_ODS_tables_list_API = {'ODS_Exchange_Rate':r'https://v6.exchangerate-api.com/v6/12566f6fc3a965b80afd4734/latest/USD'}
OPR_to_ODS_tables_list_API = {}

# --------STG + DWH----------

# ETL queries 
DWH_queries_dict = {
}

# ----------------------------RUN------------------------------

# ETL proccess
ETL(SQL_connect_details,OPR_to_ODS_tables_list_SQL,OPR_to_ODS_tables_list_MySQL,OPR_to_ODS_tables_list_CSV,OPR_to_ODS_tables_list_API,DWH_queries_dict)





# OPR_to_ODS_CSV(OPR_to_ODS_tables_list_CSV)
# OPR_to_ODS_SQL(OPR_to_ODS_tables_list_SQL)
# DWH(DWH_queries_dict)

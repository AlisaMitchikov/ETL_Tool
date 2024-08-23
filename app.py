# from functions import OPR_to_ODS_SQL, DWH, OPR_to_ODS_CSV
from functions import ETL

# --------OPR----------

# OPR SQL Server tables
# ['source_table_1', 'source_table_2', ....]
OPR_to_ODS_tables_list_SQL = []

# OPR MySQL tables
# ['source_table_1', 'source_table_2', ....]
OPR_to_ODS_tables_list_MySQL = []

# OPR CSV
# {'target_table_1' : 'CSV_path', ...}
OPR_to_ODS_tables_list_CSV = {}

# OPR API
# {'target_table_1' : 'API_url', ...}
OPR_to_ODS_tables_list_API = {}

# --------STG + DWH----------

# ETL queries 
DWH_queries_dict = {

}

# ----------------------------RUN------------------------------

# ETL proccess
ETL(OPR_to_ODS_tables_list_SQL,OPR_to_ODS_tables_list_MySQL,OPR_to_ODS_tables_list_CSV,OPR_to_ODS_tables_list_API,DWH_queries_dict)





# OPR_to_ODS_CSV(OPR_to_ODS_tables_list_CSV)
# OPR_to_ODS_SQL(OPR_to_ODS_tables_list_SQL)
# DWH(DWH_queries_dict)

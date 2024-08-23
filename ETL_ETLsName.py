from functions import ETL

# --------------------------------------------------------------- Source & Target Connections ---------------------------------------------------------------

# Source - SQL Server --> {'DRIVER':'{}','SERVER': '', 'DATABASE': '', 'Trusted_Connection': ''}
SQL_server_source_connect_details = {}

# Source - MySQL --> {'host': '', 'user': '', 'password': '', 'database': ''}
MySQL_source_connect_details = {'host': 'localhost', 'user': 'root', 'password': '', 'database': 'northwind - opr'}

# Target - SQL Server --> {'DRIVER':'{}','SERVER': '', 'DATABASE': '', 'Trusted_Connection': ''}
SQL_server_target_connect_details = {}


# ------------------------------------------------------------------------ OPR to ODS ------------------------------------------------------------------------

# OPR SQL Server tables --> ['source_table_1', 'source_table_2', ....] * if not needed, leave empty list
OPR_to_ODS_tables_list_SQL = []

# OPR MySQL tables --> ['source_table_1', 'source_table_2', ....] * if not needed, leave empty list
OPR_to_ODS_tables_list_MySQL = []

# OPR CSV --> {'target_table_1' : 'CSV_path', ...} * if not needed, leave empty dictionary
OPR_to_ODS_tables_list_CSV = {}

# OPR API --> {'target_table_1' : 'API_url', ...} * if not needed, leave empty dictionary
OPR_to_ODS_tables_list_API = {}

# --------------------------------------------------------------------- ODS to DWH & DWH ---------------------------------------------------------------------

# ETL queries --> {'query_#1_description' : 'query', 'query_#2_description' : 'query', ...}
DWH_queries_dict = {}

# -------------------------------------------------------------------------- Run ETL --------------------------------------------------------------------------

# ETL proccess
ETL(SQL_server_source_connect_details,
    MySQL_source_connect_details,
    SQL_server_target_connect_details,
    OPR_to_ODS_tables_list_SQL,
    OPR_to_ODS_tables_list_MySQL,
    OPR_to_ODS_tables_list_CSV,
    OPR_to_ODS_tables_list_API,
    DWH_queries_dict)



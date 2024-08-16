import pyodbc
import pandas as pd


def OPR_to_ODS_SQL(OPR_to_ODS_tables_list_SQL,source_conn,target_conn):

    # # Create connections to servers
    # source_conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};'
    #                             'SERVER=ALISAM-LAPTOP;'
    #                             'DATABASE=Northwind - OPR;'
    #                             'Trusted_Connection=yes;')

    # target_conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};'
    #                             'SERVER=ALISAM-LAPTOP;'
    #                             'DATABASE=Northwind - DWH;'
    #                             'Trusted_Connection=yes;')    
    
    for item in OPR_to_ODS_tables_list_SQL:

        # Source table
        source_table_name = item 

        # Target table
        target_table_name = 'ODS_'+item

        # create cursor
        cursor = target_conn.cursor()

        # Truncate ODS table
        query = f"truncate table [{target_table_name}]"
        cursor.execute(query)

        # Read tables data from the source database
        query = f"SELECT * FROM [{source_table_name}]"
        data = pd.read_sql(query, source_conn)

        # Write data to the target database
        for index, row in data.iterrows():
            cursor.execute(
                f"INSERT INTO {target_table_name} ({', '.join(data.columns)}) VALUES ({', '.join(['?' for _ in data.columns])})",
                tuple(row)
            )
        
        # Save changes
        target_conn.commit()

    # # Close connections
    # source_conn.close()
    # target_conn.close()        



def DWH(DWH_queries_dict,target_conn):

    # # Create connections to servers
    # target_conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};'
    #                             'SERVER=ALISAM-LAPTOP;'
    #                             'DATABASE=Northwind - DWH;'
    #                             'Trusted_Connection=yes;')   

    for key,value in DWH_queries_dict.items(): 

        # create cursor
        cursor = target_conn.cursor()        

        # Specify query
        query = value

        # Execeute query
        cursor.execute(query)

        # Save changes
        target_conn.commit()

    # # Close connections
    # target_conn.close()        



def ETL(OPR_to_ODS_tables_list_SQL,DWH_queries_dict):

    # Create connections to servers
    source_conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};'
                                'SERVER=ALISAM-LAPTOP;'
                                'DATABASE=Northwind - OPR;'
                                'Trusted_Connection=yes;')

    target_conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};'
                                'SERVER=ALISAM-LAPTOP;'
                                'DATABASE=Northwind - DWH;'
                                'Trusted_Connection=yes;')   
    
    OPR_to_ODS_SQL(OPR_to_ODS_tables_list_SQL,source_conn,target_conn)

    DWH(DWH_queries_dict,target_conn)

    # Close connections
    source_conn.close()
    target_conn.close()             



def OPR_to_ODS_CSV(OPR_to_ODS_tables_list_CSV):
    
    for item in OPR_to_ODS_tables_list_CSV:
        file_path = item
        df = pd.read_csv(file_path)
        print(df) 

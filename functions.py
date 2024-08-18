import pyodbc
import pandas as pd
import requests

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


def OPR_to_ODS_CSV(OPR_to_ODS_tables_list_CSV,target_conn):

    for key,value in OPR_to_ODS_tables_list_CSV.items():
        
        file_path = value
        df = pd.read_csv(file_path)
    
        # create cursor
        cursor = target_conn.cursor()        

        # Truncate ODS table
        query = f"truncate table [{key}]"
        cursor.execute(query)

        # Write data to the target database
        for index, row in df.iterrows():
            cursor.execute(
                f"INSERT INTO {key} ({', '.join(df.columns)}) VALUES ({', '.join(['?' for _ in df.columns])})",
                tuple(row)
            )
        
        target_conn.commit()


def OPR_to_ODS_API(OPR_to_ODS_tables_list_API,target_conn):

    for key,value in OPR_to_ODS_tables_list_API.items():

        response = requests.get(value)
        data = response.json()
        df = pd.DataFrame(data)
        df['index1'] = df.index

    # create cursor
    cursor = target_conn.cursor()        

    # Write data to the target database
    for index, row in df.iterrows():
        cursor.execute(
            f"INSERT INTO ODS_Exchange_Rate ({', '.join(df.columns)}) VALUES ({', '.join(['?' for _ in df.columns])})",
            tuple(row)
        )

    target_conn.commit()


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

# ---------------------------------------------------------------------------------

def ETL(OPR_to_ODS_tables_list_SQL,OPR_to_ODS_tables_list_CSV,OPR_to_ODS_tables_list_API,DWH_queries_dict):

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

    OPR_to_ODS_CSV(OPR_to_ODS_tables_list_CSV,target_conn)

    OPR_to_ODS_API(OPR_to_ODS_tables_list_API,target_conn)

    DWH(DWH_queries_dict,target_conn)

    # Close connections
    source_conn.close()
    target_conn.close()             




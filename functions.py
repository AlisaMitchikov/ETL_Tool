import pyodbc
import mysql.connector
import pandas as pd
import requests
import warnings


def OPR_to_ODS_SQL(OPR_to_ODS_tables_list_SQL,SQL_source_conn,target_conn):

    for key,value in OPR_to_ODS_tables_list_SQL.items():

        try:
                # Source table
                source_table_name = key 

                # Target table
                target_table_name = 'ODS_'+key

                # create cursor
                cursor = target_conn.cursor()

                # Truncate ODS table
                query = f"truncate table [{target_table_name}]"
                cursor.execute(query)

                # Read tables data from the source database
                query = value
                data = pd.read_sql(query, SQL_source_conn)
                for col in data:
                    if data[col].dtype.name == 'float64':
                        data[col] = data[col].fillna(-1) 

                # Write data to the target database
                for index, row in data.iterrows():
                    row.replace("",0)
                    cursor.execute(
                        f"INSERT INTO [{target_table_name}] ({', '.join(data.columns)}) VALUES ({', '.join(['?' for _ in data.columns])})",
                        tuple(row)
                    )
                
                # Save changes
                target_conn.commit()   

        except Exception as e:
            print(f"Error processing table {key}: {e}")
            target_conn.rollback() 
            return False  # Indicate failure
    return True  # Indicate success                   


def OPR_to_ODS_MySQL(OPR_to_ODS_tables_list_MySQL,MySQL_source_con,target_conn):
 
    for key,value in OPR_to_ODS_tables_list_MySQL.items():

        try:

            # Source table
            source_table_name = key 

            # Target table
            target_table_name = 'ODS_'+key

            # create cursor
            cursor = target_conn.cursor()

            # Truncate ODS table
            query = f"truncate table [{target_table_name}]"
            cursor.execute(query)

            # Read tables data from the source database
            query = value
            data = pd.read_sql(query, MySQL_source_con)

            # Write data to the target database
            for index, row in data.iterrows():
                cursor.execute(
                    f"INSERT INTO {target_table_name} ({', '.join(data.columns)}) VALUES ({', '.join(['?' for _ in data.columns])})",
                    tuple(row)
                )
            
            # Save changes
            target_conn.commit()  

        except Exception as e:
            print(f"Error processing table {key}: {e}")
            target_conn.rollback()
            return False  # Indicate failure
    return True  # Indicate success                      


def OPR_to_ODS_CSV(OPR_to_ODS_tables_list_CSV,target_conn):

    for key,value in OPR_to_ODS_tables_list_CSV.items():

        try:
        
            file_path = value
            df = pd.read_csv(file_path)

            # Target table
            target_table_name = 'ODS_'+ key            
        
            # create cursor
            cursor = target_conn.cursor()        

            # Truncate ODS table
            query = f"truncate table [{target_table_name}]"
            cursor.execute(query)

            # Write data to the target database
            for index, row in df.iterrows():
                cursor.execute(
                    f"INSERT INTO {target_table_name} ({', '.join(df.columns)}) VALUES ({', '.join(['?' for _ in df.columns])})",
                    tuple(row)
                )
            
            target_conn.commit()

        except Exception as e:
            print(f"Error processing CSV file {file_path}: {e}")
            target_conn.rollback()
            return False  # Indicate failure
    return True  # Indicate success     


def OPR_to_ODS_API(OPR_to_ODS_tables_list_API,target_conn):

    for key,value in OPR_to_ODS_tables_list_API.items():

        try:

            response = requests.get(value)
            data = response.json()
            df = pd.DataFrame(data)
            df['index1'] = df.index

            # create cursor
            cursor = target_conn.cursor()        

            # Truncate ODS table
            query = f"truncate table [{key}]"
            cursor.execute(query)    

            # Write data to the target database
            for index, row in df.iterrows():
                cursor.execute(
                    f"INSERT INTO ODS_Exchange_Rate ({', '.join(df.columns)}) VALUES ({', '.join(['?' for _ in df.columns])})",
                    tuple(row)
                )

            target_conn.commit()

        except requests.RequestException as e:
            print(f"Error fetching data from API {value}: {e}")
            return False  # Indicate failure
        except Exception as e:
            print(f"Error processing API data for {key}: {e}")
            target_conn.rollback() 
            return False  # Indicate failure     
    return True  # Indicate success           


def DWH(DWH_queries_dict,target_conn): 

    for key,value in DWH_queries_dict.items(): 
        
        try:

            # create cursor
            cursor = target_conn.cursor()        

            # Specify query
            query = value

            # Execeute query
            cursor.execute(query)

            # Save changes
            target_conn.commit()

        except Exception as e:
            print(f"Error performing queries : {e}")
            target_conn.rollback() 
            return False  # Indicate failure
    return True  # Indicate success                

# ---------------------------------------------------------------------------------

def ETL(SQL_server_source_connect_details,
        MySQL_source_connect_details,
        SQL_server_target_connect_details,
        OPR_to_ODS_tables_list_SQL,
        OPR_to_ODS_tables_list_MySQL,
        OPR_to_ODS_tables_list_CSV,
        OPR_to_ODS_tables_list_API,
        DWH_queries_dict):
    try:
        SQL_source_conn = pyodbc.connect(f'DRIVER={SQL_server_source_connect_details['DRIVER']};'
                                    f'SERVER={SQL_server_source_connect_details['SERVER']};'
                                    f'DATABASE={SQL_server_source_connect_details['DATABASE']};'
                                    f'Trusted_Connection={SQL_server_source_connect_details['Trusted_Connection']};')
    except Exception as e:
        print(f"Error connecting to SQL Server source: {e}")
        return        
        
    try:        
        MySQL_source_con = mysql.connector.connect(host=MySQL_source_connect_details["host"],
                                            user=MySQL_source_connect_details["user"],
                                            password=MySQL_source_connect_details["password"],
                                            database=MySQL_source_connect_details["database"])    
    except Exception as e:
        print(f"Error connecting to MySQL source: {e}")
        return        

    try: 
        target_conn = pyodbc.connect(f'DRIVER={SQL_server_target_connect_details['DRIVER']};'
                                    f'SERVER={SQL_server_target_connect_details['SERVER']};'
                                    f'DATABASE={SQL_server_target_connect_details['DATABASE']};'
                                    f'Trusted_Connection={SQL_server_target_connect_details['Trusted_Connection']};')
    except Exception as e:
        print(f"Error connecting to SQL Server target: {e}")
        return
    
    try:
            
        if len(OPR_to_ODS_tables_list_SQL) > 0:
            print('Connecting to SQL Server source and importing tables to SQL Server target ...')
            if not OPR_to_ODS_SQL(OPR_to_ODS_tables_list_SQL,SQL_source_conn,target_conn):
                return

        if len(OPR_to_ODS_tables_list_MySQL) > 0:
            print('Connecting to MySQL Server source and importing tables to SQL Server target ...')
            if not OPR_to_ODS_MySQL(OPR_to_ODS_tables_list_MySQL,MySQL_source_con,target_conn):
                return

        if len(OPR_to_ODS_tables_list_CSV) > 0:
            print('Reading from CSV file and importing data to SQL Server target ...')
            if not OPR_to_ODS_CSV(OPR_to_ODS_tables_list_CSV,target_conn):
                return  # Exit if there was an error

        if len(OPR_to_ODS_tables_list_API) > 0:
            print('Calling API and importing data to SQL Server target ...')
            if not OPR_to_ODS_API(OPR_to_ODS_tables_list_API,target_conn):
                return

        if len(DWH_queries_dict) > 0:
            print('Performiong queries on DWH ...')
            if not DWH(DWH_queries_dict,target_conn):
                return

    except Exception as e:
        print(f"Error importing data to data warehouse : {e}")
        return            
    
    finally:
        # Close connections
        SQL_source_conn.close()
        MySQL_source_con.close()
        target_conn.close()

    print('Process finished successfully !')             

warnings.filterwarnings("ignore", category=UserWarning, message='.*pandas only supports SQLAlchemy connectable.*')

import requests
import pandas as pd
import pyodbc


response = requests.get('https://v6.exchangerate-api.com/v6/12566f6fc3a965b80afd4734/latest/USD')
data = response.json()
# print(data)

df = pd.DataFrame(data)
df['index1'] = df.index

# df = df.loc['EUR']
# df = df[['time_last_update_utc','base_code','conversion_rates']]
# df = df.rename({'conversion_rates':'EUR_conversion_rate'})
# print(df)


target_conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};'
                            'SERVER=ALISAM-LAPTOP;'
                            'DATABASE=Northwind - DWH;'
                            'Trusted_Connection=yes;')   

# create cursor
cursor = target_conn.cursor()        

# Write data to the target database
for index, row in df.iterrows():
    cursor.execute(
        f"INSERT INTO ODS_Exchange_Rate ({', '.join(df.columns)}) VALUES ({', '.join(['?' for _ in df.columns])})",
        tuple(row)
    )

target_conn.commit()


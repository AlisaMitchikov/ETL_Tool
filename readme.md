#                                        ETL Tool

## What does the tool do ?
This ETL tool written in Python is designed to run an ETL pipline :
1. It imports data from multiple sources, 
including SQL Server, MySQL, CSV files, and JSON data from APIs, 
into a SQL Server data warehouse. 
2. Once the data is imported, 
the tool allows you to run SQL queries sequentially on the data in a specified order, 
enabling the creation of the objects in the data warehouse.

## How it works ?
To set up your ETL process, start by configuring the `ETL_ETLs_name.py file`. 
In this file, you'll define the tables and data sources to import and specify the SQL queries that will be executed.
Essentially, this file represents the entire ETL workflow.
Before making any changes, create a copy of `ETL_ETLs_name.py` and rename it to match your specific ETL task 
(replace 'ETLsName' with your ETL's name).

After configuring the file, install the necessary dependencies listed in requirements.txt. 
Then, run your customized script to ensure the ETL pipeline functions as expected. 

If everything works smoothly, you can deploy the repository and orchestrate the tool's execution.

## Example
To help you better understand the tool, 
I've created an example ETL in the `Employees_Performance_Model.py` file. 
This ETL is designed to work with the [Northwind database](https://github.com/cjlee/northwind/blob/master/northwind.sql.zip). 
It imports data from multiple sources: SQL Server, MySQL, and a JSON API. 
After importing the data, it performs SQL queries on it.

## Note
For your convenience, you can store your queries in the SQL Queries directory, 
organized under your ETL’s name.

Go and work your magic ! 🪄

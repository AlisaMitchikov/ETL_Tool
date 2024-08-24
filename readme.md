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

After configuring the file, install the necessary dependencies listed in `requirements.txt`. 
Then, run your customized file (`ETL_ETLs_name.py`) to ensure the ETL pipeline functions as expected. 

If everything works smoothly, you can orchestrate the tool's execution.
In the orchestration platform, configure to run `app.py` file which executes all ETL files in the tool
(as per now you have only one ETL file that runs one ETL pipeline, but you may need to create additonal pipelines).

Once everything is running smoothly, you can move on to orchestrating the tool's execution. 
In your orchestration platform, configure it to run the `app.py` file. 
This file manages the execution of all ETL scripts within the tool.

Even if you currently have only one ETL script for a single pipeline, this setup is designed to easily accommodate additional pipelines.
The `app.py` file offers two execution options:
- Execute all pipelines: automatically runs all ETL scripts located in the current directory without specifying individual files or execution order.
- Execute specific pipelines: allows you to specify and execute particular ETL pipelines in a defined order.

## Example ETL Process
To help you better understand the tool, 
I've created an example ETL in the `Employees_Performance_Model.py` file. 
This ETL is designed to work with the [Northwind database](https://github.com/cjlee/northwind/blob/master/northwind.sql.zip).

### Overview
This ETL process extracts data from multiple sources, including SQL Server, MySQL, and a JSON API. 
Once the data is imported, the pipeline executes a series of SQL queries to transform and load the data into the target data warehouse.

Sources: 
- SQL Server : Orders, Order Details, Employees
- MySQL : products
- CSV : shippers
- API : Exchange Rate

Target:
- DWH_DIM_Employees
- DWH_DIM_Products
- DHW_DIM_Exchange_Rate
- DWH_DIM_Shippers
- DWH_Fact_Orders
- DWH_Fact_Employee_Performance

## Note
For your convenience, you can store your queries in the SQL Queries directory, 
organized under your ETL’s name.

Go and work your magic ! 🪄

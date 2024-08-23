#                                        ETL Tool

## What does the tool do ?
This ETL tool is designed to import data from multiple sources, 
including SQL Server, MySQL, CSV files, and JSON data from APIs, 
into a SQL Server data warehouse. 
Once the data is imported, 
the tool allows you to run SQL queries sequentially on the data in a specified order, 
facilitating the creation of your ETL processes.

## How it works ?
The `functions.py` file is where all the magic is stored. 
This file contains the code for importing data from the specified sources 
and running the SQL queries. 

To make this magic work, you'll need to configure the `app.py file`.
In `app.py`, you'll specify the tables and sources for data import 
and define the SQL queries to be executed. 
Essentially, the `app.py` file represents the entire ETL process. 
Before you start, make a copy of it and rename it to reflect your specific ETL.

Once you've configured `app.py`, install the necessary libraries as listed in the `requirements.txt` file, 
and simply run your file.

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

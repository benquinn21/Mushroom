Mushroom Field Research Deployment Guide v1.0

*****Assumptions and Considerations*****

1. Attribute Mapping

	The attribute mapping provided in the technical test specification appeared not to map directly to the field numbers within the sample data e.g. [1] looks to be the 		edibility of the mushroom and not the cap shape.

	Therefore using the attribute mapping provided in conjunction with the information provided from the UCI Machine Learning Repository 						(https://archive.ics.uci.edu/ml/datasets/mushroom) I have mapped the numbered fields in the sample data to the below field names: 

	Edibility					[1]	
	Cap Surface					[3]	
	Bruises						[5]	
	Grill Spacing					[8]	
	Grill Size					[9]	
	Stalk Surface Below Ring			[14]	
	Veil Colour					[17]	
	Ring Type					[19]	
	Grill Colour					[20]	
	Population					[21]	
	Habitat						[22]	

	This affects query 2 of the analysis phase, correlating cap-colour and habitat. For this query, I have instead used grill colour and habitat. 

	In addition too this, query 3 of the analysis phase, idetfying colours within 10km of a given point, does not specify a particular colour attribute e.g. grill or veil. 	Therefore, I have used both. 

2. ETL and "Model" Database set-up

	Typically the approach I would take for data ingestion and movement to the relational database model would be a two database set-up. Once for the ETL, where data is 		ingested and cleansed, the second to house the relational model, any additional manual data and reporting objects. 

3. Data Frequency

	The assumption is that the data load frequency is monthly. Therefore, the solution is designed to clear down and re-populate the relational model based on the given 		year-month being run, which is taken through the use of the GETDATE(), YEAR() and MONTH() functions. 

	For the purpose of simplicity, I have used a one database set-up for this task, housing both the ETL and relational model. 

*****Prerequisite Tasks*****

Prior to running the deployment scripts in section, "Deployment", the following items need to be addressed: 

 a. Permissions 
	The correct permissions are required for the ability to create a database or any database objects. Please speak to your server admin to grant access, or alternatively, 	work with a colleague who has the appropriate permissions. 

 b. SQL Server Machine Learning Services/Advanced Analytics add-on
	To be able to run query 2 of the analysis phase, SQL Server Machine Learning Services will need to be installed and external scripts activated.
	
i. As an initial check to see if this is already in place, please run:
		
		EXECUTE sp configure  'external scripts enabled'
		
If the run value is set to 1, then the ability to run external scripts is activated. 

ii. If it's not set to 1, please run the below query to attempt to activate external scripts:

		EXEC sp configure  'external scripts enabled', 1
		RECONFIGURE WITH OVERRIDE
		
iii. If the above query in (ii) comes back with error stating that SQL Server Machine Learning Services/Advanced Analytics is not installed then 				please work with your server admin to install the correct package. Steps on how to do this can be found follow the below URL:	#

https://docs.microsoft.com/en-us/sql/machine-learning/install/sql-machine-learning-services-windows-install?view=sql-server-ver15
		
**Note, the ability to run queries in i and ii maybe denied due to permissions. 
	
*****Deployment*****

Please run the deployment scripts in the order below. Note, all scripts will need to be run through a data studio/interface. The preference on this is SSMS, as Azure data studio still has some limitations which may cause unwanted issues in the deployment.  

Please read any notes for a given step before executing. 

**1. Database and Object Creation: All scripts for this section can be found in the "DB" folder**

a. 1 MUSH Create Database 20201118

Notes:

i. To successfully create the database, the file location to store the primary and log needs to be inserted, as show below. I have left a sample paths in the script. 		However, please ensure there are changed based on preference of location storage. 

	CREATE DATABASE [DEV_MUSHROOM]
	 CONTAINMENT = NONE
	 ON  PRIMARY 
	( NAME = N'DEV_MUSHROOM', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\DEV_MUSHROOM.mdf' , SIZE = 139264KB , MAXSIZE UNLIMITED, FILEGROWTH = 65536KB )
	 LOG ON 
	( NAME = N'DEV_MUSHROOM_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\DEV_MUSHROOM_log.ldf' , SIZE = 139264KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
	 WITH CATALOG_COLLATION = DATABASE_DEFAULT
	GO

ii. This may be optional depending on your environment processes. If databases are created through the server admin, he/she/they may want to create the database using the wizard functionality. If this is the case, please ensure the name of the database is "DEV MUSHROOM" and all default settings are used. 

b. 2 MUSH Create Model Objects 20201118

Notes: 

i. This script creates the relational model objects and reporting data-mart. For context, all model objects (tables) are prefixed with "MOD " and reporting data-marts 
with "DM ". The rationale for the data-mart table is to provide a user friendly dataset for the field team to interact with. Removing the need for joins and 
transpositions. This also allows easier data loads/connections with reporting tools such as PowerBI. Both the Model and Data-Mart tables are populated as part of the ETL.


c. 3 MUSH Create ETL Procedures 20201118

Notes:

i. This script will create all the ETL procedures that will then be invoked in the section 2. 
		
		
**2. 	ETL: All scripts and data for this section can be found in the "ETL" folder**

a. MUSH ETL Run 20201118

Notes: 

i. The procedure within MUSH ETL Run 20201118 requires two parameter inputs in the following order:

a. The file location of the field research records

b. The file location of the attribute mappings.	
	****This file is provided in the "ETL" folder named "Mushroom Attributes 20201118.csv"****

I have left in examples of how the parameters inputs should look. Note, please ensure single quotations are used for each parameter input.

	USE [DEV MUSHROOM]

	DECLARE	@return value int

	EXEC	@return value = [dbo].[ETL 00 ETL Start] 'C:\Sensyne Health\Assignment Senior Data Engn- agaricus-lepiota - send.csv', 'C:\Mushroom Attributes 				2020118.csv'

	SELECT	'Return Value' = @return value

A successful run will return a value of 1

Troubleshooting: 

In the event of errors in the load, identified by a -1 return code, there are two options to identify the error:

1. In the query execution results, go to messages and there will be a validation query that can be copied and ran showing to show errors in the load. 

2. The ETL Log (ETL LOG) can be queried directly to identify errors. Please use the below query: 

		SELECT * 
		FROM ETL_LOG 
		WHERE EL_FLAG_ERROR = 1 
		AND EL_STEP_NAME NOT LIKE '%START%'
		AND EL_START_TIME >= **INPUT START TIME HERE E.G. '2020-11-18 09:00'**
		ORDER BY EL_START_TIME DESC
	
**3. Analysis: All scripts for this section can be found in the "SQL" folder**

a. MUSH SQL Queries 20201118

Notes:

i. Queries are separated by commented lines that include the question from the technical test specification
ii. For the final query idetfying colours within 10km of a given point. The latitude and logitude need to be given in as shown below. Please leave the last input as 			4326.

	DECLARE 
	@GEOGRAHICAL POINT GEOGRAPHY =  geography::Point(-85.6114000(LATITUDE) ,-43.1872000(LOGITUDE), 4326)


*****Improvements*****
Hypothetically if there were to be further iterations of this solution, below would be some improvements to be made: 
1. Move to a two-database set-up
2. Tighten up on datatypes
3. Re-design ETL logging to make use of procedures and variables 
4. Build out a scalar function that allows for easier calculation of correlation only needing the input of the attribute names
5. Add in additional NULL Handling where needed
5. Look to build out a PowerBI report that has a direct feed to the solution either using the DataMart, a tabular model or, OLAP cube. This allows the field team to access the results anytime-anywhere without further work (naturally this will be dependent on PowerBI pro licencing)

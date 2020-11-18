USE [DEV_MUSHROOM]

DECLARE	@return_value  int

EXEC	@return_value = [dbo].[ETL_00_Start] 'C:\Sensyne Health\Assignment Senior Data Engn- agaricuslepiota - send.csv', 'C:\Mushroom Attributes 2020118.csv'

SELECT	'Return Value' = @return_value 


--Troubleshooting: 
--In the event of errors in the load, identified by a -1 return code, there are two options to identify the error:
	
	--1. In the query execution results, go to messages and there will be a validation query that can be copied and ran TO show in the errors in the load. 
	
	--2. The ETL Log (ETL LOG) can be queried directly to identify errors. Please use the below query: 
	
	--SELECT * 
	--FROM ETL_LOG 
	--WHERE EL_FLAG_ERROR = 1 
	--AND EL_STEP_NAME NOT LIKE '%START%'
	--AND EL_START_TIME >= **INPUT START TIME HERE E.G. '2020-11-18 09:00'**
	--ORDER BY EL_START_TIME DESC

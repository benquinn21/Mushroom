USE [DEV_MUSHROOM]
GO

/****** Object:  StoredProcedure [dbo].[ETL_00_Start]    Script Date: 18/11/2020 09:15:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







-- Author:	Ben Quinn
-- Description:	Executes procuedures with the ETL process

CREATE PROCEDURE [dbo].[ETL_00_Start] @Record_File_Path VARCHAR(255), @Attribute_File_Path VARCHAR(255)
as

SET NOCOUNT ON

DECLARE		@Start_Time			DATETIME,
			@Step_Name			VARCHAR(1000),
			@Step_Description	VARCHAR(1000),
			@Flag_Error			BIT = 0,
			@Return_Code		INT

--/////////////////
SET @Start_Time = GETDATE()
SET @Step_Name = 'Procedure: ' + OBJECT_NAME(@@PROCID) + '  ,  ' + 'Step:  Execute [ETL_01_Drop_Tables]'


EXEC @Return_Code = [dbo].[ETL_01_Drop_Tables]

IF @Return_Code = 1
	BEGIN
		INSERT INTO ETL_LOG
		(EL_Start_Time, EL_Step_Name, EL_Flag_Error, EL_End_Time, EL_Error_Message)
		SELECT @Start_Time, @Step_Name, @flag_Error, GETDATE(), 'No Error'
	END
ELSE 
	BEGIN
		SET @flag_Error = 1
		INSERT INTO ETL_LOG
		(EL_Start_Time, EL_Step_Name, EL_Flag_Error, EL_End_Time, EL_Error_Message)
		SELECT @Start_Time, @Step_Name, @flag_Error, GETDATE()
		, 'SELECT * FROM ETL_LOG WHERE EL_Step_Name NOT LIKE ''START%'' AND EL_FLAG_ERROR = 1 AND EL_STEP_NAME LIKE ''%ETL_01_Drop_Tables%'' 
		AND EL_START_TIME >= ''' + CAST(@Start_Time AS VARCHAR(MAX)) + ''''

		PRINT 'SELECT * FROM ETL_LOG WHERE EL_Step_Name NOT LIKE ''%START%'' AND EL_FLAG_ERROR = 1 AND EL_STEP_NAME LIKE ''%ETL_01_Drop_Tables%'' AND EL_START_TIME >= ''' + CAST(@Start_Time AS VARCHAR(MAX)) + ''''
		RETURN	-1
	END

--/////////////////
SET @Start_Time = GETDATE()
SET @Step_Name = 'Procedure: ' + OBJECT_NAME(@@PROCID) + '  ,  ' + 'Step:  Execute [ETL_02_Create_Tables]'

EXEC @Return_Code = [dbo].[ETL_02_Create_Tables]

IF @Return_Code = 1
	BEGIN
		INSERT INTO ETL_LOG
		(EL_Start_Time, EL_Step_Name, EL_Flag_Error, EL_End_Time, EL_Error_Message)
		SELECT @Start_Time, @Step_Name, @flag_Error, GETDATE(), 'No Error'
	END
ELSE 
	BEGIN
		SET @flag_Error = 1
		INSERT INTO ETL_LOG
		(EL_Start_Time, EL_Step_Name, EL_Flag_Error, EL_End_Time, EL_Error_Message)
		SELECT @Start_Time, @Step_Name, @flag_Error, GETDATE()
		, 'SELECT * FROM ETL_LOG WHERE EL_Step_Name NOT LIKE ''START%'' AND EL_FLAG_ERROR = 1 AND EL_STEP_NAME LIKE ''%ETL_02_Create_Tables%'' 
		AND EL_START_TIME >= ''' + CAST(@Start_Time AS VARCHAR(MAX)) + ''''

		PRINT 'SELECT * FROM ETL_LOG WHERE EL_Step_Name NOT LIKE ''%START%'' AND EL_FLAG_ERROR = 1 AND EL_STEP_NAME LIKE ''%ETL_02_Create_Tables%'' AND EL_START_TIME >= ''' + CAST(@Start_Time AS VARCHAR(MAX)) + ''''

		RETURN	-1
	END

--/////////////////
SET @Start_Time = GETDATE()
SET @Step_Name = 'Procedure: ' + OBJECT_NAME(@@PROCID) + '  ,  ' + 'Step:  Execute [ETL_03_Insert_Into_EXT]' 

EXEC @Return_Code = [dbo].[ETL_03_Insert_Into_EXT]  @Record_File_Path, @Attribute_File_Path

IF @Return_Code = 1
	BEGIN
		INSERT INTO ETL_LOG
		(EL_Start_Time, EL_Step_Name, EL_Flag_Error, EL_End_Time, EL_Error_Message)
		SELECT @Start_Time, @Step_Name, @flag_Error, GETDATE(), 'No Error'
	END
ELSE 
	BEGIN
		SET @flag_Error = 1
		INSERT INTO ETL_LOG
		(EL_Start_Time, EL_Step_Name, EL_Flag_Error, EL_End_Time, EL_Error_Message)
		SELECT @Start_Time, @Step_Name, @flag_Error, GETDATE()
		, 'SELECT * FROM ETL_LOG WHERE EL_Step_Name NOT LIKE ''START%'' AND EL_FLAG_ERROR = 1 AND EL_STEP_NAME LIKE ''%ETL_03_Insert_Into_EXT%'' 
		AND EL_START_TIME >= ''' + CAST(@Start_Time AS VARCHAR(MAX)) + ''''

		PRINT 'SELECT * FROM ETL_LOG WHERE EL_Step_Name NOT LIKE ''%START%'' AND EL_FLAG_ERROR = 1 AND EL_STEP_NAME LIKE ''%ETL_03_Insert_Into_EXT%'' AND EL_START_TIME >= ''' + CAST(@Start_Time AS VARCHAR(MAX)) + ''''

		RETURN	-1
	END

--/////////////////
SET @Start_Time = GETDATE()
SET @Step_Name = 'Procedure: ' + OBJECT_NAME(@@PROCID) + '  ,  ' + 'Step:  Execute [ETL_04_EXT_To_WIP]'

EXEC @Return_Code = [dbo].[ETL_04_EXT_To_WIP]

IF @Return_Code = 1
	BEGIN
		INSERT INTO ETL_LOG
		(EL_Start_Time, EL_Step_Name, EL_Flag_Error, EL_End_Time, EL_Error_Message)
		SELECT @Start_Time, @Step_Name, @flag_Error, GETDATE(), 'No Error'
	END
ELSE 
	BEGIN
		SET @flag_Error = 1
		INSERT INTO ETL_LOG
		(EL_Start_Time, EL_Step_Name, EL_Flag_Error, EL_End_Time, EL_Error_Message)
		SELECT @Start_Time, @Step_Name, @flag_Error, GETDATE()
		, 'SELECT * FROM ETL_LOG WHERE EL_Step_Name NOT LIKE ''START%'' AND EL_FLAG_ERROR = 1 AND EL_STEP_NAME LIKE ''%ETL_04_EXT_To_WIP%'' 
		AND EL_START_TIME >= ''' + CAST(@Start_Time AS VARCHAR(MAX)) + ''''

		PRINT 'SELECT * FROM ETL_LOG WHERE EL_Step_Name NOT LIKE ''%START%'' AND EL_FLAG_ERROR = 1 AND EL_STEP_NAME LIKE ''%ETL_04_EXT_To_WIP%'' AND EL_START_TIME >= ''' + CAST(@Start_Time AS VARCHAR(MAX)) + ''''

		RETURN	-1
	END

--/////////////////
SET @Start_Time = GETDATE()
SET @Step_Name = 'Procedure: ' + OBJECT_NAME(@@PROCID) + '  ,  ' + 'Step:  Execute [ETL_05_WIP_to_MOD]'

EXEC @Return_Code = [dbo].[ETL_05_WIP_to_MOD]

IF @Return_Code = 1
	BEGIN
		INSERT INTO ETL_LOG
		(EL_Start_Time, EL_Step_Name, EL_Flag_Error, EL_End_Time, EL_Error_Message)
		SELECT @Start_Time, @Step_Name, @flag_Error, GETDATE(), 'No Error'
	END
ELSE 
	BEGIN
		SET @flag_Error = 1
		INSERT INTO ETL_LOG
		(EL_Start_Time, EL_Step_Name, EL_Flag_Error, EL_End_Time, EL_Error_Message)
		SELECT @Start_Time, @Step_Name, @flag_Error, GETDATE()
		, 'SELECT * FROM ETL_LOG WHERE EL_Step_Name NOT LIKE ''START%'' AND EL_FLAG_ERROR = 1 AND EL_STEP_NAME LIKE ''%ETL_05_WIP_to_MOD%'' 
		AND EL_START_TIME >= ''' + CAST(@Start_Time AS VARCHAR(MAX)) + ''''

		PRINT 'SELECT * FROM ETL_LOG WHERE EL_Step_Name NOT LIKE ''%START%'' AND EL_FLAG_ERROR = 1 AND EL_STEP_NAME LIKE ''%ETL_05_WIP_to_MOD%'' AND EL_START_TIME >= ''' + CAST(@Start_Time AS VARCHAR(MAX)) + ''''

		RETURN	-1
	END

--/////////////////
SET @Start_Time = GETDATE()
SET @Step_Name = 'Procedure: ' + OBJECT_NAME(@@PROCID) + '  ,  ' + 'Step:  Execute [ETL_06_MOD_to_DM]'

EXEC @Return_Code = [dbo].[ETL_06_MOD_to_DM]

IF @Return_Code = 1
	BEGIN
		INSERT INTO ETL_LOG
		(EL_Start_Time, EL_Step_Name, EL_Flag_Error, EL_End_Time, EL_Error_Message)
		SELECT @Start_Time, @Step_Name, @flag_Error, GETDATE(), 'No Error'
	END
ELSE 
	BEGIN
		SET @flag_Error = 1
		INSERT INTO ETL_LOG
		(EL_Start_Time, EL_Step_Name, EL_Flag_Error, EL_End_Time, EL_Error_Message)
		SELECT @Start_Time, @Step_Name, @flag_Error, GETDATE()
		, 'SELECT * FROM ETL_LOG WHERE EL_Step_Name NOT LIKE ''START%'' AND EL_FLAG_ERROR = 1 AND EL_STEP_NAME LIKE ''%ETL_06_MOD_to_DM%'' 
		AND EL_START_TIME >= ''' + CAST(@Start_Time AS VARCHAR(MAX)) + ''''

		PRINT 'SELECT * FROM ETL_LOG WHERE EL_Step_Name NOT LIKE ''%START%'' AND EL_FLAG_ERROR = 1 AND EL_STEP_NAME LIKE ''%ETL_06_MOD_to_DM%'' AND EL_START_TIME >= ''' + CAST(@Start_Time AS VARCHAR(MAX)) + ''''

		RETURN	-1
	END

RETURN 1
GO

/****** Object:  StoredProcedure [dbo].[ETL_01_Drop_Tables]    Script Date: 18/11/2020 09:15:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






-- Author:	Ben Quinn
-- Description:	Drops EXT and WIP tables

CREATE PROCEDURE [dbo].[ETL_01_Drop_Tables]
as

SET NOCOUNT ON

DECLARE		 @Start_Time			DATETIME
			,@Step_Name				VARCHAR(1000)
			,@SQL					VARCHAR(MAX)
			,@Flag_Error			BIT = 0


--/////////////////
SET @Start_Time = GETDATE()
SET @Step_Name = 'Procedure: ' + OBJECT_NAME(@@PROCID) + '  ,  ' + 'Step:  Drop EXT Tables'

IF (SELECT COUNT(*) FROM SYS.TABLES WHERE NAME LIKE 'EXT%') > 0
BEGIN
	BEGIN TRY 

		SELECT @SQL = STRING_AGG('DROP TABLE ' + NAME, ' ') FROM SYS.TABLES WHERE NAME LIKE 'EXT%'

		EXEC(@SQL)

		INSERT INTO ETL_LOG
		(EL_Start_Time, EL_Step_Name, EL_Flag_Error, EL_End_Time, EL_Error_Message)
		SELECT @Start_Time, @Step_Name, @flag_Error, GETDATE(), 'No Error'

	END TRY 

	BEGIN CATCH
		SET @flag_Error = 1
		INSERT INTO ETL_LOG
		(EL_Start_Time, EL_Step_Name, EL_Flag_Error, EL_End_Time, EL_Error_Message)
		SELECT @Start_Time, @Step_Name, @flag_Error, GETDATE(), ERROR_MESSAGE()
		RETURN	-1
	END CATCH
END

--/////////////////
SET @Start_Time = GETDATE()
SET @Step_Name = 'Procedure: ' + OBJECT_NAME(@@PROCID) + '  ,  ' + 'Step:  Drop WIP Tables'

IF (SELECT COUNT(*) FROM SYS.TABLES WHERE NAME LIKE 'WIP%') > 0
BEGIN
	BEGIN TRY 

		SELECT @SQL = STRING_AGG('DROP TABLE ' + NAME, ' ') FROM SYS.TABLES WHERE NAME LIKE 'WIP%'

		EXEC(@SQL)

		INSERT INTO ETL_LOG
		(EL_Start_Time, EL_Step_Name, EL_Flag_Error, EL_End_Time, EL_Error_Message)
		SELECT @Start_Time, @Step_Name, @flag_Error, GETDATE(), 'No Error'

	END TRY 

	BEGIN CATCH
		SET @flag_Error = 1
		INSERT INTO ETL_LOG
		(EL_Start_Time, EL_Step_Name, EL_Flag_Error, EL_End_Time, EL_Error_Message)
		SELECT @Start_Time, @Step_Name, @flag_Error, GETDATE(), ERROR_MESSAGE()
		RETURN	-1
	END CATCH
END


RETURN 1
GO

/****** Object:  StoredProcedure [dbo].[ETL_02_Create_Tables]    Script Date: 18/11/2020 09:15:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







-- Author:	Ben Quinn
-- Description:	ALTERs EXT and WIP Tables along with ETL_LOG

CREATE PROCEDURE [dbo].[ETL_02_Create_Tables]
as

SET NOCOUNT ON

DECLARE		@Start_Time			DATETIME,
			@Step_Name			VARCHAR(1000),
			@Step_Description	VARCHAR(1000),
			@Flag_Error			BIT = 0

--/////////////////
SET @Start_Time = GETDATE()
SET @Step_Name = 'Procedure: ' + OBJECT_NAME(@@PROCID) + '  ,  ' + 'Step:  ALTER EXT_Field_Records'

BEGIN TRY 

	CREATE TABLE [dbo].[EXT_Field_Record]
	(
		[1] [varchar](50) NULL,
		[3] [varchar](50) NULL,
		[5] [varchar](50) NULL,
		[8] [varchar](50) NULL,
		[9] [varchar](50) NULL,
		[14] [varchar](50) NULL,
		[17] [varchar](50) NULL,
		[19] [varchar](50) NULL,
		[20] [varchar](50) NULL,
		[21] [varchar](50) NULL,
		[22] [varchar](50) NULL,
		[lat] [varchar](50) NULL,
		[lon] [varchar](50) NULL,
		[Time] [varchar](50) NULL
	) ON [PRIMARY]

		INSERT INTO ETL_LOG
		(EL_Start_Time, EL_Step_Name, EL_Flag_Error, EL_End_Time, EL_Error_Message)
		SELECT @Start_Time, @Step_Name, @flag_Error, GETDATE(), 'No Error'

END TRY 

BEGIN CATCH
		SET @flag_Error = 1
		INSERT INTO ETL_LOG
		(EL_Start_Time, EL_Step_Name, EL_Flag_Error, EL_End_Time, EL_Error_Message)
		SELECT @Start_Time, @Step_Name, @flag_Error, GETDATE(), ERROR_MESSAGE()
		RETURN	-1
END CATCH

--/////////////////
SET @Start_Time = GETDATE()
SET @Step_Name = 'Procedure: ' + OBJECT_NAME(@@PROCID) + '  ,  ' + 'Step:  ALTER EXT_Attributes'

BEGIN TRY 

	CREATE TABLE [dbo].[EXT_Attributes]
	(
		[Attribute] [varchar](50) NULL,
		[Code] [varchar](50) NULL,
		[Value] [varchar](50) NULL
	) ON [PRIMARY]

		INSERT INTO ETL_LOG
		(EL_Start_Time, EL_Step_Name, EL_Flag_Error, EL_End_Time, EL_Error_Message)
		SELECT @Start_Time, @Step_Name, @flag_Error, GETDATE(), 'No Error'

END TRY 

BEGIN CATCH
		SET @flag_Error = 1
		INSERT INTO ETL_LOG
		(EL_Start_Time, EL_Step_Name, EL_Flag_Error, EL_End_Time, EL_Error_Message)
		SELECT @Start_Time, @Step_Name, @flag_Error, GETDATE(), ERROR_MESSAGE()
		RETURN	-1
END CATCH

--/////////////////
SET @Start_Time = GETDATE()
SET @Step_Name = 'Procedure: ' + OBJECT_NAME(@@PROCID) + '  ,  ' + 'Step:  ALTER WIP_Field_Record'

BEGIN TRY 

	CREATE TABLE [dbo].[WIP_Field_Record](
		[FR_ID] [varchar](100) NULL,
		[Latitude] [decimal](12, 7) NULL,
		[Longitude] [decimal](12, 7) NULL,
		[Time] [varchar](10) NULL,
		[Timeperiod] [varchar](7) NULL,
		[AVK_Bruises] [varchar](100) NULL,
		[AVK_Cap_Surface] [varchar](100) NULL,
		[AVK_Edibility] [varchar](100) NULL,
		[AVK_Grill_Colour] [varchar](100) NULL,
		[AVK_Grill_Size] [varchar](100) NULL,
		[AVK_Grill_Spacing] [varchar](100) NULL,
		[AVK_Habitat] [varchar](100) NULL,
		[AVK_Population] [varchar](100) NULL,
		[AVK_Ring_Type] [varchar](100) NULL,
		[AVK_Stalk_Surface_Below_Ring] [varchar](100) NULL,
		[AVK_Veil_Colour] [varchar](100) NULL
	) ON [PRIMARY]

		INSERT INTO ETL_LOG
		(EL_Start_Time, EL_Step_Name, EL_Flag_Error, EL_End_Time, EL_Error_Message)
		SELECT @Start_Time, @Step_Name, @flag_Error, GETDATE(), 'No Error'

END TRY 

BEGIN CATCH
		SET @flag_Error = 1
		INSERT INTO ETL_LOG
		(EL_Start_Time, EL_Step_Name, EL_Flag_Error, EL_End_Time, EL_Error_Message)
		SELECT @Start_Time, @Step_Name, @flag_Error, GETDATE(), ERROR_MESSAGE()
		RETURN	-1
END CATCH

--/////////////////
SET @Start_Time = GETDATE()
SET @Step_Name = 'Procedure: ' + OBJECT_NAME(@@PROCID) + '  ,  ' + 'Step:  ALTER WIP_Attributes'

BEGIN TRY 


	CREATE TABLE [dbo].[WIP_Attributes](
		[MA_ID] [varchar](100) NULL,
		[MA_Attribute_Name] [varchar](100) NULL,
		[MA_Attribute_Value] [varchar](100) NULL
	) ON [PRIMARY]


	INSERT INTO ETL_LOG
	(EL_Start_Time, EL_Step_Name, EL_Flag_Error, EL_End_Time, EL_Error_Message)
	SELECT @Start_Time, @Step_Name, @flag_Error, GETDATE(), 'No Error'

END TRY 

BEGIN CATCH
		SET @flag_Error = 1
		INSERT INTO ETL_LOG
		(EL_Start_Time, EL_Step_Name, EL_Flag_Error, EL_End_Time, EL_Error_Message)
		SELECT @Start_Time, @Step_Name, @flag_Error, GETDATE(), ERROR_MESSAGE()
		RETURN	-1
END CATCH

--/////////////////
SET @Start_Time = GETDATE()
SET @Step_Name = 'Procedure: ' + OBJECT_NAME(@@PROCID) + '  ,  ' + 'Step:  ALTER WIP_Field_Record_Attribute_Identity'

BEGIN TRY 


	CREATE TABLE [dbo].[WIP_Field_Record_Attribute_Identity](
		[AI_ID] [varchar](100) NULL,
		[AI_MA_ID_FK] [varchar](100) NULL,
		[AI_FR_ID_FK] [varchar](100) NULL
	) ON [PRIMARY]

	INSERT INTO ETL_LOG
	(EL_Start_Time, EL_Step_Name, EL_Flag_Error, EL_End_Time, EL_Error_Message)
	SELECT @Start_Time, @Step_Name, @flag_Error, GETDATE(), 'No Error'

END TRY 

BEGIN CATCH
		SET @flag_Error = 1
		INSERT INTO ETL_LOG
		(EL_Start_Time, EL_Step_Name, EL_Flag_Error, EL_End_Time, EL_Error_Message)
		SELECT @Start_Time, @Step_Name, @flag_Error, GETDATE(), ERROR_MESSAGE()
		RETURN	-1
END CATCH


RETURN 1
GO

/****** Object:  StoredProcedure [dbo].[ETL_03_Insert_Into_EXT]    Script Date: 18/11/2020 09:15:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







-- Author:	Ben Quinn
-- Description:	ALTERs EXT and WIP Tables along with ETL_LOG

CREATE PROCEDURE [dbo].[ETL_03_Insert_Into_EXT]  @Record_File_Path VARCHAR(255), @Attribute_File_Path VARCHAR(255)
as

SET NOCOUNT ON

DECLARE		@Start_Time			DATETIME,
			@Step_Name			VARCHAR(1000),
			@Step_Description	VARCHAR(1000),
			@Flag_Error			BIT = 0,
			@SQL				VARCHAR(MAX)

--/////////////////
SET @Start_Time = GETDATE()
SET @Step_Name = 'Procedure: ' + OBJECT_NAME(@@PROCID) + '  ,  ' + 'Step:  Insert into EXT_Field_Records'

BEGIN TRY 

	SET @SQL =  'BULK INSERT EXT_Field_Record
				FROM ''' + @Record_File_Path + '''' +  
				'WITH (FIRSTROW = 2,
					FIELDTERMINATOR = '','',
					ROWTERMINATOR= ''\n'' )'
	EXEC(@SQL)

	INSERT INTO ETL_LOG
	(EL_Start_Time, EL_Step_Name, EL_Flag_Error, EL_End_Time, EL_Error_Message)
	SELECT @Start_Time, @Step_Name, @flag_Error, GETDATE(), 'No Error'

END TRY 

BEGIN CATCH
		SET @flag_Error = 1
		INSERT INTO ETL_LOG
		(EL_Start_Time, EL_Step_Name, EL_Flag_Error, EL_End_Time, EL_Error_Message)
		SELECT @Start_Time, @Step_Name, @flag_Error, GETDATE(), ERROR_MESSAGE()
		RETURN	-1
END CATCH

--/////////////////
SET @Start_Time = GETDATE()
SET @Step_Name = 'Procedure: ' + OBJECT_NAME(@@PROCID) + '  ,  ' + 'Step:  Insert into EXT_Attributes'

BEGIN TRY 

	SET @SQL =  'BULK INSERT EXT_Attributes
				FROM '''+ @Attribute_File_Path  + '''' + 
				'WITH (FIRSTROW = 2,
					FIELDTERMINATOR = '','',
					ROWTERMINATOR= ''\n'' )'

		EXEC(@SQL)

	INSERT INTO ETL_LOG
	(EL_Start_Time, EL_Step_Name, EL_Flag_Error, EL_End_Time, EL_Error_Message)
	SELECT @Start_Time, @Step_Name, @flag_Error, GETDATE(), 'No Error'

END TRY 

BEGIN CATCH
		SET @flag_Error = 1
		INSERT INTO ETL_LOG
		(EL_Start_Time, EL_Step_Name, EL_Flag_Error, EL_End_Time, EL_Error_Message)
		SELECT @Start_Time, @Step_Name, @flag_Error, GETDATE(), ERROR_MESSAGE()
		RETURN -1
END CATCH

RETURN 1
GO

/****** Object:  StoredProcedure [dbo].[ETL_04_EXT_To_WIP]    Script Date: 18/11/2020 09:15:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







-- Author:	Ben Quinn
-- Description:	ALTERs EXT and WIP Tables along with ETL_LOG

CREATE PROCEDURE [dbo].[ETL_04_EXT_To_WIP]
as

SET NOCOUNT ON

DECLARE		@Start_Time			DATETIME,
			@Step_Name			VARCHAR(1000),
			@Flag_Error			BIT = 0 


--/////////////////
SET @Start_Time = GETDATE()
SET @Step_Name = 'Procedure: ' + OBJECT_NAME(@@PROCID) + '  ,  ' + 'Step:  Move and cleanse data from EXT_Field_Record to WIP_Field_Record'

BEGIN TRY 

INSERT INTO [WIP_Field_Record]
(
	 [AVK_Bruises]			
	,[AVK_Cap_Surface]			
	,[AVK_Edibility]				
	,[AVK_Grill_Colour]				
	,[AVK_Grill_Size]				
	,[AVK_Grill_Spacing]			
	,[AVK_Habitat]		
	,[AVK_Population]				
	,[AVK_Ring_Type]				
	,[AVK_Stalk_Surface_Below_Ring]
	,[AVK_Veil_Colour]	
	,[Latitude]
	,[Longitude]
	,[Time]
	,[Timeperiod]
	,[FR_ID]
)
SELECT 
	 'Edibility'				+ '_' + UPPER([1])																AS AVK_Edibility
	,'Cap_Surface'				+ '_' + UPPER([3])																AS AVK_Cap_Surface
	,'Bruises'					+ '_' + UPPER([5])																AS AVK_Bruises
	,'Grill_Spacing'			+ '_' + UPPER([8])																AS AVK_Grill_Spacing
	,'Grill_Size'				+ '_' + UPPER([9])																AS AVK_Grill_Size
	,'Stalk_Surface_Below_Ring'	+ '_' + UPPER([14])																AS AVK_Stalk_Surface_Below_Ring
	,'Veil_Colour'				+ '_' + UPPER([17])																AS AVK_Veil_Colour
	,'Ring_Type'				+ '_' + UPPER([19])																AS AVK_Ring_Type
	,'Grill_Colour'				+ '_' + UPPER([20])																AS AVK_Grill_Colour
	,'Population'				+ '_' + UPPER([21])																AS AVK_Population
	,'Habitat'					+ '_' + UPPER([22])																AS AVK_Habitat
	,CAST([LAT] AS DECIMAL(12,7))																				AS [Latitude]
	,CAST([LON] AS DECIMAL(12,7))																				AS [Longdidtude]
	,CONVERT(VARCHAR(10), TRIM(REPLACE(REPLACE(TRIM([TIME]), 'PM', ''), 'AM','')), 108)							AS [Time]
	,CAST(YEAR(GETDATE()) AS VARCHAR(4)) + '_' + CAST(RIGHT('0' + MONTH(GETDATE()), 2) AS VARCHAR(2))			AS [Timeperiod]
	,CAST(YEAR(GETDATE()) AS VARCHAR(4)) + '_' + CAST(RIGHT('0' + MONTH(GETDATE()), 2) AS VARCHAR(2)) 
	+ '_' + CAST(ROW_NUMBER() OVER (ORDER BY [1] DESC) AS VARCHAR(MAX))											AS [FR_ID]
FROM [dbo].[EXT_Field_Record]

	INSERT INTO ETL_LOG
	(EL_Start_Time, EL_Step_Name, EL_Flag_Error, EL_End_Time, EL_Error_Message)
	SELECT @Start_Time, @Step_Name, @flag_Error, GETDATE(), 'No Error'

END TRY 

BEGIN CATCH
		SET @flag_Error = 1
		INSERT INTO ETL_LOG
		(EL_Start_Time, EL_Step_Name, EL_Flag_Error, EL_End_Time, EL_Error_Message)
		SELECT @Start_Time, @Step_Name, @flag_Error, GETDATE(), ERROR_MESSAGE()
		RETURN	-1
END CATCH

--/////////////////
SET @Start_Time = GETDATE()
SET @Step_Name = 'Procedure: ' + OBJECT_NAME(@@PROCID) + '  ,  ' + 'Step:  Unpivot data in WIP_Field_Record and insert into WIP_Field_Record_Attribute_Identity'


BEGIN TRY 

INSERT INTO WIP_Field_Record_Attribute_Identity
([AI_ID], [AI_FR_ID_FK], [AI_MA_ID_FK])
SELECT [FR_ID] + '_' + UPPER([MA_ID_FK]) AS [AI_ID], [FR_ID] AS [FR_ID_FK], [TIMEPERIOD] + '_' + UPPER([MA_ID_FK]) AS [MA_ID_FK]
FROM   
   (SELECT	[FR_ID]
			,[TIMEPERIOD]
			,[AVK_Bruises]			
			,[AVK_Cap_Surface]			
			,[AVK_Edibility]				
			,[AVK_Grill_Colour]				
			,[AVK_Grill_Size]				
			,[AVK_Grill_Spacing]			
			,[AVK_Habitat]		
			,[AVK_Population]				
			,[AVK_Ring_Type]				
			,[AVK_Stalk_Surface_Below_Ring]
			,[AVK_Veil_Colour]	
   FROM [WIP_Field_Record]) p  
		UNPIVOT  
			(MA_ID_FK
				FOR Attribute_Group IN   
							(	
								 [AVK_Bruises]			
								,[AVK_Cap_Surface]			
								,[AVK_Edibility]				
								,[AVK_Grill_Colour]				
								,[AVK_Grill_Size]				
								,[AVK_Grill_Spacing]			
								,[AVK_Habitat]		
								,[AVK_Population]				
								,[AVK_Ring_Type]				
								,[AVK_Stalk_Surface_Below_Ring]
								,[AVK_Veil_Colour]	
							)
)AS unpvt

	INSERT INTO ETL_LOG
	(EL_Start_Time, EL_Step_Name, EL_Flag_Error, EL_End_Time, EL_Error_Message)
	SELECT @Start_Time, @Step_Name, @flag_Error, GETDATE(), 'No Error'

END TRY 

BEGIN CATCH
		SET @flag_Error = 1
		INSERT INTO ETL_LOG
		(EL_Start_Time, EL_Step_Name, EL_Flag_Error, EL_End_Time, EL_Error_Message)
		SELECT @Start_Time, @Step_Name, @flag_Error, GETDATE(), ERROR_MESSAGE()
		RETURN	-1
END CATCH

--/////////////////
SET @Start_Time = GETDATE()
SET @Step_Name = 'Procedure: ' + OBJECT_NAME(@@PROCID) + '  ,  ' + 'Step:  Move and cleanse data from EXT_Attributes to WIP_Attributes'


BEGIN TRY 

INSERT INTO [WIP_Attributes] 
	(
	 [MA_ID]
	,[MA_Attribute_Name]
	,[MA_Attribute_Value]
	)
SELECT
	 CAST(YEAR(GETDATE()) AS VARCHAR(4)) + '_' + CAST(RIGHT('0' + MONTH(GETDATE()), 2) AS VARCHAR(2)) + '_' + REPLACE([Attribute], ' ', '_') + '_' + UPPER(TRIM([CODE])) AS [MA_ID]
	,TRIM([Attribute]) AS [MA_Attribute_Name]
	,UPPER(TRIM(Value)) AS [MA_Attribute_Value]
FROM [EXT_Attributes]

	INSERT INTO ETL_LOG
	(EL_Start_Time, EL_Step_Name, EL_Flag_Error, EL_End_Time, EL_Error_Message)
	SELECT @Start_Time, @Step_Name, @flag_Error, GETDATE(), 'No Error'

END TRY 

BEGIN CATCH
		SET @flag_Error = 1
		INSERT INTO ETL_LOG
		(EL_Start_Time, EL_Step_Name, EL_Flag_Error, EL_End_Time, EL_Error_Message)
		SELECT @Start_Time, @Step_Name, @flag_Error, GETDATE(), ERROR_MESSAGE()
		RETURN	-1
END CATCH

RETURN 1
GO

/****** Object:  StoredProcedure [dbo].[ETL_05_WIP_to_MOD]    Script Date: 18/11/2020 09:15:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO








-- Author:	Ben Quinn
-- Description:	ALTERs EXT and WIP Tables along with ETL_LOG

CREATE PROCEDURE [dbo].[ETL_05_WIP_to_MOD]
as

SET NOCOUNT ON

DECLARE		@Start_Time			DATETIME,
			@Step_Name			VARCHAR(1000),
			@Timeperiod			VARCHAR(7) = CAST(YEAR(GETDATE()) AS VARCHAR(4)) + '_' + CAST(RIGHT(MONTH(GETDATE()), 2) AS VARCHAR(2)),
			@Flag_Error			BIT = 0


--/////////////////
SET @Start_Time = GETDATE()
SET @Step_Name = 'Procedure: ' + OBJECT_NAME(@@PROCID) + '  ,  ' + 'Step:  Move data from WIP_Attributes to MOD_Attributes for the given year and month'

BEGIN TRY 

DELETE FROM MOD_Attribute WHERE RIGHT(MA_ID, 7) = @Timeperiod

INSERT INTO MOD_Attribute
([MA_ID], [MA_Attribute_Name], [MA_Attribute_Value])
SELECT [MA_ID], [MA_Attribute_Name], [MA_Attribute_Value]
FROM WIP_Attributes

	INSERT INTO ETL_LOG
	(EL_Start_Time, EL_Step_Name, EL_Flag_Error, EL_End_Time, EL_Error_Message)
	SELECT @Start_Time, @Step_Name, @flag_Error, GETDATE(), 'No Error'

END TRY 

BEGIN CATCH
		SET @flag_Error = 1
		INSERT INTO ETL_LOG
		(EL_Start_Time, EL_Step_Name, EL_Flag_Error, EL_End_Time, EL_Error_Message)
		SELECT @Start_Time, @Step_Name, @flag_Error, GETDATE(), ERROR_MESSAGE()
		RETURN	-1
END CATCH

--/////////////////
SET @Start_Time = GETDATE()
SET @Step_Name = 'Procedure: ' + OBJECT_NAME(@@PROCID) + '  ,  ' + 'Step:  Move data from WIP_Attributes to MOD_Attributes for the given year and month'

BEGIN TRY 

DELETE FROM MOD_Field_Record_Attribute_Identity WHERE RIGHT(AI_ID, 7) = @Timeperiod

INSERT INTO MOD_Field_Record_Attribute_Identity
([AI_ID], [AI_MA_ID_FK], [AI_FR_ID_FK])
SELECT [AI_ID], [AI_MA_ID_FK], [AI_FR_ID_FK]
FROM WIP_Field_Record_Attribute_Identity

	INSERT INTO ETL_LOG
	(EL_Start_Time, EL_Step_Name, EL_Flag_Error, EL_End_Time, EL_Error_Message)
	SELECT @Start_Time, @Step_Name, @flag_Error, GETDATE(), 'No Error'

END TRY 

BEGIN CATCH
		SET @flag_Error = 1
		INSERT INTO ETL_LOG
		(EL_Start_Time, EL_Step_Name, EL_Flag_Error, EL_End_Time, EL_Error_Message)
		SELECT @Start_Time, @Step_Name, @flag_Error, GETDATE(), ERROR_MESSAGE()
		RETURN	-1
END CATCH

--/////////////////
SET @Start_Time = GETDATE()
SET @Step_Name = 'Procedure: ' + OBJECT_NAME(@@PROCID) + '  ,  ' + 'Step:  Move data from WIP_Attributes to MOD_Attributes for the given year and month'

BEGIN TRY 

DELETE FROM MOD_Field_Record WHERE RIGHT(FR_ID, 7) = @Timeperiod

INSERT INTO  MOD_Field_Record
([FR_ID], [FR_Longitude], [FR_Latitude], [FR_Time])
SELECT [FR_ID], [Longitude] AS [FR_Longitude], [Latitude] AS [FR_Latittude], [Time] AS [FR_Time]
FROM WIP_Field_Record

	INSERT INTO ETL_LOG
	(EL_Start_Time, EL_Step_Name, EL_Flag_Error, EL_End_Time, EL_Error_Message)
	SELECT @Start_Time, @Step_Name, @flag_Error, GETDATE(), 'No Error'

END TRY 

BEGIN CATCH
		SET @flag_Error = 1
		INSERT INTO ETL_LOG
		(EL_Start_Time, EL_Step_Name, EL_Flag_Error, EL_End_Time, EL_Error_Message)
		SELECT @Start_Time, @Step_Name, @flag_Error, GETDATE(), ERROR_MESSAGE()
		RETURN	-1
END CATCH

RETURN 1
GO

/****** Object:  StoredProcedure [dbo].[ETL_06_MOD_to_DM]    Script Date: 18/11/2020 09:15:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO








-- Author:	Ben Quinn
-- Description:	ALTERs EXT and WIP Tables along with ETL_LOG

CREATE PROCEDURE [dbo].[ETL_06_MOD_to_DM]
as

SET NOCOUNT ON

DECLARE		@Start_Time			DATETIME,
			@Step_Name			VARCHAR(1000),
			@Timeperiod			VARCHAR(10) = CAST(YEAR(GETDATE()) AS VARCHAR(4)) + '_' + CAST(RIGHT(MONTH(GETDATE()), 2) AS VARCHAR(2)),
			@SQL				VARCHAR(MAX),
			@Flag_Error			BIT = 0


--/////////////////
SET @Start_Time = GETDATE()
SET @Step_Name = 'Procedure: ' + OBJECT_NAME(@@PROCID) + '  ,  ' + 'Step:  Delete from DM_Field_Record_Reporting for the given month and year, then insert ID, Lon, Lat, Time from MOD_Field_Record'

BEGIN TRY 

DELETE FROM DM_Field_Record_Reporting WHERE LEFT(FR_ID, 7) = '' + @Timeperiod + ''

INSERT INTO [DM_Field_Record_Reporting]
([FR_ID],[FR_Longitude],[FR_Latitude],[FR_Time])						
SELECT [FR_ID],[FR_Longitude],[FR_Latitude],[FR_Time]
FROM [dbo].[MOD_Field_Record]

	INSERT INTO ETL_LOG
	(EL_Start_Time, EL_Step_Name, EL_Flag_Error, EL_End_Time, EL_Error_Message)
	SELECT @Start_Time, @Step_Name, @flag_Error, GETDATE(), 'No Error'

END TRY 

BEGIN CATCH
		SET @flag_Error = 1
		INSERT INTO ETL_LOG
		(EL_Start_Time, EL_Step_Name, EL_Flag_Error, EL_End_Time, EL_Error_Message)
		SELECT @Start_Time, @Step_Name, @flag_Error, GETDATE(), ERROR_MESSAGE()
		RETURN	-1
END CATCH


----/////////////////
SET @Start_Time = GETDATE()
SET @Step_Name = 'Procedure: ' + OBJECT_NAME(@@PROCID) + '  ,  ' + 'Step:  Update remaining columns in DM_Field_Record_Reporting for the given month and year'

BEGIN TRY 

SELECT  @SQL = 
	STRING_AGG('UPDATE DM_Field_Record_Reporting SET [FR_' + REPLACE([MA_Attribute_Name], ' ', '_') + '] = MA.[MA_Attribute_Value]' + 
	'FROM DM_Field_Record_Reporting DM
		INNER JOIN MOD_Field_Record_Attribute_Identity AI
			ON  AI.[AI_FR_ID_FK] = DM.[FR_ID]
		INNER JOIN MOD_Field_Record FR
			ON AI.[AI_FR_ID_FK] = FR.[FR_ID]
		INNER JOIN MOD_Attribute MA
			ON AI.[AI_MA_ID_FK] = MA.[MA_ID]
	WHERE MA.[MA_Attribute_Name] = ''' + [MA_Attribute_Name] + ''''
	+ ' AND LEFT(FR.[FR_ID],7) = ''' + @Timeperiod + '''', ' ')
FROM 
	(
	 SELECT DISTINCT MA_Attribute_Name
	 FROM MOD_Attribute
	 ) REF

EXEC(@SQL)

	INSERT INTO ETL_LOG
	(EL_Start_Time, EL_Step_Name, EL_Flag_Error, EL_End_Time, EL_Error_Message)
	SELECT @Start_Time, @Step_Name, @flag_Error, GETDATE(), 'No Error'

END TRY 

BEGIN CATCH
		SET @flag_Error = 1
		INSERT INTO ETL_LOG
		(EL_Start_Time, EL_Step_Name, EL_Flag_Error, EL_End_Time, EL_Error_Message)
		SELECT @Start_Time, @Step_Name, @flag_Error, GETDATE(), ERROR_MESSAGE()
		RETURN	-1
END CATCH

RETURN 1

GO



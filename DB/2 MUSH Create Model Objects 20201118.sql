USE [DEV_MUSHROOM]
GO

/****** Object:  Table [dbo].[DM_Field_Record_Reporting]    Script Date: 18/11/2020 09:10:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DM_Field_Record_Reporting](
	[FR_ID]								 [varchar](100),
	[FR_Longitude]						 [decimal](12, 7),
	[FR_Latitude]						 [decimal](12, 7),
	[FR_Time]							 [varchar](10) NULL,
	[FR_Bruises]						 [varchar](50) NULL,
	[FR_Cap_Surface]					 [varchar](50) NULL,
	[FR_Edibility]						 [varchar](50) NULL,
	[FR_Grill_Colour]					 [varchar](50) NULL,
	[FR_Grill_Size]						 [varchar](50) NULL,
	[FR_Grill_Spacing]					 [varchar](50) NULL,
	[FR_Habitat]						 [varchar](50) NULL,
	[FR_Population]						 [varchar](50) NULL,
	[FR_Ring_Type]						 [varchar](50) NULL,
	[FR_Stalk_Surface_Below_Ring]		 [varchar](50) NULL,
	[FR_Veil_Colour]					 [varchar](50) NULL,
	CONSTRAINT PK_DM PRIMARY KEY (FR_ID)
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[ETL_LOG]    Script Date: 18/11/2020 09:10:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ETL_LOG](
	[EL_Step_Name]						[varchar](1000),
	[EL_Start_Time]						[datetime]	   ,
	[EL_Flag_Error]						[bit]	       ,
	[EL_Error_Message]					[varchar](max) ,
	[EL_End_Time]						[datetime]     
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[MOD_Attribute]    Script Date: 18/11/2020 09:10:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[MOD_Attribute](
	[MA_ID]							  [varchar](100),
	[MA_Attribute_Name]				  [varchar](100),
	[MA_Attribute_Value]			  [varchar](100)
	CONSTRAINT PK_Attribute PRIMARY KEY (MA_ID)
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[MOD_Field_Record]    Script Date: 18/11/2020 09:10:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[MOD_Field_Record](
	[FR_ID]							[varchar](100)	,
	[FR_Longitude]					[decimal](12, 7),
	[FR_Latitude]					[decimal](12, 7),
	[FR_Time]						[varchar](10)	
	CONSTRAINT PK_Field_Record PRIMARY KEY (FR_ID)
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[MOD_Field_Record_Attribute_Identity]    Script Date: 18/11/2020 09:10:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[MOD_Field_Record_Attribute_Identity](
	[AI_ID]						[varchar](100),
	[AI_MA_ID_FK]				[varchar](100),
	[AI_FR_ID_FK]				[varchar](100)
	CONSTRAINT PK_Attribute_Identity PRIMARY KEY (AI_ID)
) ON [PRIMARY]
GO



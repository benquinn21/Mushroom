
--//** How many different species of mushroom are there, if a species is identified by the attributes 1-20?
SELECT COUNT(*) AS Species_Count
FROM 
	(
		SELECT DISTINCT 
			 FR_Edibility
			,FR_Cap_Surface
			,FR_Bruises
			,FR_Grill_Spacing
			,FR_Grill_Size
			,FR_Stalk_Surface_Below_Ring
			,FR_Veil_Colour
			,FR_Ring_Type
			,FR_Grill_Colour
		FROM [DM_Field_Record_Reporting]
	) REF


--//** Does habitat and cap-color (Grill Colour used) correlate?
EXEC sp_execute_external_script
 @language = N'R'
 ,@script = N'x<-fisher.test(InputDataSet[1:2,c("MEADOWS", "LEAVES", "PATHS", "URBAN", "WOOD", "WASTE", "GRASSES")], simulate.p.value=TRUE);print(x)'
 ,@input_data_1 = N'SELECT
    
					 ISNULL(MEADOWS, 0)	as MEADOWS
					,ISNULL(LEAVES , 0)	as LEAVES 
					,ISNULL(PATHS  , 0)	as PATHS  
					,ISNULL(URBAN  , 0)	as URBAN  
					,ISNULL(WOOD   , 0)	as WOOD   
					,ISNULL(WASTE  , 0)	as WASTE  
					,ISNULL(GRASSES, 0)	as GRASSES
FROM  
(SELECT DISTINCT FR_GRILL_COLOUR, FR_HABITAT, COUNT(*)  as count_
    FROM [dbo].[DM_Field_Record_Reporting] GROUP BY FR_GRILL_COLOUR, FR_HABITAT having  COUNT(*) > 0) AS SourceTable  
PIVOT  
(  
sum(count_)
FOR FR_HABITAT IN 
					(
					 MEADOWS
					,LEAVES
					,PATHS
					,URBAN
					,WOOD
					,WASTE
					,GRASSES
					)
) AS PivotTable;'

--//** Considering a specific geographical point, what colours should we be able to see in the 10 km around it?
DECLARE 
		@GEOGRAHICAL_POINT GEOGRAPHY =  geography::Point(-85.6114000,-43.1872000, 4326)

SELECT DISTINCT FR_Veil_Colour, FR_Grill_Colour 
FROM 
	(
	SELECT  @GEOGRAHICAL_POINT.STDistance(geography::Point(FR_Latitude, FR_Longitude, 4326)) AS DISTANCE, *
	FROM [DM_Field_Record_Reporting]
	WHERE @GEOGRAHICAL_POINT.STDistance(geography::Point(FR_Latitude, FR_Longitude, 4326)) <= 10000
	) REF


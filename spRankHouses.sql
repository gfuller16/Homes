USE [HomesDB]
GO

/****** Object:  StoredProcedure [dbo].[spRankHouses]    Script Date: 5/7/2019 3:20:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spRankHouses] --1
	  ( @ShowDetails int = 0
	  ) 
AS
BEGIN

DECLARE @CommuteMultiplier  decimal(7, 6)
	  , @LotSizeMultiplier  decimal(7, 6)
	  , @PriceMultiplier    decimal(7, 6)
	  , @SizeMultiplier     decimal(7, 6)
	  , @YearMultiplier     decimal(7, 6)
	  , @InsideMultiplier   decimal(7, 6)
	  , @OutsideMultiplier  decimal(7, 6)
	  , @LocationMultiplier decimal(7, 6)
	  , @BedBathMultiplier  decimal(7, 6);

DECLARE @CommuteWeight  int           = 5
	  , @PriceWeight    int           = 4
	  , @LotSizeWeight  int           = 3
	  , @YearWeight     int           = 2
	  , @SizeWeight     int           = 1	  
	  , @OutsideWeight   int          = 3
	  , @InsideWeight  int            = 2
	  , @LocationWeight int           = 1
	  , @BedBathWeight  int           = 3
	  , @CommuteB       decimal(5, 3)
	  , @PriceB         decimal(5, 3)
	  , @LotSizeB       decimal(5, 3)
	  , @SizeB          decimal(5, 3)
	  , @YearB          decimal(5, 3)
	  , @InsideB        decimal(5, 3)
	  , @OutsideB       decimal(5, 3)
	  , @LocationB      decimal(5, 3)
	  , @BedBathB       decimal(5, 3);

EXEC [dbo].[spGetMultiplier] 'COMMUTE'
						   , @CommuteWeight
						   , @CommuteMultiplier OUTPUT
						   , @CommuteB OUTPUT;
EXEC [dbo].[spGetMultiplier] 'PRICE'
						   , @PriceWeight
						   , @PriceMultiplier OUTPUT
						   , @PriceB OUTPUT;
EXEC [dbo].[spGetMultiplier] 'LOT SIZE'
						   , @LotSizeWeight
						   , @LotSizeMultiplier OUTPUT
						   , @LotSizeB OUTPUT;
EXEC [dbo].[spGetMultiplier] 'HOUSE SIZE'
						   , @SizeWeight
						   , @SizeMultiplier OUTPUT
						   , @SizeB OUTPUT;
EXEC [dbo].[spGetMultiplier] 'YEAR'
						   , @YearWeight
						   , @YearMultiplier OUTPUT
						   , @YearB OUTPUT;
EXEC [dbo].[spGetMultiplier] 'INSIDE FEEL'
						   , @InsideWeight
						   , @InsideMultiplier OUTPUT
						   , @InsideB OUTPUT;
EXEC [dbo].[spGetMultiplier] 'OUTSIDE FEEL'
						   , @OutsideWeight
						   , @OutsideMultiplier OUTPUT
						   , @OutsideB OUTPUT;
EXEC [dbo].[spGetMultiplier] 'LOCATION'
						   , @LocationWeight
						   , @LocationMultiplier OUTPUT
						   , @LocationB OUTPUT;
EXEC [dbo].[spGetMultiplier] 'BEDS/BATHS'
						   , @BedBathWeight
						   , @BedBathMultiplier OUTPUT
						   , @BedBathB OUTPUT;

--select
--@CommuteMultiplier,@PriceMultiplier,@LotSizeMultiplier,@SizeMultiplier,@YearMultiplier,@InsideMultiplier,@OutsideMultiplier,@LocationMultiplier,@BedBathMultiplier

CREATE TABLE [#Scores]
			 ( [HouseID]          int
			 , [House]            varchar(25)
			 , [TotalScore]       decimal(5, 3)
			 , [CommuteScore]     decimal(5, 3)
			 , [LotSizeScore]     decimal(6, 3)
			 , [PriceScore]       decimal(5, 3)
			 , [SizeScore]        decimal(5, 3)
			 , [YearScore]        decimal(5, 3)
			 , [BedBathScore]     decimal(5, 3)
			 , [InsideFeelScore]  decimal(5, 3)
			 , [OutsideFeelScore] decimal(5, 3)
			 , [LotLocationScore] decimal(5, 3)
			 );

WITH cte_Scores
	 AS (SELECT [hID]
			  , [hStreet]
			  , [hCommute]
			  , CONVERT(decimal(7, 6), ( ( @CommuteMultiplier * CONVERT(decimal(15, 7), [hCommute]) ) ) + @CommuteB) AS [CommuteScore]
			  , [hLotSize]
			  , CASE
					WHEN CONVERT(decimal(8, 6), ( @LotSizeMultiplier * CONVERT(decimal(15, 7), [hLotSize]) ) + @LotSizeB) > 5 THEN 5
					ELSE CONVERT(decimal(8, 6), ( @LotSizeMultiplier * CONVERT(decimal(15, 7), [hLotSize]) ) + @LotSizeB)
				END AS [LotSizeScore]
			  , [hPrice]
			  , CONVERT(decimal(7, 6), ( ( @PriceMultiplier * CONVERT(decimal(15, 7), [hPrice]) ) ) + @PriceB ) AS [PriceScore]
			  , [hSize]
			  , CONVERT(decimal(7, 6), ( @SizeMultiplier * CONVERT(decimal(15, 7), [hSize]) ) + @SizeB) AS [SizeScore]
			  , [hYearBuilt]
			  , CONVERT(decimal(7, 6), ( @YearMultiplier * CONVERT(decimal(15, 7), [hYearBuilt]) ) + @YearB) AS [YearScore]
			  , [hBed]
			  , [hBath]
			  , CONVERT(decimal(7, 6), ( (CASE
											 WHEN
												  [hBed] = 2
												  AND [hBath] = 1 THEN 0
											 WHEN
												  [hBed] = 2
												  AND [hBath] = 1.5 THEN 0.5
											 WHEN
												  [hBed] = 2
												  AND [hBath] > 1.5 THEN 1
											 WHEN
												  [hBed] = 3
												  AND [hBath] = 1 THEN 2
											 WHEN
												  [hBed] = 3
												  AND [hBath] = 1.5 THEN 2.5
											 WHEN
												  [hBed] = 3
												  AND [hBath] > 1 THEN 3
											 WHEN
												  [hBed] = 4
												  AND [hBath] = 1 THEN 4
											 WHEN
												  [hBed] = 4
												  AND [hBath] = 1.5 THEN 4.5
											 WHEN
												  [hBed] = 4
												  AND [hBath] > 1 THEN 5
											 ELSE 0
										 END
									   ) * @BedBathMultiplier) + @BedBathB) AS [BedBathScore]
			  , [hInsideFeel]
			  , [hOutsideFeel]
			  , CONVERT(decimal(7, 6), ( [hInsideFeel] * @InsideMultiplier ) + @InsideB) AS [InsideFeelScore]
			  , CONVERT(decimal(7, 6), ( [hOutsideFeel] * @OutsideMultiplier ) + @OutsideB) AS [OutsideFeelScore]
			  , CONVERT(decimal(7, 6), ( [hLocation] * @LocationMultiplier ) + @LocationB) AS [LotLocationScore]
		 FROM   [tblHouses])

	 INSERT INTO [#Scores]
			SELECT [hID]
				 , [hStreet] AS [House]
				 , CONVERT(decimal(8, 6), ( [CommuteScore] + [LotSizeScore] + [PriceScore] + [SizeScore] + [YearScore] + [BedBathScore] + [InsideFeelScore] + [OutsideFeelScore] + [LotLocationScore] ) ) AS [TotalScore]
				 , [CommuteScore]
				 , [LotSizeScore]
				 , [PriceScore]
				 , [SizeScore]
				 , [YearScore]
				 , [BedBathScore]
				 , [InsideFeelScore]
				 , [OutsideFeelScore]
				 , [LotLocationScore]
			FROM   [cte_Scores];

IF ( @ShowDetails <> 1 ) 
BEGIN

SELECT [House]
	 , [HouseID]
	 , [TotalScore]
	 , [CommuteScore]
	 , [PriceScore]
	 , [LotSizeScore]	 
	 , [SizeScore]
	 , [YearScore]
	 , [BedBathScore]
	 , [InsideFeelScore]
	 , [OutsideFeelScore]
	 , [LotLocationScore]
FROM   [#Scores]
ORDER BY [TotalScore] DESC;

END;

IF ( @ShowDetails = 1 ) 
BEGIN

SELECT [s].[House]
	 , [s].[TotalScore]
	 , [h].*
FROM   [tblHouses] AS [h]
JOIN [#Scores] AS [s]
	   ON [s].[HouseID] = [h].[hID]
ORDER BY [TotalScore] DESC;

END;

DROP TABLE [#Scores];

END;
GO



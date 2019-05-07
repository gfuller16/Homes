USE [HomesDB]
GO
/****** Object:  StoredProcedure [dbo].[spGetMultiplier]    Script Date: 5/7/2019 3:57:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[spGetMultiplier] --'commute',5,0
	  ( @Attribute  varchar(30)
	  , @Weight     int
	  , @Multiplier decimal(7, 6) OUTPUT
	  , @B          decimal(5, 3) OUTPUT
	  ) 
AS
BEGIN

UPDATE [tblMultipliers]
  SET  [mWeighAmount] = @Weight
WHERE  [mAttribute] = @Attribute;

SET @Multiplier =
				  (
					SELECT CONVERT(decimal(8, 7), [mWeighAmount] / ( [mMaxAmount] - [mMinAmount] ) * [mSlope]) AS [m]
					FROM   [tblMultipliers]
					WHERE  [mAttribute] = @Attribute
				  );

IF
   (
	 SELECT [mSlope]
	 FROM   [tblMultipliers]
	 WHERE  [mAttribute] = @Attribute
   ) = 1
BEGIN

SET @B =
		 (
		   SELECT ( ( [mMinAmount] * @Multiplier ) * -1 )
		   FROM   [tblMultipliers]
		   WHERE  [mAttribute] = @Attribute
		 );

END;
	ELSE
BEGIN
SET @B =
		 (
		   SELECT ( ( [mMaxAmount] * @Multiplier ) * -1 )
		   FROM   [tblMultipliers]
		   WHERE  [mAttribute] = @Attribute
		 );
END;


RETURN @Multiplier;
RETURN @B;

END;

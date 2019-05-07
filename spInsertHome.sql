USE [HomesDB]
GO
/****** Object:  StoredProcedure [dbo].[spInsertHome]    Script Date: 5/7/2019 3:56:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[spInsertHome]
AS
BEGIN
	
	INSERT INTO tblHouses(
	hID,
	hNumber,
	hStreet,
	hStreetType,
	hCity,
	hLocation,
	hPrice,
	hBed,
	hBath,
	hSize,
	hLotSize,
	hCommute,
	hYearBuilt,
	hPropertyTaxes,
	hInsideFeel,
	hOutsideFeel,
	hLotLocation
	) VALUES
	(2,11358,'Hwy 27','n/a','Dewitt',5,99900,2,1,768,43560,15,1915,1943,3,4,3)
	
	DELETE FROM tblHouses
	WHERE hID IN(25)

	UPDATE tblHouses
	SET hOutsideFeel = 4
	WHERE hID = 28
	
	SELECT
	* 
	FROM tblHouses
	ORDER BY hID

END

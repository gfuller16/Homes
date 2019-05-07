USE [HomesDB]
GO

/****** Object:  Table [dbo].[tblHouses]    Script Date: 5/7/2019 3:58:41 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblHouses](
	[hID] [int] NOT NULL,
	[hNumber] [int] NOT NULL,
	[hStreet] [varchar](25) NOT NULL,
	[hStreetType] [varchar](5) NOT NULL,
	[hCity] [varchar](30) NOT NULL,
	[hLocation] [int] NULL,
	[hPrice] [money] NOT NULL,
	[hBed] [int] NOT NULL,
	[hBath] [decimal](2, 1) NULL,
	[hSize] [int] NOT NULL,
	[hLotSize] [int] NOT NULL,
	[hCommute] [int] NOT NULL,
	[hYearBuilt] [int] NOT NULL,
	[hPropertyTaxes] [money] NOT NULL,
	[hInsideFeel] [int] NULL,
	[hOutsideFeel] [int] NULL,
	[hLotLocation] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[hID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblHouses]  WITH CHECK ADD FOREIGN KEY([hInsideFeel])
REFERENCES [dbo].[tblFeel] ([fID])
GO

ALTER TABLE [dbo].[tblHouses]  WITH CHECK ADD FOREIGN KEY([hLocation])
REFERENCES [dbo].[tblLocation] ([lID])
GO

ALTER TABLE [dbo].[tblHouses]  WITH CHECK ADD FOREIGN KEY([hLotLocation])
REFERENCES [dbo].[tblFeel] ([fID])
GO

ALTER TABLE [dbo].[tblHouses]  WITH CHECK ADD FOREIGN KEY([hOutsideFeel])
REFERENCES [dbo].[tblFeel] ([fID])
GO



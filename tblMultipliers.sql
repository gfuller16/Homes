USE [HomesDB]
GO

/****** Object:  Table [dbo].[tblMultipliers]    Script Date: 5/7/2019 3:59:18 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblMultipliers](
	[mID] [int] NOT NULL,
	[mAttribute] [varchar](30) NOT NULL,
	[mMaxAmount] [decimal](12, 2) NULL,
	[mMinAmount] [decimal](12, 2) NULL,
	[mWeighAmount] [int] NOT NULL,
	[mSlope] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[mID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO



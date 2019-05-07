USE [HomesDB]
GO

/****** Object:  Table [dbo].[tblLocation]    Script Date: 5/7/2019 3:59:01 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblLocation](
	[lID] [int] NOT NULL,
	[lCity] [varchar](40) NOT NULL,
	[lGreaterLansingLocation] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[lID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO



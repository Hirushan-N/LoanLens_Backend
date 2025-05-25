USE [LoanLens_DB]
GO

/****** Object:  Table [dbo].[RefRiskThresholds]    Script Date: 5/25/2025 7:10:36 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RefRiskThresholds]') AND type in (N'U'))
DROP TABLE [dbo].[RefRiskThresholds]
GO

/****** Object:  Table [dbo].[RefRiskThresholds]    Script Date: 5/25/2025 7:10:36 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RefRiskThresholds](
	[ThresholdId] [int] IDENTITY(1,1) NOT NULL,
	[MinRatio] [decimal](5, 2) NOT NULL,
	[MaxRatio] [decimal](5, 2) NULL,
	[RiskCategory] [varchar](20) NOT NULL,
	[IsEligible] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ThresholdId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO



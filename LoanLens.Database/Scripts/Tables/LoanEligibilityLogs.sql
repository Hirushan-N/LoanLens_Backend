USE [LoanLens_DB]
GO

ALTER TABLE [dbo].[LoanEligibilityLogs] DROP CONSTRAINT [DF__LoanEligi__Check__4CA06362]
GO

/****** Object:  Table [dbo].[LoanEligibilityLogs]    Script Date: 5/25/2025 7:07:40 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LoanEligibilityLogs]') AND type in (N'U'))
DROP TABLE [dbo].[LoanEligibilityLogs]
GO

/****** Object:  Table [dbo].[LoanEligibilityLogs]    Script Date: 5/25/2025 7:07:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[LoanEligibilityLogs](
	[LogId] [int] IDENTITY(1,1) NOT NULL,
	[LoanAmount] [decimal](18, 2) NULL,
	[InterestRate] [decimal](5, 2) NULL,
	[TenureMonths] [int] NULL,
	[MonthlyIncome] [decimal](18, 2) NULL,
	[EMI] [decimal](18, 2) NULL,
	[EMIRatio] [decimal](12, 2) NULL,
	[RiskCategory] [varchar](20) NULL,
	[IsEligible] [bit] NULL,
	[CheckedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[LogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[LoanEligibilityLogs] ADD  DEFAULT (getdate()) FOR [CheckedAt]
GO



USE [LoanLens_DB]
GO

ALTER TABLE [dbo].[SystemErrorLogs] DROP CONSTRAINT [DF__SystemErr__Logge__5070F446]
GO

/****** Object:  Table [dbo].[SystemErrorLogs]    Script Date: 5/25/2025 7:14:35 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SystemErrorLogs]') AND type in (N'U'))
DROP TABLE [dbo].[SystemErrorLogs]
GO

/****** Object:  Table [dbo].[SystemErrorLogs]    Script Date: 5/25/2025 7:14:35 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SystemErrorLogs](
	[ErrorId] [int] IDENTITY(1,1) NOT NULL,
	[Layer] [varchar](50) NULL,
	[Location] [varchar](255) NULL,
	[ErrorMessage] [nvarchar](max) NULL,
	[StackTrace] [nvarchar](max) NULL,
	[LoggedAt] [datetime] NULL,
	[RequestPayload] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[ErrorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[SystemErrorLogs] ADD  DEFAULT (getdate()) FOR [LoggedAt]
GO



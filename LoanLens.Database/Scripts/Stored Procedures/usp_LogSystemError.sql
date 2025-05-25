USE [LoanLens_DB]
GO

/****** Object:  StoredProcedure [dbo].[usp_LogSystemError]    Script Date: 5/25/2025 7:17:38 PM ******/
DROP PROCEDURE [dbo].[usp_LogSystemError]
GO

/****** Object:  StoredProcedure [dbo].[usp_LogSystemError]    Script Date: 5/25/2025 7:17:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_LogSystemError]
    @Layer VARCHAR(50),
    @Location VARCHAR(255),
    @ErrorMessage NVARCHAR(MAX),
    @StackTrace NVARCHAR(MAX) = NULL,
    @RequestPayload NVARCHAR(MAX) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO SystemErrorLogs (Layer, Location, ErrorMessage, StackTrace, RequestPayload)
    VALUES (@Layer, @Location, @ErrorMessage, @StackTrace, @RequestPayload);
END;
GO



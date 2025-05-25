USE [LoanLens_DB]
GO

/****** Object:  StoredProcedure [dbo].[usp_CalculateLoanEligibility]    Script Date: 5/25/2025 7:16:16 PM ******/
DROP PROCEDURE [dbo].[usp_CalculateLoanEligibility]
GO

/****** Object:  StoredProcedure [dbo].[usp_CalculateLoanEligibility]    Script Date: 5/25/2025 7:16:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_CalculateLoanEligibility]
    @LoanAmount DECIMAL(18,2),
    @InterestRate DECIMAL(5,2),
    @TenureMonths INT,
    @MonthlyIncome DECIMAL(18,2)
AS
BEGIN
    SET NOCOUNT ON;

    --EMI calculation
    DECLARE @MonthlyRate DECIMAL(18,6) = @InterestRate / (12 * 100);
    DECLARE @EMI DECIMAL(18,2) = 
        (@LoanAmount * @MonthlyRate * POWER(1 + @MonthlyRate, @TenureMonths)) /
        (POWER(1 + @MonthlyRate, @TenureMonths) - 1);

    --ratio
    DECLARE @EMIRatio DECIMAL(12,2) = CASE 
        WHEN @MonthlyIncome = 0 THEN 0 
        ELSE (@EMI / @MonthlyIncome) * 100 
    END;

    --risk category check
    DECLARE @Risk VARCHAR(20);
    DECLARE @IsEligible BIT;

    SELECT TOP 1
        @Risk = RiskCategory,
        @IsEligible = IsEligible
    FROM RefRiskThresholds
    WHERE @EMIRatio >= MinRatio
      AND (@EMIRatio <= MaxRatio OR MaxRatio IS NULL);

   IF @Risk IS NULL
    BEGIN
        SET @Risk = 'Undetermined';
        SET @IsEligible = 0;
    END

    --Log
    INSERT INTO LoanEligibilityLogs (
        LoanAmount, InterestRate, TenureMonths, MonthlyIncome,
        EMI, EMIRatio, RiskCategory, IsEligible
    )
    VALUES (
        @LoanAmount, @InterestRate, @TenureMonths, @MonthlyIncome,
        @EMI, @EMIRatio, @Risk, @IsEligible
    );

    SELECT 
        @EMI AS EMI,
        @EMIRatio AS EMIRatio,
        @Risk AS RiskCategory,
        @IsEligible AS IsEligible;
END;
GO



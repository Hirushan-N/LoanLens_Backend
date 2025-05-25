using System;
using System.Data;
using System.Data.SqlClient;
using System.Text.Json;
using LoanLens.Domain.DTOs;
using LoanLens.Infrastructure.Helpers;
using LoanLens.Infrastructure.Interfaces;
using Microsoft.Extensions.Configuration;

namespace LoanLens.Infrastructure.Repositories;

public class LoanRepository : ILoanRepository
{
    private readonly IConfiguration _config;
    private readonly DbLogger _dbLogger;

    public LoanRepository(IConfiguration config)
    {
        _config = config ?? throw new ArgumentNullException(nameof(config));
        _dbLogger = new DbLogger(config);
    }

    public LoanResultDto CheckEligibility(LoanRequestDto request)
    {
        string payload = request != null ? JsonSerializer.Serialize(request) : "null";

        if (request == null)
        {
            _dbLogger.LogError("Repository", "Loan request was null.", null, payload);
            throw new ArgumentNullException(nameof(request), "Loan request data cannot be null.");
        }

        var result = new LoanResultDto();

        try
        {
            using (var conn = new SqlConnection(_config.GetConnectionString("Default")))
            using (var cmd = new SqlCommand("usp_CalculateLoanEligibility", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@LoanAmount", request.LoanAmount);
                cmd.Parameters.AddWithValue("@InterestRate", request.InterestRate);
                cmd.Parameters.AddWithValue("@TenureMonths", request.TenureMonths);
                cmd.Parameters.AddWithValue("@MonthlyIncome", request.MonthlyIncome);

                conn.Open();

                using (var reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        result.EMI = reader["EMI"] != DBNull.Value ? Convert.ToDecimal(reader["EMI"]) : 0;
                        result.EMIRatio = reader["EMIRatio"] != DBNull.Value ? Convert.ToDecimal(reader["EMIRatio"]) : 0;
                        result.RiskCategory = reader["RiskCategory"]?.ToString() ?? "Unknown";
                        result.IsEligible = reader["IsEligible"] != DBNull.Value && Convert.ToBoolean(reader["IsEligible"]);
                    }
                    else
                    {
                        var msg = "Stored procedure did not return any result.";
                        _dbLogger.LogError("Repository", msg, null, payload);
                        throw new DataException(msg);
                    }
                }
            }
        }
        catch (SqlException sqlEx)
        {
            _dbLogger.LogError("Repository", sqlEx.Message, sqlEx.StackTrace, payload);
            throw new Exception("Database error while checking loan eligibility.", sqlEx);
        }
        catch (Exception ex)
        {
            _dbLogger.LogError("Repository", ex.Message, ex.StackTrace, payload);
            throw new Exception("Unexpected error occurred in LoanRepository.", ex);
        }

        return result;
    }
}

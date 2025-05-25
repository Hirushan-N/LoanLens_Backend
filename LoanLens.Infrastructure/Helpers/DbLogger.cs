using System;
using System.Data;
using System.Data.SqlClient;
using Microsoft.Extensions.Configuration;

namespace LoanLens.Infrastructure.Helpers;

public class DbLogger
{
    private readonly string _connectionString;

    public DbLogger(IConfiguration config)
    {
        _connectionString = config.GetConnectionString("Default");
    }

    public void LogError(string layer,string message,string stackTrace,string? requestPayload = null,[System.Runtime.CompilerServices.CallerMemberName] string location = "")
    {
        try
        {
            using (var conn = new SqlConnection(_connectionString))
            using (var cmd = new SqlCommand("usp_LogSystemError", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@Layer", layer);
                cmd.Parameters.AddWithValue("@Location", location);
                cmd.Parameters.AddWithValue("@ErrorMessage", message);
                cmd.Parameters.AddWithValue("@StackTrace", (object?)stackTrace ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@RequestPayload", (object?)requestPayload ?? DBNull.Value);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }
        catch
        {
            // Prevent recursive logging
        }
    }

}

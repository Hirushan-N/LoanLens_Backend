# LoanLens API

This ASP.NET Core Web API calculates loan eligibility based on EMI-to-income ratio and dynamically categorizes risk.

---

## 📥 Clone the Repository

```bash
git clone https://github.com/your-username/LoanLens_API.git
```

---

## 🛠️ Database Setup

1. Open SQL Server Management Studio.
2. Run the following scripts (located in "\LoanLens_Backend\LoanLens.Database\Scripts"):

   - `LoanLens_DB.sql` – Creates the database and required tables.
   - `LoanEligibilityLogs.sql` – Adds the LoanEligibilityLogs table.
   - `RefRiskThresholds.sql` – Adds the RefRiskThresholds table.
   - `SystemErrorLogs.sql` – Adds the SystemErrorLogs table.
   - `LoanEligibilityLogs.sql` – Adds the logging table.
    - `usp_CalculateLoanEligibility.sql` – Adds the usp_CalculateLoanEligibility SP.
    - `usp_LogSystemError.sql` – Adds the usp_LogSystemError SP.
   - `RefRiskThresholds_Data.sql` – Inserts sample risk classification data.

> Ensure your connection string in `appsettings.json` points to your SQL Server instance and `LoanLens_DB`.

---

## 📄 Sample Request JSON (For Swagger Testing)

Use this sample in the Swagger UI to test the API:

```json
{
  "loanAmount": 2400000,
  "interestRate": 10,
  "tenureMonths": 24,
  "monthlyIncome": 100000
}
```

Expected response will include:

- `EMI`
- `EMIRatio`
- `RiskCategory`
- `IsEligible`

---

## 🔗 Related Client App

Once API is running, set up the client here:

**Client Repo →** [LoanLens_Client](https://github.com/Hirushan-N/loanlens-client)

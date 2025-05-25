using System.ComponentModel.DataAnnotations;

namespace LoanLens.Domain.DTOs
{
    public class LoanRequestDto
    {
        [Required]
        [Range(1000, double.MaxValue, ErrorMessage = "LoanAmount must be at least 1,000.")]
        public decimal LoanAmount { get; set; }

        [Required]
        [Range(1, 100, ErrorMessage = "InterestRate must be between 1% and 100%.")]
        public decimal InterestRate { get; set; }

        [Required]
        [Range(1, 480, ErrorMessage = "TenureMonths must be between 1 and 480.")]
        public int TenureMonths { get; set; }

        [Required]
        [Range(1, double.MaxValue, ErrorMessage = "MonthlyIncome must be greater than 0.")]
        public decimal MonthlyIncome { get; set; }

    }
}

namespace LoanLens.Domain.DTOs
{
    public class LoanResultDto
    {
        public decimal EMI { get; set; }
        public decimal EMIRatio { get; set; }
        public string? RiskCategory { get; set; }
        public bool IsEligible { get; set; }
    }
}

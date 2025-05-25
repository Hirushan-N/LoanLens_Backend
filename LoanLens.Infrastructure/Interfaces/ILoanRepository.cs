using LoanLens.Domain.DTOs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LoanLens.Infrastructure.Interfaces
{
    public interface ILoanRepository
    {
        LoanResultDto CheckEligibility(LoanRequestDto request);
    }
}

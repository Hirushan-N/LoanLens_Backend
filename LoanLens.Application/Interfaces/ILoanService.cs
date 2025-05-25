using LoanLens.Domain.DTOs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LoanLens.Application.Interfaces
{
    public interface ILoanService
    {
        LoanResultDto EvaluateLoan(LoanRequestDto request);
    }
}

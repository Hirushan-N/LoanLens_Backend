using LoanLens.Application.Interfaces;
using LoanLens.Domain.DTOs;
using LoanLens.Infrastructure.Interfaces;

namespace LoanLens.Application.Services;

public class LoanService : ILoanService
{
    private readonly ILoanRepository _repository;

    public LoanService(ILoanRepository repository)
    {
        _repository = repository;
    }

    public LoanResultDto EvaluateLoan(LoanRequestDto request)
    {
        return _repository.CheckEligibility(request);
    }
}

using Microsoft.AspNetCore.Mvc;
using LoanLens.Application.Interfaces;
using LoanLens.Domain.DTOs;
using System;

namespace LoanLens.API.Controllers;

[ApiController]
[Route("api/[controller]")]
public class LoanController : ControllerBase
{
    private readonly ILoanService _loanService;

    public LoanController(ILoanService loanService)
    {
        _loanService = loanService;
    }

    [HttpPost("check-eligibility")]
    public IActionResult CheckEligibility([FromBody] LoanRequestDto request)
    {
        try
        {
            if (request == null)
            {
                return BadRequest("Request body cannot be null.");
            }

            if (!ModelState.IsValid)
            {
                return BadRequest(new
                {
                    message = "Validation failed.",
                    errors = ModelState.Values
                        .SelectMany(v => v.Errors)
                        .Select(e => e.ErrorMessage)
                        .ToList()
                });
            }

            var result = _loanService.EvaluateLoan(request);

            if (result == null)
            {
                return StatusCode(500, "Loan eligibility check failed. No result was returned.");
            }

            return Ok(result);
        }
        catch (ArgumentNullException ex)
        {
            return BadRequest(new
            {
                message = ex.Message,
                source = ex.Source
            });
        }
        catch (Exception ex)
        {
            return StatusCode(500, new
            {
                message = "An unexpected error occurred while processing the request.",
                detail = ex.Message
            });
        }
    }
}

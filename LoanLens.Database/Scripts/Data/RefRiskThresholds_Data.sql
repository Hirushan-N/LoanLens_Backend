INSERT INTO RefRiskThresholds (MinRatio, MaxRatio, RiskCategory, IsEligible)
VALUES
(0.00, 30.00, 'Low Risk', 1),
(30.01, 40.00, 'Medium Risk', 1),
(40.01, NULL, 'High Risk', 0);
GO
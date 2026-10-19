--Q2 Show the revenue split by each payment method, along with total visits.

SELECT d.PaymentMethod, COUNT(p.VisitID) AS Total_Visits,  SUM(p.BillAmount) AS Total_Revenue
FROM PatientVisits p
JOIN Dim_PaymentMethod d
ON p.PaymentMethodID = d.PaymentMethodID
GROUP BY d.PaymentMethod


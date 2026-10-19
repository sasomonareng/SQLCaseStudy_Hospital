--Q4. Find total revenue and number of visits for each department.

SELECT 
    d.DepartmentName,
    SUM(p.BillAmount) AS TotalRevenue,
    COUNT(p.VisitID) AS Number_Of_Visits
FROM 
    PatientVisits p
JOIN 
    Dim_Department d ON p.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName
ORDER BY TotalRevenue DESC


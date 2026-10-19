--Q5 Rank departments based on their total revenue within each department category

SELECT * 
FROM
PatientVisits p

SELECT *
FROM
Dim_Department d



WITH DepartmentRevenue AS(
SELECT d.DepartmentName, d.DepartmentCategory, SUM(p.BillAmount) AS Revenue
FROM PatientVisits p
JOIN Dim_Department d
ON p.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentCategory, d.DepartmentName
)

SELECT *, RANK() OVER (PARTITION BY DepartmentCategory ORDER BY Revenue DESC) AS Revenue_Rank
FROM DepartmentRevenue
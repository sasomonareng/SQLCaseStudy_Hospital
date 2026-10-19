--Q6 For each department, find the average satisfaction score and average wait time

SELECT d.DepartmentName, AVG(p.SatisfactionScore) AS Average_Satisfaction_Score, AVG(p.WaitTimeMinutes) AS Average_Wait_Time
FROM PatientVisits p
JOIN DIM_Department_Clean d
ON p.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName
ORDER BY Average_Wait_Time
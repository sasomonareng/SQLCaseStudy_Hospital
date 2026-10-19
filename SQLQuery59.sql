--Q9. Find the doctors with the highest average satisfaction score (minimum 100 visits).


SELECT * 
FROM PatientVisits p;




WITH Satisfaction AS (
SELECT p.VisitID, d.DoctorID, FirstName + ' ' + LastName AS Full_Name, SatisfactionScore
FROM PatientVisits p
JOIN Dim_Doctor d
ON p.DoctorID = d.DoctorID
),

AverageSatisfaction AS(
SELECT  Full_Name, CAST(AVG(SatisfactionScore) AS DECIMAL(10,2)) AS Average_Satisfaction_Score, COUNT(VisitID) AS Total_Visits
FROM  Satisfaction

GROUP BY DoctorID, Full_Name
)

SELECT Full_Name, Average_Satisfaction_Score, Total_Visits  
FROM AverageSatisfaction 
WHERE Total_Visits  > 100
ORDER BY Average_Satisfaction_Score DESC



SELECT d.DoctorID, d.FirstName + ' ' + d.LastName AS DoctorName,
		COUNT(v.VisitID) AS TotalVisits,
		CAST(AVG(v.SatisfactionScore) AS DECIMAL(10,2)) AS AvgSatisfactionScore
FROM Dim_Doctor d
JOIN PatientVisits v
ON d.DoctorID = v.DoctorID
GROUP BY d.DoctorID, d.FirstName, d.LastName
HAVING COUNT(v.VisitID) > 100

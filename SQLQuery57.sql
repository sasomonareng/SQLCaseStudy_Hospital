--Q7 Compare the total number of hospital visits on weekdays vs weekends

WITH HospitalVisits AS (
SELECT VisitID, VisitDate,
CASE 
	WHEN DATEPART(weekday, VisitDate) IN (1, 7) THEN 'Weekend Day'
	ELSE 'Weekday'
END AS Day_Type
FROM
	PatientVisits p
)
SELECT Day_Type, COUNT(VisitID) AS Number_Of_Visits
FROM HospitalVisits
GROUP BY Day_Type 


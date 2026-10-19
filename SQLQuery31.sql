--Q3 Categorize patients into age groups and calculate the average bill amount for each age band.(Assume age at time of visit based on VisitDate.) 

SELECT * FROM Dim_Doctor;


SELECT * 
FROM PatientVisits p
JOIN Dim_Patient_Clean d
ON p.PatientID = d.PatientID





SELECT * FROM Dim_Patient_Clean;
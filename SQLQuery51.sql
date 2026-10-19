--Q1 For each doctor, count how many distinct patients they have treated

SELECT * FROM Dim_Doctor;
SELECT * FROM PatientVisits;
SELECT * FROM Dim_Patient_Clean;
 

WITH PatientTreatment AS 
(
SELECT  p.PatientID, dp.FullName AS Patient_Name,
		d.DoctorID, d.FirstName, 
		d.LastName, 
		d.Gender, 
		d.ExperienceYears
		
 FROM PatientVisits p
 JOIN Dim_Doctor d
 ON p.DoctorID = d.DoctorID
 JOIN DIM_Patient_Clean dp
 ON p.PatientID = dp.PatientID
 --ORDER BY d.FirstName, d.LastName, d.DoctorID, dp.FullName
 )
 
SELECT  DoctorID, 
		FirstName + ' ' + LastName AS DoctorName, 
		COUNT(DISTINCT PatientID) AS Number_Of_Patients_Treated  --OVER (PARTITION BY DoctorID ) AS Number_Of_Patients
FROM	PatientTreatment 
GROUP BY DoctorID, FirstName, LastName 
ORDER BY Number_Of_Patients_Treated DESC



SELECT  d.DoctorID, 
		d.FirstName + ' ' + d.LastName AS DoctorName, 
		COUNT(DISTINCT p.PatientID) AS Number_Of_Patients_Treated
 FROM PatientVisits p
 JOIN Dim_Doctor d
 ON p.DoctorID = d.DoctorID
 JOIN DIM_Patient_Clean dp
 ON p.PatientID = dp.PatientID
 GROUP BY d.DoctorID, d.FirstName, d.LastName
 ORDER BY Number_Of_Patients_Treated DESC



		
		
		
 
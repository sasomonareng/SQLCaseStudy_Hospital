--Q10. Identify the most commonly prescribed treatment for each diagnosis.

WITH Treatment AS(
SELECT d.DiagnosisName, t.TreatmentName, COUNT(*) AS Number_Of_Prescriptions,
RANK() OVER (PARTITION BY d.DiagnosisName ORDER BY COUNT(*) DESC) AS rn
FROM PatientVisits p
JOIN Dim_Diagnosis d
ON d.DiagnosisID = p.DiagnosisID
JOIN Dim_Treatment t
ON p.TreatmentID = t.TreatmentID
GROUP BY d.DiagnosisName, t.TreatmentName
)

SELECT DiagnosisName, TreatmentName, Number_Of_Prescriptions
FROM Treatment
WHERE rn = 1








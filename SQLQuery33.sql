--Q3 Categorise patients into age groups and calculate the average bill amount for each band. (Assume age at time of visit based on VisitDate)

WITH PatientAges AS(
SELECT p.PatientID, 
       p.BillAmount,
       DATEDIFF(YEAR, DOB, p.VisitDate) -
       CASE
            WHEN DATEADD(YEAR, DATEDIFF(YEAR, DOB, p.VisitDate), DOB) > p.VisitDate
            THEN 1
            ELSE 0
       END AS NumericAge
FROM
DIM_Patient_Clean d
JOIN PatientVisits p
ON d.PatientID = p.PatientID
),

CategorizedBands AS (
    SELECT 
        BillAmount,
        CASE 
            WHEN NumericAge < 18 THEN '01. Child (Under 18)'
            WHEN NumericAge BETWEEN 18 AND 35 THEN '02. Young Adult (18-35)'
            WHEN NumericAge BETWEEN 36 AND 60 THEN '03. Middle-Aged (36-60)'
            ELSE '04. Senior (61+)'
        END AS Age_Group
    FROM 
        PatientAges
)

SELECT 
    Age_Group,
    COUNT(*) AS Total_Patients_In_Band,
    CAST(AVG(BillAmount) AS DECIMAL(10, 2)) AS Average_Bill_Amount
FROM 
    CategorizedBands
GROUP BY 
    Age_Group
ORDER BY 
    Age_Group;








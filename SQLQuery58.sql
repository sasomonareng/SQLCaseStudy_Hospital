--Q8. For each month, calculate total visits and a running cumulative total of visits.

WITH MonthlyVisits AS (
    SELECT 
        YEAR(VisitDate) AS Visit_Year, 
        -- 🔢 Added this as a helper column so we can sort chronologically later
        MONTH(VisitDate) AS Visit_Month_Number, 
        DATENAME(month, VisitDate) AS Visit_Month,
        COUNT(VisitID) AS Monthly_Visits
    FROM 
        PatientVisits 
    GROUP BY 
        YEAR(VisitDate), 
        MONTH(VisitDate), -- 🔧 Added to the group
        DATENAME(month, VisitDate)
)
SELECT 
    Visit_Year,
    Visit_Month, 
    Monthly_Visits, 
    -- ✅ Fixed window function to use our clean month number for the running total
    SUM(Monthly_Visits) OVER (
        ORDER BY Visit_Year, Visit_Month_Number
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS Cumulative_Total_Visits
FROM 
    MonthlyVisits
-- 🎯 This absolute bottom clause forces the chronological January-December sorting
ORDER BY 
    Visit_Year, 
    Visit_Month_Number;



WITH MonthlyVisits AS(
SELECT 
    DATEFROMPARTS(YEAR(VisitDate), MONTH(VisitDate), 1) AS MonthStart,
    COUNT(*) AS TotalVisits
FROM PatientVisits
GROUP BY YEAR(VisitDate), MONTH(VisitDate)
ORDER BY MonthStart
)

SELECT MonthStart, TotalVisits,
    SUM(TotalVisits) OVER (ORDER BY MonthStart
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS CumulativeVisits
FROM MonthlyVisits
ORDER BY MonthStart




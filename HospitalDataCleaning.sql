-- Data Cleaning (Patient Table)
---- Remove patient rows where FirstName is missing
---- Standardize FirstName and LastName to proper case and create a new FullName column
---- Gender values should be either Male or Female
---- Split CityStateCountry into City, State and Country columns

CREATE TABLE DIM_Patient_Clean (
	PatientID varchar(20) PRIMARY KEY,
	FullName varchar(120),
	Gender varchar(10),
	DOB date,
	City varchar(50),
	State varchar(50),
	Country varchar(50)
);

INSERT INTO DIM_Patient_Clean (
		PatientID, FullName, Gender, DOB, City, State, Country
		)

SELECT
	p.PatientID,
	(UPPER(LEFT(TRIM(p.FirstName), 1)) + LOWER(SUBSTRING(TRIM(p.FirstName), 2, LEN(p.FirstName))))
    + ' ' +
    (UPPER(LEFT(TRIM(p.LastName), 1)) + LOWER(SUBSTRING(TRIM(p.LastName), 2, LEN(p.LastName)))) AS FullName,
	CASE WHEN p.Gender = 'M' then 'Male'
		 WHEN p.Gender = 'F' then 'Female'
	ELSE p.Gender
	END AS Gender,
	p.DOB,
	
	-- 1. Grab the 3rd piece from the right (City)
    PARSENAME(REPLACE(CityStateCountry, ',', '.'), 3) AS City,
    
    -- 2. Grab the 2nd piece from the right (State)
    PARSENAME(REPLACE(CityStateCountry, ',', '.'), 2) AS State,
    
    -- 3. Grab the 1st piece from the right (Country)
    PARSENAME(REPLACE(CityStateCountry, ',', '.'), 1) AS Country

FROM Dim_Patient p
WHERE p.FirstName IS NOT NULL;


--Data Cleaning (Department Table)
---- Remove departments where DepartmentCategory is missing
---- Drop HOD and DepartmentName columns
---- Use Specialization as DepartMENTName column

CREATE TABLE DIM_Department_Clean (
	DepartmentID Varchar(20) Primary Key,
	DepartmentName Varchar(100),
	DepartmentCategory Varchar(100)
)

INSERT INTO DIM_Department_Clean (
	DepartmentID, DepartmentName, DepartmentCategory
)

SELECT d.DepartmentID, d.Specialization AS DepartmentName, d.DepartmentCategory
FROM Dim_Department d
WHERE d.DepartmentCategory IS NOT NULL

SELECT * FROM DIM_Department_Clean;




-- Data Cleaning (Patient Visits Table)
--- Merge all yearly visit tables (2020-2025) into one consolidated PatientVisits table

CREATE TABLE PatientVisits (
	VisitID				VARCHAR(20) PRIMARY KEY,
	PatientID			VARCHAR(20),
	DoctorID			VARCHAR(20),
	DepartmentID		VARCHAR(20),
	DiagnosisID			VARCHAR(20),
	TreatmentID			VARCHAR(20),
	PaymentMethodID		VARCHAR(20),
	VisitDate			DATE,
	VisitTIME			TIME,
	DischargeDate		DATE,
	BillAmount			DECIMAL(18,2),
	InsuranceAmount		DECIMAL(18,2),
	SatisfactionScore	INT,
	WaitTimeMinutes		INT
	-- Optional: add FOREIGN KEYs here if you want to point to clean dimensions later
	FOREIGN KEY (PatientID)					REFERENCES Dim_Patient_Clean(PatientID),
	FOREIGN KEY (DoctorID)					REFERENCES Dim_Doctor(DoctorID),
	FOREIGN KEY (DepartmentID)				REFERENCES Dim_Department_Clean(DepartmentID),
	FOREIGN KEY (DiagnosisID)				REFERENCES Dim_Diagnosis(DiagnosisID),
	FOREIGN KEY (TreatmentID)				REFERENCES Dim_Treatment(TreatmentID),
	FOREIGN KEY (PaymentMethodID)			REFERENCES Dim_PaymentMethod(PaymentMethodID),
);


INSERT INTO PatientVisits (
	VisitID, PatientID, DoctorID, DepartmentID, DiagnosisID, TreatmentID,
	PaymentMethodID, VisitDate,	VisitTIME, DischargeDate, BillAmount, InsuranceAmount,		
	SatisfactionScore, WaitTimeMinutes
)


SELECT
	VisitID, PatientID, DoctorID, DepartmentID, DiagnosisID, TreatmentID,
	PaymentMethodID, VisitDate,	VisitTIME, DischargeDate, BillAmount, InsuranceAmount,		
	SatisfactionScore, WaitTimeMinutes	
FROM PatientVisits_2020_2021

UNION ALL

SELECT
	VisitID, PatientID, DoctorID, DepartmentID, DiagnosisID, TreatmentID,
	PaymentMethodID, VisitDate,	VisitTIME, DischargeDate, BillAmount, InsuranceAmount,		
	SatisfactionScore, WaitTimeMinutes	
FROM PatientVisits_2022_2023

UNION ALL

SELECT
	VisitID, PatientID, DoctorID, DepartmentID, DiagnosisID, TreatmentID,
	PaymentMethodID, VisitDate,	VisitTIME, DischargeDate, BillAmount, InsuranceAmount,		
	SatisfactionScore, WaitTimeMinutes	
FROM PatientVisits_2024

UNION ALL

SELECT
	VisitID, PatientID, DoctorID, DepartmentID, DiagnosisID, TreatmentID,
	PaymentMethodID, VisitDate,	VisitTIME, DischargeDate, BillAmount, InsuranceAmount,		
	SatisfactionScore, WaitTimeMinutes	
FROM PatientVisits_2025;









    







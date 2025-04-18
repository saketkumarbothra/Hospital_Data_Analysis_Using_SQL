DROP TABLE IF EXISTS hospital_data;

CREATE TABLE IF NOT EXISTS hospital_data(
Hospital_Name VARCHAR(50),
Location VARCHAR(50),
Department VARCHAR(20),
Doctors_Count INTEGER,
Patients_Count INTEGER,
Admission_Date DATE,
Discharge_Date DATE,
Medical_Expenses NUMERIC(10,2));

SELECT * FROM hospital_data;

COPY hospital_data (Hospital_Name, Location, Department, Doctors_Count, Patients_Count, Admission_Date, Discharge_Date, Medical_Expenses)
FROM 'K:\Hospital_Data.csv'
CSV HEADER;

SELECT * FROM hospital_data;

--1. Write an SQL query to find the total number of patients across all hospitals.

SELECT SUM(patients_count) AS total_patients_across_hospitals FROM hospital_data;

--2. Retrieve the average count of doctors available in each hospital.

SELECT SUM(doctors_count)/COUNT(DISTINCT(hospital_name)) AS average_doctors_per_hospital FROM hospital_data;

--3. Find the top 3 hospital departments that have the highest number of patients.  

SELECT department, SUM(patients_count) AS total_patients_in_department FROM hospital_data GROUP BY department ORDER BY total_patients_in_department DESC LIMIT 3;

--4. Identify the hospital that recorded the highest medical expenses. 

SELECT * FROM hospital_data ORDER BY medical_expenses DESC LIMIT 1;

--5. Calculate the average medical expenses per day for each hospital. 

SELECT hospital_name, AVG(medical_expenses/(discharge_date-admission_date)) FROM hospital_data GROUP BY hospital_name;

--6. Find the patient with the longest stay by calculating the difference between Discharge Date and Admission Date.

SELECT hospital_name, location, department, discharge_date-admission_date AS stay_period FROM hospital_data ORDER BY stay_period DESC LIMIT 1;

--7. Count the total number of patients treated in each city.  

SELECT location, SUM(patients_count) AS city_wise_patients_treated FROM hospital_data GROUP BY location;

--8. Calculate the average number of days patients spend in each department. 

SELECT department, AVG(discharge_date-admission_date) AS average_stay_length FROM hospital_data GROUP BY department;

--9. Find the department with the least number of patients.  

SELECT department, SUM(patients_count) AS department_wise_patients FROM hospital_data GROUP BY department ORDER BY department_wise_patients LIMIT 1;

--10. Group the data by month and calculate the total medical expenses for each month.

SELECT EXTRACT(MONTH FROM discharge_date) AS months, SUM(medical_expenses) FROM hospital_data GROUP BY months ORDER BY months;


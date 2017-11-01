--Create a table to include the ranking of the corrected normalized scores
DROP TABLE patients_response;

CREATE TABLE patient_response AS
SELECT provider_number as provider_id ,
cast(overall_rating_of_hospital_performance_rate as FLOAT) as patient_survery_response
FROM survey_responses
WHERE overall_rating_of_hospital_performance_rate not like 'Not%';


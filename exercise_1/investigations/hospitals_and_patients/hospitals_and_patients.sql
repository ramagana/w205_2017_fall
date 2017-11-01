-- transformations for Questions 4

-- Join data tables to answer questions
DROP TABLE procedures_final;

CREATE TABLE procedures_final AS
SELECT
hospitals_meta.hospital_name,
hospitals_meta.state,
hospitals_meta.provider_id ,
procedures_4.measure_id,
procedures_4.ideal_high_low,
procedures_4.normal_score,
procedures_4.rank
FROM hospitals_meta, procedures_4
WHERE hospitals_meta.provider_id = procedures_4.provider_id;

-- Create variability for transformation
DROP TABLE procedures_measures;

CREATE TABLE procedures_measures AS
SELECT
measures_meta.measure_name,
measures_meta.measure_id,
procedures_final.provider_id,
procedures_final.hospital_name,
procedures_final.normal_score
FROM procedures_final, measures_meta
WHERE procedures_final.measure_id = measures_meta.measure_id;

-- Create variability for transformation
DROP TABLE survey_variability_cor;

CREATE TABLE survey_variability_cor AS
SELECT
procedures_measures.measure_name,
procedures_measures.measure_id,
procedures_measures.hospital_name,
procedures_measures.provider_id,
procedures_measures.normal_score,
patient_response.patient_survery_response as survey_rating
FROM procedures_measures, patient_response
WHERE procedures_measures.provider_id = patient_response.provider_id
;

-- PRINT correlation between procedure variability and survey
SELECT corr(t.survey_rating_avg, t.score_average) as variability_correlation
FROM (SELECT measure_id, 
    AVG(survey_rating) as survey_rating_avg, 
    VARIANCE(normal_score) as score_average
FROM survey_variability_cor
GROUP BY measure_id) t
;

-- PRINT correlation between provider quality care and survey
SELECT corr(h.survey_rating_avg, h.score_average) as quality_correlation
FROM (SELECT provider_id, 
    AVG(survey_rating) as survey_rating_avg, 
    AVG(normal_score) as score_average
FROM survey_variability_cor
GROUP BY provider_id) h
;




-- transformations for Questions 3
-- join data tables to answer questions
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
DROP TABLE hospital_variability;

CREATE TABLE hospital_variability AS
SELECT
measures_meta.measure_name,
measures_meta.measure_id,
variance(procedures_final.normal_score) as procedure_variability
FROM procedures_final, measures_meta
WHERE procedures_final.measure_id = measures_meta.measure_id 
GROUP BY measures_meta.measure_name, measures_meta.measure_id;

-- PRINT 10 most variable procedure metrics
SELECT * 
FROM hospital_variability
ORDER BY procedure_variability DESC
limit 10;

--transformations for Questions 1

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

-- Create best_hospitals for transformation
DROP TABLE best_hospitals;

CREATE TABLE best_hospitals AS
SELECT
hospital_name,
provider_id ,
AVG(normal_score) as average_score
FROM procedures_final
GROUP BY provider_id, hospital_name;

-- PRINT 10 best sites


SELECT * 
FROM best_hospitals
ORDER BY average_score DESC
limit 10;

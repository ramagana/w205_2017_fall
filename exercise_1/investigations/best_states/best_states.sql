--transformations for Questions 2

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

-- Create best_states for transformation
DROP TABLE best_states;

CREATE TABLE best_states AS
SELECT
state,
AVG(normal_score) as average_score
FROM procedures_final
GROUP BY state;

-- PRINT 10 best sites
SELECT * 
FROM best_states
ORDER BY average_score DESC
limit 10;


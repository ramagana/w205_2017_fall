--CREATE to combine procedure tables with union
DROP TABLE procedures_1;

CREATE TABLE procedures_1 AS
SELECT x.provider_id, x.measure_id, x.score FROM
(SELECT provider_id, measure_id, cast(score as FLOAT)
FROM effective_care
UNION ALL
SELECT provider_id, measure_id, cast(score as FLOAT)
FROM readmissions) x;


-- CREATE procedures table
DROP TABLE procedures_2;

CREATE TABLE procedures_2 AS
SELECT
provider_id ,
measure_id,
score,
MAX(score) OVER(PARTITION BY measure_id) AS max_score,
MIN(score) OVER(PARTITION BY measure_id) AS min_score,
CASE WHEN measure_id IN ('IMM_2','IMM_3','OP_2',
'OP_4','OP_23','OP_29','OP_30','OP_31','STK_4','VTE_5')
       THEN 'high'
       ELSE 'low'
  END AS ideal_high_low
FROM procedures_1
WHERE score not like 'Not%' AND measure_id not like 'EDV';

--Create table to add the normalization of the scores
DROP TABLE procedures_3;

CREATE TABLE procedures_3 AS
SELECT
provider_id ,
measure_id,
score,
max_score,
min_score,
ideal_high_low,
CASE WHEN ideal_high_low = 'high'
    THEN score / max_score
    ELSE min_score/ score
END AS normal_score
FROM procedures_2;

--Create a table to include the ranking of the corrected normalized scores
DROP TABLE procedures_4;

CREATE TABLE procedures_4 AS
SELECT
provider_id ,
measure_id,
score,
max_score,
min_score,
ideal_high_low,
normal_score,
rank () over (PARTITION BY measure_id order by score desc) as rank
FROM procedures_3;

--Clean up table space by droping intermediate procedure tables

DROP TABLE procedures_1;
DROP TABLE procedures_2;
DROP TABLE procedures_3;


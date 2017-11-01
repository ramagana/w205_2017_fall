--CREATE hospitals_meta table

DROP TABLE hospitals_meta;

CREATE TABLE hospitals_meta AS
SELECT provider_id , hospital_name, state, hospital_type
FROM hospitals;

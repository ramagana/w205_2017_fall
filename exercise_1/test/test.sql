DROP TABLE measures;

CREATE EXTERNAL TABLE measures
(
measure_name string,
measure_id string,
measure_start_quarter string,
measure_start_date string,
measure_end_quarter string,
measure_end_date string
)

ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar"=',',
  "quoteChar"='"',
  "escapeChar"='\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/measures'
;

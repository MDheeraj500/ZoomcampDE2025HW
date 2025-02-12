The SQL queries in BigQuery for each question are as follows:

BigQuery SETUP:

# Creating an external table from GCS

CREATE OR REPLACE EXTERNAL TABLE 
    `bigqueryzoomcampde.zoomcampde_hw3_dataset.external_yellow_trip_data_table`
OPTIONS (
  format = 'parquet',
  uris = ['gs://dezoomcamp_hw3_2025_dm/yellow_tripdata_2024-*.parquet']
);


# Creating a materialized/regular table in BQ from the External Table

CREATE OR REPLACE TABLE 
    `bigqueryzoomcampde.zoomcampde_hw3_dataset.materialized_yellow_trip_data_table` AS
SELECT * 
FROM 
    `bigqueryzoomcampde.zoomcampde_hw3_dataset.external_yellow_trip_data_table`



Question 1:
SELECT 
    COUNT(*)
FROM
    `bigqueryzoomcampde.zoomcampde_hw3_dataset.materialized_yellow_trip_data_table`



Question 2:
SELECT
    DISTINCT COUNT(PULocationIDs )
FROM
    `bigqueryzoomcampde.zoomcampde_hw3_dataset.external_yellow_trip_data_table`

SELECT
    DISTINCT COUNT(PULocationIDs )
FROM
    `bigqueryzoomcampde.zoomcampde_hw3_dataset.materialized_yellow_trip_data_table`



Question 3:
SELECT 
    PULocationID
FROM 
    `zoomcampde_hw3_dataset.materialized_yellow_trip_data_table`

SELECT 
    PULocationID,DOLocationID 
FROM 
    `zoomcampde_hw3_dataset.materialized_yellow_trip_data_table`


Question 4:
SELECT
    COUNT(*)
FROM
    `zoomcampde_hw3_dataset.materialized_yellow_trip_data_table`
WHERE
    fare_amount=0


Question 5:
CREATE OR REPLACE TABLE 
    `bigqueryzoomcampde.zoomcampde_hw3_dataset.yellow_trip_data_partitioned`
PARTITION BY 
  DATE(tpep_dropoff_datetime) 
CLUSTER BY
  VendorID AS
SELECT * 
FROM 
    `bigqueryzoomcampde.zoomcampde_hw3_dataset.materialized_yellow_trip_data_table` 


Question 6:
SELECT 
  DISTINCT VendorID 
FROM
  `bigqueryzoomcampde.zoomcampde_hw3_dataset.yellow_trip_data_partitioned`
WHERE
  tpep_dropoff_datetime BETWEEN '2024-03-01' AND '2024-03-15'


Question 9:
SELECT * 
FROM
  `bigqueryzoomcampde.zoomcampde_hw3_dataset.materialized_yellow_trip_data_table`
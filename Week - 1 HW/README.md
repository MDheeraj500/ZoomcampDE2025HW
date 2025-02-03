This file consists of SQL queries and tf commands used for the homework:

question - 3:

During the period of October 1st 2019 (inclusive) and November 1st 2019 (exclusive), how many trips, respectively, happened:

Up to 1 mile
In between 1 (exclusive) and 3 miles (inclusive),
In between 3 (exclusive) and 7 miles (inclusive),
In between 7 (exclusive) and 10 miles (inclusive),
Over 10 miles

SQL Query:
SELECT 
    COUNT(CASE WHEN trip_distance <= 1 THEN 1 END) AS up_to_1_mile,
    COUNT(CASE WHEN trip_distance > 1 AND trip_distance <= 3 THEN 1 END) AS between_1_and_3_miles,
    COUNT(CASE WHEN trip_distance > 3 AND trip_distance <= 7 THEN 1 END) AS between_3_and_7_miles,
    COUNT(CASE WHEN trip_distance > 7 AND trip_distance <= 10 THEN 1 END) AS between_7_and_10_miles,
    COUNT(CASE WHEN trip_distance > 10 THEN 1 END) AS over_10_miles
FROM 
    green_taxi_trips
WHERE 
    TO_DATE(SUBSTRING(lpep_pickup_datetime, 1, 10), 'YYYY-MM-DD') >= '2019-10-01'
    AND TO_DATE(SUBSTRING(lpep_pickup_datetime, 1, 10), 'YYYY-MM-DD') < '2019-11-01';




question - 4:

Which was the pick up day with the longest trip distance? Use the pick up time for your calculations

SQL Query:

SELECT 
    TO_DATE(SUBSTRING(lpep_pickup_datetime, 1, 10), 'YYYY-MM-DD') AS pickup_day,
    MAX(trip_distance) AS longest_trip_distance
FROM 
    green_taxi_trips
GROUP BY 
    TO_DATE(SUBSTRING(lpep_pickup_datetime, 1, 10), 'YYYY-MM-DD')
ORDER BY 
    longest_trip_distance DESC
LIMIT 1;


question - 5:

Which were the top pickup locations with over 13,000 in total_amount (across all trips) for 2019-10-18?

SQL Query:

SELECT 
    gtz.Zone AS pickup_location,
    SUM(gtt.total_amount) AS total_revenue
FROM 
    green_taxi_trips gtt
JOIN 
    green_taxi_zones gtz
ON 
    gtt.PULocationID = gtz.LocationID
WHERE 
    TO_DATE(SUBSTRING(gtt.lpep_pickup_datetime, 1, 10), 'YYYY-MM-DD') = '2019-10-18'
GROUP BY 
    gtz.Zone
HAVING 
    SUM(gtt.total_amount) > 13000
ORDER BY 
    total_revenue DESC;


question - 6:

For the passengers picked up in October 2019 in the zone named "East Harlem North" which was the drop off zone that had the largest tip?

SQL Query:
SELECT 
    gtz_dropoff.Zone AS dropoff_zone,
    gtt.tip_amount AS largest_tip
FROM 
    green_taxi_trips gtt
JOIN 
    green_taxi_zones gtz_pickup
ON 
    gtt.PULocationID = gtz_pickup.LocationID
JOIN 
    green_taxi_zones gtz_dropoff
ON 
    gtt.DOLocationID = gtz_dropoff.LocationID
WHERE 
    gtz_pickup.Zone = 'East Harlem North'
    AND TO_DATE(SUBSTRING(gtt.lpep_pickup_datetime, 1, 10), 'YYYY-MM-DD') >= '2019-10-01'
    AND TO_DATE(SUBSTRING(gtt.lpep_pickup_datetime, 1, 10), 'YYYY-MM-DD') < '2019-11-01'
ORDER BY 
    gtt.tip_amount DESC
LIMIT 1;




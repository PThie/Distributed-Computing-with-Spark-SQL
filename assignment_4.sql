-- Create Delta table
CREATE DATABASE IF NOT EXISTS Databricks;
USE Databricks;
DROP TABLE IF EXISTS fireCallsPartitioned;

CREATE TABLE fireCallsPartitioned
USING DELTA
PARTITIONED BY (Priority)
AS
    SELECT *
    FROM fireCallsParquet;

/*
Question 1:
How many folders were created? Enter the number of records you see from the output below (include the _delta_log in your count).
Answer: 9
*/

/*
Question 2:
Delete all the records where City is null. How many records are left in the delta table?
Answer: 416869
*/

SELECT
    COUNT(*) AS num_rows
FROM
    fireCallsPartitioned
WHERE
    city IS NOT null;

/*
Question 3:
After you deleted all records where the City is null, how many files were removed? Hint: Look at operationsMetrics in the transaction log using the DESCRIBE HISTORY command.
Answer: 417419 - 416869 = 550
*/

/*
Question 4:
There are quite a few missing Call_Type_Group values. Use the UPDATE command to replace any null values with Non Life-threatening.
After you replace the null values, how many Non Life-threatening call types are there?
Answer: 302627
*/

UPDATE fireCallsPartitioned
SET `Call_Type_Group` = "Non Life-threatening"
WHERE `Call_Type_Group` is null;

SELECT
    `Call_Type_Group`,
    COUNT(`Call_Type_Group`) AS counts
FROM
    fireCallsPartitioned
GROUP BY
    `Call_Type_Group`;

/*
Question 5:
Travel back in time to the earliest version of the Delta table (version 0). How many records were there?
Answer: 417419
*/

SELECT * 
FROM fireCallsPartitioned 
    VERSION AS OF 0;

SELECT
    COUNT(*) AS counts
FROM
    fireCallsPartitioned;
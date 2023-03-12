-- Creating table

CREATE TABLE IF NOT EXISTS newTable (
    `Address` STRING,
    `City` STRING,
    `Battalion` STRING,
    `Box` STRING
)
OPTIONS (
    path "/tmp/newTableLoc"
);

/*
Question 1:
What type of table is newTable? "EXTERNAL" or "MANAGED"?
Answer: EXTERNAL
*/
DESCRIBE EXTENDED newTable

-- Populate new table with given data
INSERT INTO newTable (`Address`, `City`, `Battalion`, `Box`)
SELECT `Address`, `City`, `Battalion`, `Box`
FROM fireCallsJson
WHERE 
    `Final Priority` == 3;

/*
Question 2:
How many rows are in newTable?
Answer: 191039
*/

SELECT
    COUNT(*) as num_rows
FROM newTable;

/*
Question 3:
What is the "Battalion" of the first entry in the sorted table?
Answer: B01
*/

SELECT
  *
FROM newTable
ORDER BY
    Battalion ASC;

-- Create table with more partitions
CREATE TABLE IF NOT EXISTS newTablePartitioned
    AS
SELECT /*+ REPARTITION(256) */ * 
FROM newTable;

/*
Question 4:
Was this query faster or slower on the table with increased partitions?
Answer: 
*/
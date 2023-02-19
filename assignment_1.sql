-- Creating the table for this assignment
CREATE TABLE IF NOT EXISTS fireIncidents
USING csv
OPTIONS (
    header "true",
    path "/mnt/davis/fire-incidents/fire-incidents-2016.csv",
    inferSchema "true"
);

/*
Question 1:
What is the first value for "Incident Number"?
Answer: 16000003
*/
SELECT
    `Incident Number`
FROM
    fireIncidents
LIMIT 10;

/*
Question 2:
What is the first value for "Incident Number" on April 4th, 2016?
Answer: 16037478
*/
SELECT
    `Incident Number`,
    `Incident Date`
FROM
    fireIncidents
WHERE
    `Incident Date` = "2016-04-04";

/*
Question 3:
Is the first fire call in this table on Brooke or Conor's birthday?
Answer: Conor
*/
SELECT
    `Incident Number`,
    `Incident Date`
FROM
    fireIncidents
WHERE
    `Incident Date` = "2016-04-04" OR `Incident Date` = "2016-09-27";

/*
Question 4:
What is the "Station Area" for the first fire call in this table?
Answer: 29
*/
SELECT
    `Incident Number`,
    `Incident Date`,
    `Station Area`
FROM
    fireIncidents
WHERE
    `Incident Date` IN("2016-04-04", "2016-09-27") AND `Station Area` > "20";

/*
Question 5:
How many incidents were on Conor's birthday in 2016?
Answer: 80
*/
SELECT
    COUNT(`Incident Number`) as counts
FROM
    fireIncidents
WHERE
    `Incident Date` = "2016-04-04";

/*
Question 6:
How many fire calls had an "Ignition Cause" of "4 act of nature"?
Answer: 5
*/
SELECT
    `Ignition Cause`,
    COUNT(`Ignition Cause`)
FROM 
    fireIncidents
GROUP BY
    `Ignition Cause`;

/*
Question 7:
What is the most common "Ignition Cause"? (Put the entire string)
Answer: 2 unintentional
*/
SELECT
    `Ignition Cause`,
    COUNT(`Ignition Cause`) AS counts
FROM 
    fireIncidents
GROUP BY
    `Ignition Cause`
ORDER BY
    counts DESC;

/*
Question 8:
What is the total incidents from the two joined tables?
Answer: 847094402
*/
SELECT
    COUNT(fireIncidents.Battalion) AS counts
FROM
    fireIncidents INNER JOIN fireCalls ON fireIncidents.Battalion = fireCalls.Battalion;
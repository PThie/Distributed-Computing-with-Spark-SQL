/*
Question 1:
How many fire calls are in our fireCalls table?
Answer: 240613
*/
SELECT
    COUNT(*)
FROM
    firecalls;

/*
Question 2:
How large is our fireCalls dataset in memory?
Answer: 59.3
*/
CACHE TABLE firecalls
-- navigate to Storage in Spark UI

/*
Question 3:
Which "Unit Type" is the most common?
Answer: ENGINE
*/
SELECT
    `Unit Type`,
    COUNT(`Unit Type`) AS counts
FROM
    firecalls
GROUP BY    
    `Unit Type`
ORDER BY
    counts DESC;

/*
Question 4:
What type of transformation, wide or narrow, did the GROUP BY and ORDER BY queries result in?
Answer: Wide
*/

/*
Question 5
Looking at the query below, how many tasks are in the last stage of the last job?
Answer: 1
*/

-- check last job under Stages in Spark UI

SET spark.sql.shuffle.partitions=8;

SELECT `Neighborhooods - Analysis Boundaries`, AVG(Priority) as avgPriority
FROM fireCalls
GROUP BY `Neighborhooods - Analysis Boundaries`
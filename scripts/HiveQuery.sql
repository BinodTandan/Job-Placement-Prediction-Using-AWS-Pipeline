CREATE EXTERNAL TABLE job_placement_raw ( stdid INT, cgpa FLOAT, internship INT, project INT, certification INT, testscore INT, softskillsrating FLOAT, extra STRING, placement STRING,
ssc INT, hsc INT, placementstatus STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE LOCATION 's3://group4project1/InputFile/';


CREATE TABLE jobPlacementStage1 AS
SELECT * FROM job_placement_raw WHERE stdid IS NOT NULL;

SET hive.cli.print.header=true;
SET hive.resultset.use.unique.column.names=false;

SELECT COUNT(*) FROM jobPlacementStage1;

SELECT stdid, cgpa, internship FROM jobPlacementStage1 WHERE internship>=1;

SELECT * FROM jobPlacementStage1 WHERE cgpa>7;


SELECT COUNT(stdid) FROM jobPlacementStage1 WHERE placementstatus = 'Placed';

 SELECT stdid, placement, placementstatus FROM jobPlacementStage1 WHERE placement='Yes' AND placementstatus='NotPlaced';
 
SELECT COUNT(stdid) AS std_count, placementstatus FROM jobPlacementStage1 GROUP BY placementstatus;


CREATE TABLE job_placement_cleaned ( stdid INT, cgpa FLOAT, internship INT, project INT, certification INT, testscore INT, softskillsrating FLOAT, extra INT, placement INT,
ssc INT, hsc INT, placementstatus INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE;
	
INSERT OVERWRITE TABLE job_placement_cleaned
SELECT stdid, cgpa, internship, project, certification, testscore, softskillsrating, CASE WHEN extra = 'Yes' THEN 1 ELSE 0 END AS extra, CASE WHEN placement = 'Yes' THEN 1 ELSE 0 END AS placement,
ssc, hsc, CASE WHEN placementstatus = 'Placed' THEN 1 ELSE 0 END AS placementstatus FROM job_placement_raw;

SELECT COUNT(*) AS Null_Count FROM job_placement_cleaned WHERE cgpa IS NULL;


SELECT COUNT(DISTINCT stdid) FROM job_placement_cleaned;

CREATE TABLE job_placement_cleaned1 AS 
SELECT *, RANK() OVER(ORDER BY ( cgpa + testscore) DESC) AS RANK
FROM job_placement_cleaned;


SELECT MIN(cgpa) as min_value FROM job_placement_cleaned1;


SELECT MAX(cgpa) as min_value FROM job_placement_cleaned1;


SELECT s1.stdid as sid, s1.extra as extS, c1.rank as rank, c1.extra as extI, s1.placementstatus as place FROM jobplacementstage1 as s1 JOIN job_placem
ent_cleaned1 as c1 ON s1.stdid = c1.stdid LIMIT 10;


INSERT OVERWRITE DIRECTORY 's3://group4project1/Processed/'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
SELECT * FROM job_placement_cleaned1;

SELECT ROUND(AVG(softskillsrating), 2) AS avg_softskills, internship FROM job_placement_cleaned1 GROUP BY internship;


INSERT OVERWRITE DIRECTORY 's3://group4project1/Processed/'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
SELECT * FROM job_placement_cleaned;

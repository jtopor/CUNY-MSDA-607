/*
  Week3 tb. db create sql
*/

DROP SCHEMA IF EXISTS tb;
CREATE SCHEMA tb;
USE tb;

DROP TABLE IF EXISTS tb;

CREATE TABLE tb 
(
  country varchar(100) NOT NULL,
  year int NOT NULL,
  sex varchar(6) NOT NULL,
  child int NULL,
  adult int NULL,
  elderly int NULL
);

SELECT * FROM tb;

/* NOTE: You should edit the path of the DATA INFILE argument to comport with
		 the security restrictions and operating system of your own computer.
		 The path given here is representative of the environment you would
		 find on an MS Windows computer. Mac and Linux users should adjust accordingly*/
LOAD DATA INFILE 'c:/SQLData/tb.csv' 
INTO TABLE tb
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(country, year, sex, @child, @adult, @elderly)
SET
child = nullif(@child,-1),
adult = nullif(@adult,-1),
elderly = nullif(@elderly,-1)
;

SELECT * FROM tb WHERE elderly IS NULL;
SELECT COUNT(*) FROM tb;